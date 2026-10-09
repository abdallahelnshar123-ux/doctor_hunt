import 'package:equatable/equatable.dart';

import 'review.dart';

class Rating extends Equatable {
  final double rating;
  final List<Review> reviews;

  const Rating({
    required this.rating,
    required this.reviews,
  });

  @override
  List<Object?> get props => [rating, reviews];
}
