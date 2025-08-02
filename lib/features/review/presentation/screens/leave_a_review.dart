import 'package:commanderratings/core/ratting_a_to_z/ratting.dart';
import 'package:commanderratings/core/widgets/lebel_and_value_text.dart';
import 'package:commanderratings/core/widgets/title_subtitle_text.dart';
import 'package:commanderratings/core/widgets/wide_custom_button.dart';
import 'package:commanderratings/features/review/controllers/review_controller.dart';
import 'package:commanderratings/features/review/presentation/widgets/text_field_for_take_review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/custom_snackbar.dart';

class LeaveAReview extends StatefulWidget {
  final String commanderId;

  const LeaveAReview({super.key, required this.commanderId});

  @override
  State<LeaveAReview> createState() => _LeaveAReviewState();
}

class _LeaveAReviewState extends State<LeaveAReview> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  double _userRating = 0.0;
  bool _isSubmitting = false;

  void _handleRatingSelected(double rating) {
    setState(() {
      _userRating = rating;
    });
    // You can do additional logic here (e.g., save rating to backend)
    print("User selected rating: $_userRating");
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  void _submitReview(ReviewController reviewController) async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty) {
      showCustomSnackBar('Please give a title for your review'.tr);
      return;
    }

    if (_userRating == 0.0) {
      showCustomSnackBar('Please give a rating by touching or swiping'.tr);
      return;
    }

    if (description.isEmpty) {
      showCustomSnackBar('Please give a description for your review'.tr);
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await reviewController.createReview(
        widget.commanderId,
        _userRating,
        title,
        description,
      );

      showCustomSnackBar('Submitting your review'.tr);

      // Optionally clear the fields after success
      titleController.clear();
      descriptionController.clear();
      setState(() {
        _userRating = 0.0;
      });
    } catch (e) {
      showCustomSnackBar('Something went wrong. Please try again.'.tr);
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      builder: (reviewController) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TitleText(text: 'Leave a Review'),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
            
                TextFieldForTakeReview(
                  hintText: 'title',
                  controller: titleController,
                ),
                const SizedBox(height: 16),
                TextFieldForTakeReview(
                  hintText: 'Description',
                  controller: descriptionController,
                  height: 100,
                ),
                const SizedBox(height: 32),
                LabelText(text: 'Select Rating'),
                const SizedBox(height: 8),
            
                TakeRating(onRatingSelected: _handleRatingSelected),
                const SizedBox(height: 20),
                Text(
                  'Selected Rating: $_userRating',
                  style: const TextStyle(fontSize: 20),
                ),
                SizedBox(height: 30),
                WideCustomButton(
                  text: _isSubmitting ? 'Submitting...' : 'Submit',
                  onPressed:
                      _isSubmitting
                          ? null
                          : () => _submitReview(reviewController),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
