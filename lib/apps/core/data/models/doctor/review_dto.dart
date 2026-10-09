import 'package:equatable/equatable.dart';

import '../../../../features/common/auth/data/models/user_dto/my_user_dto.dart';
import '../../../constants/firestore_constants.dart';

class ReviewDto extends Equatable {
  final MyUserDto reviewer;
  final int rating;
  final String? comment;

  const ReviewDto({
    required this.reviewer,
    required this.rating,
    this.comment,
  });

  factory ReviewDto.fromFireStore(Map<String, dynamic> data) {
    return ReviewDto(
      reviewer: MyUserDto.fromFireStore(
        Map<String, dynamic>.from(data[FirestoreConstants.reviewer] ?? {}),
      ),
      rating: (data[FirestoreConstants.rating] as num?)?.toInt() ?? 0,
      comment: data[FirestoreConstants.comment]?.toString(),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.reviewer: reviewer.toFireStore(),
      FirestoreConstants.rating: rating,
      if (comment != null) FirestoreConstants.comment: comment,
    };
  }

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      ReviewDto.fromFireStore(json);

  Map<String, dynamic> toJson() => toFireStore();

  @override
  List<Object?> get props => [reviewer, rating, comment];
}
