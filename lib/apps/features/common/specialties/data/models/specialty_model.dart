import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:equatable/equatable.dart';

class SpecialtyModel extends Equatable {
  final String id;
  final String en;
  final String ar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SpecialtyModel({
    required this.id,
    required this.en,
    required this.ar,
    this.createdAt,
    this.updatedAt,
  });

  /// Returns the localized name based on the current app language code ('ar' or 'en').
  String localizedName() {
    if (LocaleSettings.currentLocale.languageCode == 'ar') {
      return ar;
    }
    return en;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  factory SpecialtyModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};
    return SpecialtyModel(
      id: doc.id,
      en: data[FirestoreConstants.en] as String? ?? '',
      ar: data[FirestoreConstants.ar] as String? ?? '',
      createdAt: _parseDateTime(data[FirestoreConstants.createdAt]),
      updatedAt: _parseDateTime(data[FirestoreConstants.updatedAt]),
    );
  }

  factory SpecialtyModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return SpecialtyModel(
      id: id ?? map[FirestoreConstants.id] as String? ?? '',
      en: map[FirestoreConstants.en] as String? ?? '',
      ar: map[FirestoreConstants.ar] as String? ?? '',
      createdAt: _parseDateTime(map[FirestoreConstants.createdAt]),
      updatedAt: _parseDateTime(map[FirestoreConstants.updatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.en: en,
      FirestoreConstants.ar: ar,
      if (createdAt != null)
        FirestoreConstants.createdAt: createdAt!.toIso8601String(),
      if (updatedAt != null)
        FirestoreConstants.updatedAt: updatedAt!.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.en: en,
      FirestoreConstants.ar: ar,
      if (createdAt != null)
        FirestoreConstants.createdAt: Timestamp.fromDate(createdAt!),
      if (updatedAt != null)
        FirestoreConstants.updatedAt: Timestamp.fromDate(updatedAt!),
    };
  }

  SpecialtyModel copyWith({
    String? id,
    String? en,
    String? ar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SpecialtyModel(
      id: id ?? this.id,
      en: en ?? this.en,
      ar: ar ?? this.ar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, en, ar, createdAt, updatedAt];
}
