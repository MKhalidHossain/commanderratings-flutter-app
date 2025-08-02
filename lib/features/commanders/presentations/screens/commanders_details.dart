import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/ratting_a_to_z/ratting.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/widgets/lebel_and_value_text.dart';
import '../../../../core/widgets/title_with_icon_prefix.dart';
import '../../../review/presentation/screens/leave_a_review.dart';
import '../../controllers/commanders_controller.dart';
import '../../domain/single_commander_response_model.dart';
import '../widgets/commander_details_header.dart';
import '../widgets/container_for_commander_details.dart';
import '../widgets/search_and_recent_widget.dart';

class CommandersDetails extends StatefulWidget {
  final String commandersId;

  const CommandersDetails({super.key, required this.commandersId});

  @override
  State<CommandersDetails> createState() => _CommandersDetailsState();
}

class _CommandersDetailsState extends State<CommandersDetails> {
  late SingleCommandersResponseModel commandersResponseModel;

  // Search functionality variables
  String searchQuery = ''; // Store search text
  List<Reviews> filteredReviews = []; // Store filtered reviews

  @override
  void initState() {
    Get.find<CommandersController>().getACommander(widget.commandersId).then((
      _,
    ) {
      final controller = Get.find<CommandersController>();
      if (controller.commander != null &&
          controller.commander.data != null &&
          controller.commander.data!.commander != null) {
        setState(() {
          commandersResponseModel = controller.commander;
          // Initialize filtered reviews with all reviews
          filteredReviews = commandersResponseModel.data!.reviews ?? [];
        });
      }
    });
    super.initState();
  }

