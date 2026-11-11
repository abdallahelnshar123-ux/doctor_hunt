import 'package:equatable/equatable.dart';

import 'review.dart';

class Rating extends Equatable {
  final double rating;
  final int reviewsCount;
  final double totalRatingSum;
  final List<Review> reviews;

  const Rating({
    required this.rating,
    this.reviewsCount = 0,
    this.totalRatingSum = 0.0,
    this.reviews = const [],
  });

  @override
  List<Object?> get props => [rating, reviewsCount, totalRatingSum, reviews];
}
