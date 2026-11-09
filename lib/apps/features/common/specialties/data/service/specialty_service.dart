import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/core/exceptions/app_exceptions.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SpecialtyService {
  final FirebaseFirestore _firestore;

  SpecialtyService(this._firestore);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(FirestoreConstants.specialtiesCollection);

  /// Fetches specialties using [Source.serverAndCache].
  /// Loads instantly from local cache and syncs with the server when available.
  Future<List<SpecialtyModel>> getSpecialties() async {
    try {
      final snapshot = await _collection.get(
        const GetOptions(source: Source.serverAndCache),
      );

      return snapshot.docs
          .map((doc) => SpecialtyModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Failed to fetch specialties',
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /// Adds a new specialty to Firestore.
  /// Generates the document ID based on lowercase English name.
  Future<SpecialtyModel> addSpecialty({
    required String en,
    required String ar,
  }) async {
    try {
      final id = en.trim().toLowerCase();
      final querySnapshot = await _collection
          .where(FirestoreConstants.id, isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw const ServerException(message: 'Specialty already exists');
      }

      final now = DateTime.now();
      final specialty = SpecialtyModel(
        id: id,
        en: en.trim(),
        ar: ar.trim(),
        createdAt: now,
        updatedAt: now,
      );

      final docRef = await _collection.add(specialty.toMap());
      return specialty.copyWith(id: docRef.id);
    } on AppException {
      rethrow;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to add specialty');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /// Updates an existing specialty (en, ar, updatedAt).
  Future<SpecialtyModel> updateSpecialty(SpecialtyModel specialty) async {
    try {
      final docRef = _collection.doc(specialty.id);
      final now = DateTime.now();
      final updated = specialty.copyWith(updatedAt: now);

      await docRef.update({
        FirestoreConstants.en: updated.en.trim(),
        FirestoreConstants.ar: updated.ar.trim(),
        FirestoreConstants.updatedAt: Timestamp.fromDate(now),
      });

      return updated;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to update specialty');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
