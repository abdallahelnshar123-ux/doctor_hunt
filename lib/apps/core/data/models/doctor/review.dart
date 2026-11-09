import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/app_user.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final AppUserEntity reviewer;
  final int rating;
  final String? comment;

  const Review({required this.reviewer, required this.rating, this.comment});

  @override
  List<Object?> get props => [reviewer, rating, comment];
}
