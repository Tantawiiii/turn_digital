import 'package:bounce/bounce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';
import 'package:turn_digital/core/widgets/custom_button.dart';

import '../../../organizer/view/organizer_details_screen.dart';
import '../../cubit/event_cubit.dart';
import '../../cubit/event_state.dart';
import '../widgets/build_shimmer_effect.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;

  const EventDetailsScreen({super.key, required this.eventId});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchEventById(widget.eventId);
  }


  void _shareEvent(String title, String location, String imageUrl) {
    String text = '$title\n 📍Location: $location';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.CWhite,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 22.h),
        child: CustomButton(text: 'Buy Ticket \$120', onPressed: () {}),
      ),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventDetailsLoading) {
            return buildShimmerEffect();
          } else if (state is EventDetailsError) {
            return Center(child: Text(state.message));
          } else if (state is EventDetailsLoaded) {
            final event = state.event;
            return GestureDetector(
              onLongPress: () => _shareEvent(event.title, event.address, event.picture),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 300.h,
                    width: double.infinity,
                    child: _buildEventImage(event.picture),
                  ),
              
                  SingleChildScrollView(
                    padding: EdgeInsets.only(top: 250.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0.r),
                          topRight: Radius.circular(0.r),
                        ),
                      ),
                      // Main content
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(44),
                          Text(event.title, style: AppTextStyles.font28DarkLight),
                          verticalSpace(16),
                          _buildDetailRow(
                            icon: AssetsPATH.iDateCard,
                            title: event.formattedDate,
                            subtitle: event.formattedTime,
                          ),
                          verticalSpace(16),
                          _buildDetailRow(
                            icon: AssetsPATH.iLocationCard,
                            title: event.addressTitle,
                            subtitle: event.address,
                          ),
                          verticalSpace(22),
                          Bounce(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrganizerDetailsScreen(organizerId: event.organizer.id),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage: NetworkImage(
                                    event.organizer.picture,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    event.organizer.name,
                                    style: AppTextStyles.font14DarkLight,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.CPrimary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(color: AppColors.CPrimary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          verticalSpace(16),
                          Text(
                            'About Event',
                            style: AppTextStyles.font14DarkLight,
                          ),
                          verticalSpace(6),
                          Text(
                            event.aboutEvent,
                            style: AppTextStyles.font14DarkLight,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 225.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 44.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                ..._buildAttendeeAvatars([
                                  event.organizer.picture,
                                ]),
                                Text(
                                  '+${event.numberOfGoing} Going',
                                  style: AppTextStyles.font15Primer,
                                ),
                              ],
                            ),
                          ),
              
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.CPrimary,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                            child: Text(
                              "Invite",
                              style: TextStyle(color: AppColors.CWhite),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Bounce(
                              onTap: () => Navigator.pop(context),
                              child: SvgPicture.asset(
                                AssetsPATH.iArrowLeft,
                                fit: BoxFit.scaleDown,
                                width: 24.w,
                                height: 24.h,
                                color: Colors.white,
                              ),
                            ),
                            // Title
                            Text(
                              'Event Details',
                              style: AppTextStyles.font20DarkLight.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            SvgPicture.asset(
                              AssetsPATH.iFav,
                              fit: BoxFit.cover,
                              width: 28.w,
                              height: 28.h,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildEventImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: const Text('No Image'),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
      errorWidget:
          (context, url, error) => Container(
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Icon(Icons.error, color: Colors.red),
          ),
    );
  }

  Widget _buildDetailRow({
    required String icon,
    required String title,
    String? subtitle,
  }) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.font14DarkLight),
              if (subtitle != null && subtitle.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(subtitle, style: AppTextStyles.font14DarkLight),
                ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAttendeeAvatars(List<String>? attendees) {
    if (attendees == null || attendees.isEmpty) return [];
    return attendees.take(3).map((url) {
      return Padding(
        padding: EdgeInsets.only(right: 4.w),
        child: CircleAvatar(radius: 12.r, backgroundImage: NetworkImage(url)),
      );
    }).toList();
  }
}