  // Method to filter reviews based on search query
  void _filterReviews(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        // Show all reviews if search is empty
        filteredReviews = commandersResponseModel.data!.reviews ?? [];
      } else {
        // Filter reviews that contain the search query (case insensitive)
        filteredReviews =
            commandersResponseModel.data!.reviews!
                .where(
                  (review) =>
                      review.description != null &&
                      review.description!.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CommandersController>(
      builder: (commandersController) {
        return !commandersController.isLoading
            ? Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                title: TitleWithIconPrefix(fontSize: 12, text: 'COMMANDER'),
                centerTitle: true,
                leadingWidth: 60,
                actions: [SizedBox(width: 60)],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8.0),
                      CommanderDetailsHeader(
                        commanderImage:
                            commandersResponseModel
                                .data!
                                .commander!
                                .profileImage!,
                      ),

                      // After Banner section Content
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.context(context).contentBoxColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        LabelText(text: 'Name:'),
                                        const SizedBox(width: 8.0),
                                        ValueTextAeroMatics(
                                          text:
                                              commandersResponseModel
                                                  .data!
                                                  .commander!
                                                  .name!,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    ShowRating(
                                      rating:
                                          double.tryParse(
                                            commandersResponseModel
                                                .data!
                                                .averageRating!,
                                          )!,
                                    ),
                                    const SizedBox(height: 8.0),

                                    Row(
                                      children: [
                                        LabelText(text: 'Individual Rating: '),
                                        ValueTextAeroMatics(
                                          text:
                                              '${commandersResponseModel.data!.averageRating!}/10',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        LabelText(text: 'Overall Rating: '),
                                        ValueTextAeroMatics(
                                          text:
                                              '#${commandersResponseModel.data!.position!}/${commandersResponseModel.data!.totalCommanders!}',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.context(
                                              context,
                                            ).contentBoxGreyColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.red,
                                            width: 3.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Service Branches: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 14,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                  'assets/images/commander/commander_bedge.svg',
                                                  semanticsLabel:
                                                      'My SVG image asset',
                                                  height: 30,
                                                  width: 30,
                                                ),
                                                ContainerForCommanderDetails(
                                                  text:
                                                      commandersResponseModel
                                                          .data!
                                                          .commander!
                                                          .serviceBroad!,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                LabelText(text: 'Unit:'),
                                                const SizedBox(width: 20),
                                                ContainerForCommanderDetails(
                                                  text:
                                                      commandersResponseModel
                                                          .data!
                                                          .commander!
                                                          .unit!,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                LabelText(text: 'Base:'),
                                                const SizedBox(width: 20),
                                                ContainerForCommanderDetails(
                                                  text:
                                                      commandersResponseModel
                                                          .data!
                                                          .commander!
                                                          .base!,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                LabelText(text: 'Rank:'),
                                                const SizedBox(width: 20),
                                                ContainerForCommanderDetails(
                                                  text:
                                                      commandersResponseModel
                                                          .data!
                                                          .commander!
                                                          .rank!,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                                endIndent: 60,
                                indent: 60,
                              ),
                              Center(
                                child: Text(
                                  'Notify us commander info changes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              ),

                              // Leave a Review section with white border
                              const SizedBox(height: 16.0),

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.context(
                                          context,
                                        ).contentBoxColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      color:
                                          AppColors.context(
                                            context,
                                          ).borderColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Updated SearchAndRecentWidget with callback
                                        SearchAndRecentWidget(
                                          commanderId:
                                              commandersResponseModel
                                                  .data!
                                                  .commander!
                                                  .sId!,
                                          onSearchChanged:
                                              _filterReviews, // Pass the callback
                                        ),
                                        const SizedBox(height: 24.0),

                                        // Leave a Review button
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            alignment: Alignment.center,
                                            side: const BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 8,
                                            ),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (BuildContext context) {
                                                final bottomInset =
                                                    MediaQuery.of(
                                                      context,
                                                    ).viewInsets.bottom;

                                                return AnimatedPadding(
                                                  duration: const Duration(
                                                    milliseconds: 150,
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    bottom: bottomInset,
                                                  ),
                                                  child: FractionallySizedBox(
                                                    heightFactor:
                                                        bottomInset > 0
                                                            ? 0.85
                                                            : 0.60, // full if keyboard, smaller if not
                                                    child: LeaveAReview(
                                                      commanderId:
                                                          commandersResponseModel
                                                              .data!
                                                              .commander!
                                                              .sId!,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Leave a Review',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),

                                        // OutlinedButton(
                                        //   style: OutlinedButton.styleFrom(
                                        //     alignment: Alignment.center,
                                        //     side: const BorderSide(
                                        //       color: Colors.red,
                                        //       width: 1,
                                        //     ),
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(8),
                                        //     ),
                                        //     padding: const EdgeInsets.symmetric(
                                        //       horizontal: 20,
                                        //       vertical: 8,
                                        //     ),
                                        //   ),
                                        //   onPressed: () {
                                        //     showModalBottomSheet(
                                        //       isScrollControlled: true,
                                        //       context: context,
                                        //       builder: (BuildContext contex) {
                                        //         return LeaveAReview(
                                        //           commanderId:
                                        //               commandersResponseModel
                                        //                   .data!
                                        //                   .commander!
                                        //                   .sId!,
                                        //         );
                                        //       },
                                        //     );
                                        //   },
                                        //   child: Text(
                                        //     'Leave a Review',
                                        //     style: TextStyle(
                                        //       fontSize: 16,
                                        //       color: Colors.red,
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(height: 32.0),

                                        // Show search results info
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            LabelText(
                                              text:
                                                  searchQuery.isEmpty
                                                      ? 'User Rating (${commandersResponseModel.data!.totalReviews.toString()})'
                                                      : 'Search Results (${filteredReviews.length})',
                                            ),
                                            if (searchQuery.isNotEmpty)
                                              Text(
                                                'Searching for: "$searchQuery"',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        ValueTextAeroMatics(text: 'Overall '),

                                        // Show filtered reviews or no results message
                                        filteredReviews.isEmpty &&
                                                searchQuery.isNotEmpty
                                            ? Padding(
                                              padding: const EdgeInsets.all(
                                                32.0,
                                              ),
                                              child: Center(
                                                child: Column(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.search_off,
                                                      size: 48,
                                                      color: Colors.grey[400],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Text(
                                                      'No reviews found matching "$searchQuery"',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey[600],
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                filteredReviews.length,
                                                (index) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 32.0,
                                                      ),
                                                      ShowRating(
                                                        rating:
                                                            double.tryParse(
                                                              filteredReviews[index]
                                                                  .rating
                                                                  .toString(),
                                                            ) ??
                                                            0.0,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      ValueTextAeroMatics(
                                                        text:
                                                            filteredReviews[index]
                                                                .rating
                                                                .toString() ??
                                                            '0.0',
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Text(
                                                        maxLines: 3,
                                                        filteredReviews[index]
                                                            .description
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      ValueTextAeroMatics(
                                                        text:
                                                            filteredReviews[index]
                                                                .description
                                                                .toString(),
                                                      ),
                                                      const SizedBox(
                                                        height: 32.0,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            : Container(
              height: size.height,
              width: size.width,
              color: AppColors.context(context).backgroundColor,
              child: Center(child: CircularProgressIndicator()),
            );
      },
    );
  }
}
