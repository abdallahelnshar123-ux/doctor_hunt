import '../data/models/doctor/rating.dart';
import '../data/models/doctor/rating_dto.dart';
import 'review_dto_mapper.dart';

extension RatingDtoMapper on Rating {
  RatingDto toDto() {
    return RatingDto(
      rating: rating,
      reviews: reviews.map((e) => e.toDto()).toList(),
    );
  }
}
