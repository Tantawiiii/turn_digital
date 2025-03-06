import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';

import '../../cubit/event_cubit.dart';
import '../../cubit/event_state.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;

  const EventDetailsScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchEventById(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.CWhite,
      bottomNavigationBar: _buildBuyTicketButton(),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventDetailsError) {
            return Center(child: Text(state.message));
          } else if (state is EventDetailsLoaded) {
            final event = state.event;

            return Stack(
              children: [
                SizedBox(
                  height: 300.h,
                  width: double.infinity,
                  child: _buildEventImage(event.picture),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 250.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    // Main content
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    ..._buildAttendeeAvatars([event.organizer.picture]),
                                    Text(
                                      '+${event.numberOfGoing} Going',
                                      style: AppTextStyles.font14DarkLight,
                                    ),
                                  ],
                                ),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                },
                                child: const Text('Invite'),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            event.title,
                            style: AppTextStyles.font20DarkLight,
                          ),
                        ),
                        SizedBox(height: 16.h),


                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              _buildDetailRow(
                                icon: Icons.calendar_today_outlined,
                                title: event.formattedDate,
                                subtitle: event.formattedTime,
                              ),
                              SizedBox(height: 16.h),
                              _buildDetailRow(
                                icon: Icons.location_on_outlined,
                                title: event.addressTitle,
                                subtitle: event.address,
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: InkWell(
                            onTap: () {
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage: NetworkImage(event.organizer.picture),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    event.organizer.name,
                                    style: AppTextStyles.font14DarkLight,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                  },
                                  child: const Text('Follow'),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About Event',
                                style: AppTextStyles.font14DarkLight,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                event.aboutEvent,
                                style: AppTextStyles.font14DarkLight,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 80.h),
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
                            style: AppTextStyles.font20DarkLight.copyWith(color: Colors.white),
                          ),
                          SvgPicture.asset(
                            AssetsPATH.iMenuDots,
                            fit: BoxFit.scaleDown,
                            width: 24.w,
                            height: 24.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBuyTicketButton() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () {
          },
          child: Text(
            'Buy Ticket \$120',
            style: AppTextStyles.font14DarkLight,
          ),
        ),
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
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.CPrimary),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.font14DarkLight),
              if (subtitle != null && subtitle.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    subtitle,
                    style: AppTextStyles.font14DarkLight,
                  ),
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
        child: CircleAvatar(
          radius: 12.r,
          backgroundImage: NetworkImage(url),
        ),
      );
    }).toList();
  }
}
