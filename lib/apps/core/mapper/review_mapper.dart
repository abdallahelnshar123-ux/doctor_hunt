import '../../features/common/auth/data/mappers/my_user_mapper.dart';
import '../data/models/doctor/review.dart';
import '../data/models/doctor/review_dto.dart';

extension ReviewMapper on ReviewDto {
  Review toDomain() {
    return Review(
      reviewer: reviewer.toUser(),
      rating: rating,
      comment: comment,
    );
  }
}
