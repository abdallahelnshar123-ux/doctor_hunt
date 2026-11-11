import 'package:equatable/equatable.dart';

import '../../../constants/firestore_constants.dart';
import 'review_dto.dart';

class RatingDto extends Equatable {
  final double rating;
  final int reviewsCount;
  final double totalRatingSum;
  final List<ReviewDto> reviews;

  const RatingDto({
    required this.rating,
    this.reviewsCount = 0,
    this.totalRatingSum = 0.0,
    this.reviews = const [],
  });

  factory RatingDto.fromFireStore(Map<String, dynamic> data) {
    final reviewsList =
        (data[FirestoreConstants.reviews] as List<dynamic>?)
            ?.map(
              (e) =>
                  ReviewDto.fromFireStore(Map<String, dynamic>.from(e as Map)),
            )
            .toList() ??
        [];
    final count =
        (data[FirestoreConstants.reviewsCount] as num?)?.toInt() ??
        reviewsList.length;
    final sum =
        (data[FirestoreConstants.totalRatingSum] as num?)?.toDouble() ??
        reviewsList.fold<double>(0.0, (acc, r) => acc + r.rating);

    return RatingDto(
      rating: (data[FirestoreConstants.rating] as num?)?.toDouble() ?? 0.0,
      reviewsCount: count,
      totalRatingSum: sum,
      reviews: reviewsList,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.rating: rating,
      FirestoreConstants.reviewsCount: reviewsCount,
      FirestoreConstants.totalRatingSum: totalRatingSum,
      if (reviews.isNotEmpty)
        FirestoreConstants.reviews: reviews
            .map((e) => e.toFireStore())
            .toList(),
    };
  }

  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      RatingDto.fromFireStore(json);

  Map<String, dynamic> toJson() => toFireStore();

  @override
  List<Object?> get props => [rating, reviewsCount, totalRatingSum, reviews];
}
