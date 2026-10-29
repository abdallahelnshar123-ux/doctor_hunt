import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability_dto.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/dto/user/doctor_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/user_roles.dart';
import 'package:doctor_hunt/apps/features/doctor/data/data_source/remote/doctor_remote_data_source.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DoctorRemoteDataSource)
class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  DoctorRemoteDataSourceImpl(this._firebaseFirestore);

  CollectionReference<DoctorDto> _getDoctorsCollection() {
    return _firebaseFirestore
        .collection(FirestoreConstants.doctorsCollection)
        .withConverter<DoctorDto>(
          fromFirestore: (snapshot, options) =>
              DoctorDto.fromJson(snapshot.data()!),
          toFirestore: (doctor, options) => doctor.toJson(),
        );
  }

  CollectionReference<DoctorDto> _getUsersCollection() {
    return _firebaseFirestore
        .collection(FirestoreConstants.usersCollection)
        .withConverter<DoctorDto>(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data();
            if (data == null) {
              throw ServerException(message: t.errors.someThingWentWrong);
            }
            final map = Map<String, dynamic>.from(data);
            if (!map.containsKey(FirestoreConstants.id) ||
                map[FirestoreConstants.id] == null ||
                (map[FirestoreConstants.id] as String).isEmpty) {
              map[FirestoreConstants.id] = snapshot.id;
            }
            return DoctorDto.fromJson(map);
          },
          toFirestore: (doctor, options) => doctor.toJson(),
        );
  }

  @override
  Future<void> addDoctor({
    required DoctorDto doctor,
    required String password,
  }) async {
    FirebaseApp? secondaryApp;
    try {
      final appName =
          'DoctorCreationApp_${DateTime.now().millisecondsSinceEpoch}';
      secondaryApp = await Firebase.initializeApp(
        name: appName,
        options: Firebase.app().options,
      );

      final auth = FirebaseAuth.instanceFor(app: secondaryApp);

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: doctor.email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) {
        throw ServerException(message: t.errors.serverError);
      }

      final newDoctor = DoctorDto(
        id: uid,
        email: doctor.email,
        name: doctor.name,
        provider: doctor.provider,
        image: doctor.image,
        phone: doctor.phone,
        adminId: doctor.adminId,
        specialty: doctor.specialty,
        active: doctor.active,
        consultationFee: doctor.consultationFee,
        rating: doctor.rating,
        availability: doctor.availability,
      );

      await _getUsersCollection().doc(uid).set(newDoctor);
      await _getDoctorsCollection().doc(uid).set(newDoctor);

      try {
        await auth.signOut();
      } catch (_) {}
    } on FirebaseAuthException catch (e) {
      if (e.code == t.eCodes.emailAlreadyInUse) {
        throw ServerException(
          message: t.errors.emailAddressAlreadyInUseByAnotherAccount,
        );
      }
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      if (e is AppException) rethrow;
      throw UnexpectedException(message: e.toString());
    } finally {
      if (secondaryApp != null) {
        try {
          await secondaryApp.delete();
        } catch (_) {}
      }
    }
  }

  @override
  Future<DoctorDto> getDoctorById(String doctorId) async {
    try {
      final userDoc = await _getUsersCollection().doc(doctorId).get();
      if (userDoc.exists && userDoc.data() != null) {
        return userDoc.data()!;
      }

      final doc = await _getDoctorsCollection().doc(doctorId).get();
      final data = doc.data();
      if (data == null) {
        throw ServerException(message: t.errors.someThingWentWrong);
      }
      return data;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Stream<List<DoctorDto>> getDoctorsStreamForAdmin({required String adminId}) {
    return _getUsersCollection()
        .where(FirestoreConstants.role, isEqualTo: UserRoles.doctor.name)
        .where(FirestoreConstants.adminId, isEqualTo: adminId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .handleError((error) {
          switch (error) {
            case FirebaseException _:
              throw ServerException(
                message: error.message ?? t.errors.serverError,
              );
            case SocketException _:
              throw NetworkException(message: t.errors.noInternet);
            default:
              throw UnexpectedException(message: error.toString());
          }
        });
  }

  @override
  Stream<List<DoctorDto>> getDoctorsStreamForPatient() {
    return _getUsersCollection()
        .where(FirestoreConstants.role, isEqualTo: UserRoles.doctor.name)
        .where(FirestoreConstants.active, isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .handleError((error) {
          switch (error) {
            case FirebaseException _:
              throw ServerException(
                message: error.message ?? t.errors.serverError,
              );
            case SocketException _:
              throw NetworkException(message: t.errors.noInternet);
            default:
              throw UnexpectedException(message: error.toString());
          }
        });
  }

  @override
  Future<void> updateDoctorActiveStatus({
    required String doctorId,
    required bool active,
  }) async {
    try {
      final userDoc = await _firebaseFirestore
          .collection(FirestoreConstants.usersCollection)
          .doc(doctorId)
          .get();
      if (userDoc.exists) {
        await _firebaseFirestore
            .collection(FirestoreConstants.usersCollection)
            .doc(doctorId)
            .update({FirestoreConstants.active: active});
      }

      final doctorDoc = await _firebaseFirestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(doctorId)
          .get();
      if (doctorDoc.exists || !userDoc.exists) {
        await _getDoctorsCollection().doc(doctorId).update({
          FirestoreConstants.active: active,
        });
      }
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> updateDoctorDetails(DoctorDto doctor) async {
    try {
      final userDoc = await _firebaseFirestore
          .collection(FirestoreConstants.usersCollection)
          .doc(doctor.id)
          .get();
      if (userDoc.exists) {
        await _getUsersCollection().doc(doctor.id).set(doctor);
      }

      final doctorDoc = await _firebaseFirestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(doctor.id)
          .get();
      if (doctorDoc.exists || !userDoc.exists) {
        await _getDoctorsCollection().doc(doctor.id).set(doctor);
      }
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> updateAvailability({
    required String doctorId,
    required DoctorAvailabilityDto availability,
  }) async {
    try {
      final userDoc = await _firebaseFirestore
          .collection(FirestoreConstants.usersCollection)
          .doc(doctorId)
          .get();
      if (userDoc.exists) {
        await _firebaseFirestore
            .collection(FirestoreConstants.usersCollection)
            .doc(doctorId)
            .update({FirestoreConstants.availability: availability.toFireStore()});
      }

      final doctorDoc = await _firebaseFirestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(doctorId)
          .get();
      if (doctorDoc.exists || !userDoc.exists) {
        await _firebaseFirestore
            .collection(FirestoreConstants.doctorsCollection)
            .doc(doctorId)
            .update({FirestoreConstants.availability: availability.toFireStore()});
      }
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> deleteDoctor({required String doctorId}) async {
    try {
      final userDoc = await _firebaseFirestore
          .collection(FirestoreConstants.usersCollection)
          .doc(doctorId)
          .get();
      if (userDoc.exists) {
        await _getUsersCollection().doc(doctorId).delete();
      }

      final doctorDoc = await _firebaseFirestore
          .collection(FirestoreConstants.doctorsCollection)
          .doc(doctorId)
          .get();
      if (doctorDoc.exists || !userDoc.exists) {
        await _getDoctorsCollection().doc(doctorId).delete();
      }
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? t.errors.serverError);
    } on SocketException {
      throw NetworkException(message: t.errors.noInternet);
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
