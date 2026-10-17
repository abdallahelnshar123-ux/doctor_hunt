part of '../screens/appointments_tab.dart';

class ReviewInputWidget extends StatefulWidget {
  const ReviewInputWidget({
    super.key,
    required this.onReviewChanged,
    required this.reviewer,
  });

  final ValueChanged<Review> onReviewChanged;
  final MyUser reviewer;

  @override
  State<ReviewInputWidget> createState() => _ReviewInputWidgetState();
}

class _ReviewInputWidgetState extends State<ReviewInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int starRating = 0;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateReview(String comment) {
    if (starRating > 0) {
      widget.onReviewChanged(
        Review(
          reviewer: widget.reviewer,
          rating: starRating,
          comment: comment.isEmpty ? null : comment,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.brandPrimary8,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: .min,
            mainAxisAlignment: .end,
            children: List.generate(
              5,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    starRating = index + 1;
                    _updateReview(_controller.text);
                  });
                },
                child: Icon(
                  index < starRating ? Icons.star : Icons.star_border_rounded,
                  color: AppColors.star,
                  size: 35,
                ),
              ),
            ),
          ),
          CustomTextFormField(
            onChanged: (value) => _updateReview(value),
            focusNode: _focusNode,
            onTapOutside: (value) {
              _focusNode.unfocus();
            },
            controller: _controller,
            filled: false,
            style: context.regular10.textPrimary.rubik,
            borderSideColor: AppColors.transparent,
            contentPadding: EdgeInsets.all(10),
            hintText: t.patient_appointments.tab_to_write_review,
            hintStyle: context.regular10.textSecondary.rubik,
          ),
        ],
      ),
    );
  }
}
