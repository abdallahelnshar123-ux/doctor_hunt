import '../data/models/doctor/rating.dart';
import '../data/models/doctor/rating_dto.dart';
import 'review_mapper.dart';

extension RatingMapper on RatingDto {
  Rating toDomain() {
    return Rating(
      rating: rating,
      reviews: reviews.map((e) => e.toDomain()).toList(),
    );
  }
}
