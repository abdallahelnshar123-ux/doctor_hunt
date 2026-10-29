import '../../features/common/auth/data/mappers/user_mapper.dart';
import '../data/models/doctor/review.dart';
import '../data/models/doctor/review_dto.dart';

extension ReviewDtoMapper on Review {
  ReviewDto toDto() {
    return ReviewDto(
      reviewer: reviewer.toDto(),
      rating: rating,
      comment: comment,
    );
  }
}
