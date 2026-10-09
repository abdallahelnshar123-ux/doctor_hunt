import '../../features/common/auth/data/mappers/my_user_dto_mapper.dart';
import '../data/models/doctor/review.dart';
import '../data/models/doctor/review_dto.dart';

extension ReviewDtoMapper on Review {
  ReviewDto toDto() {
    return ReviewDto(
      reviewer: reviewer.toMyUserDto(),
      rating: rating,
      comment: comment,
    );
  }
}
