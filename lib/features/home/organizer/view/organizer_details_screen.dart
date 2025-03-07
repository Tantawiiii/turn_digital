import 'package:bounce/bounce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';
import 'package:turn_digital/features/home/home/presentation/widgets/build_shimmer_effect.dart';
import 'package:turn_digital/features/home/organizer/view/reviews_card.dart';

import '../../../../core/constant/assets_path.dart';
import '../../../../core/constant/colors_code.dart';
import '../../home/cubit/event_cubit.dart';
import '../../home/presentation/view/event_details_screen.dart';
import '../../home/presentation/widgets/event_card_list.dart';
import '../cubit/organizer_cubit.dart';
import '../cubit/organizer_state.dart';

class OrganizerDetailsScreen extends StatelessWidget {
  final int organizerId;

  const OrganizerDetailsScreen({super.key, required this.organizerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrganizerCubit()..fetchOrganizerDetails(organizerId),
      child: Scaffold(
        backgroundColor: AppColors.CWhite,
        appBar: AppBar(
          backgroundColor: AppColors.CWhite,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Bounce(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                AssetsPATH.iArrowLeft,
                width: 28.w,
                height: 28.h,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: SvgPicture.asset(
                AssetsPATH.iMenuDots,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ],
        ),
        body: BlocBuilder<OrganizerCubit, OrganizerState>(
          builder: (context, state) {
            if (state is OrganizerLoading) {
              return buildShimmerEffect();
            } else if (state is OrganizerLoaded) {
              final organizer = state.organizer;
              return Column(
                children: [
                  verticalSpace(20),
                  CachedNetworkImage(
                    imageUrl: organizer.picture,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 50.r,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                  ),
                  verticalSpace(10),
                  Text(organizer.name, style: AppTextStyles.font20DarkLight),
                  verticalSpace(10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 18,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${organizer.numberOfFollowers}",
                            style: AppTextStyles.font16DarkLight,
                          ),
                          Text(
                            "Followers",
                            style: AppTextStyles.font14DarkLight,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${organizer.numberOfFollowing}",
                            style: AppTextStyles.font16DarkLight,
                          ),
                          Text(
                            "Following",
                            style: AppTextStyles.font14DarkLight,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 14,
                    children: [
                      Container(
                        width: 154.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.CPrimary,
                        ),
                        child: Center(child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 14,
                          children: [
                            SvgPicture.asset(AssetsPATH.iUserPlus),
                            Text("Follow", style: AppTextStyles.font14WhiteMedium,),
                          ],
                        )),
                      ),
                      Container(
                        width: 154.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.CWhite,
                          border: Border.all(
                            color: AppColors.CPrimary,
                            width: 2.0
                          )
                        ),
                        child: Center(child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 14,
                          children: [
                            SvgPicture.asset(AssetsPATH.iMassageCircle),
                            Text("Massages", style: AppTextStyles.font15Primer,),
                          ],
                        )),
                      ),
                    ],
                  ),
                  verticalSpace(18),
                  DefaultTabController(
                    length: 3,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: false,
                            indicatorColor: AppColors.CPrimary,
                            indicatorWeight: 4.0,
                            labelColor: AppColors.CPrimary,
                            tabs: [
                              Tab(text: "ABOUT"),
                              Tab(text: "EVENT"),
                              Tab(text: "REVIEW"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // about tap
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(organizer.about),
                                ),

                                // event tap
                                ListView.builder(
                                  itemCount: organizer.events.length,
                                  itemBuilder: (context, index) {
                                    final event = organizer.events[index];
                                    return Bounce(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (newContext) => BlocProvider(
                                              create: (context) => EventCubit()..fetchEventById(event.id),
                                              child: EventDetailsScreen(eventId: event.id),
                                            ),
                                          ),
                                        );

                                      },
                                      child: EventCardList(
                                        eventImage: event.picture,
                                        eventTitle: event.title,
                                        eventDate: event.date,
                                      ),
                                    );
                                  },
                                ),

                                // reiviews tap
                                ListView.builder(
                                  itemCount: organizer.reviews.length,
                                  itemBuilder: (context, index) {
                                    final review = organizer.reviews[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                      child: ReviewCard(
                                       reviewerPicture: review.reviewerPicture,
                                        reviewerName: review.reviewerName,
                                        rate: review.rate,
                                        review: review.review,
                                        reviewDate: review.reviewDate,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is OrganizerError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
