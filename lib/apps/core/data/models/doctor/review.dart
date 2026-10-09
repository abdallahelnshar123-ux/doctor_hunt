import 'package:equatable/equatable.dart';

import '../../../../features/common/auth/data/models/user/my_user.dart';

class Review extends Equatable {
  final MyUser reviewer;
  final int rating;
  final String? comment;

  const Review({
    required this.reviewer,
    required this.rating,
    this.comment,
  });

  @override
  List<Object?> get props => [reviewer, rating, comment];
}
