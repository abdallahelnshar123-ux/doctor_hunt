import 'package:equatable/equatable.dart';

import '../../../constants/firestore_constants.dart';
import 'review_dto.dart';

class RatingDto extends Equatable {
  final double rating;
  final List<ReviewDto> reviews;

  const RatingDto({
    required this.rating,
    required this.reviews,
  });

  factory RatingDto.fromFireStore(Map<String, dynamic> data) {
    return RatingDto(
      rating: (data[FirestoreConstants.rating] as num?)?.toDouble() ?? 0.0,
      reviews: (data[FirestoreConstants.reviews] as List<dynamic>?)
              ?.map((e) =>
                  ReviewDto.fromFireStore(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.rating: rating,
      FirestoreConstants.reviews: reviews.map((e) => e.toFireStore()).toList(),
    };
  }

  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      RatingDto.fromFireStore(json);

  Map<String, dynamic> toJson() => toFireStore();

  @override
  List<Object?> get props => [rating, reviews];
}
