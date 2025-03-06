import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constant/assets_path.dart';
import '../../../../../core/constant/colors_code.dart';
import '../../../../../core/constant/strings_text.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/theme/texts_styles.dart';
import '../../cubit/event_cubit.dart';
import '../../cubit/event_state.dart';
import '../view/get_list_events.dart';
import 'build_custom_search_bar.dart';
import 'event_card.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BuildCustomSearchBar(),
          verticalSpace(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.tUpcomingEvents,
                      style: AppTextStyles.font18BlackMedium,
                    ),
                    Bounce(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventsListScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            AppTexts.tSeeAll,
                            style: TextStyle(color: AppColors.HINTcOLOR),
                          ),
                          Icon(Icons.arrow_right, color: AppColors.HINTcOLOR),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(10),
                BlocBuilder<EventCubit, EventState>(
                  builder: (context, state) {
                    if (state is EventLoading) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.blue[100]!,
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else if (state is EventError) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(child: Text('Failed to load events')),
                      );
                    } else if (state is EventLoaded) {
                      if (state.events.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(child: Text('No events available')),
                        );
                      }
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.events.length,
                          itemBuilder: (context, index) {
                            final event = state.events[index];
                            return EventCard(
                              eventImage: event.picture,
                              eventTitle: event.title,
                              eventDate: event.date,
                              attendees: [event.organizer.picture],
                              eventLocation: event.address,
                              numberOfGoing: event.numberOfGoing,
                            );
                          },
                        ),
                      );
                    }

                    return SizedBox();
                  },
                ),
                verticalSpace(20),
                Image.asset(AssetsPATH.pBanner, fit: BoxFit.cover),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.tNearby,
                      style: AppTextStyles.font18BlackMedium,
                    ),
                    Bounce(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            AppTexts.tSeeAll,
                            style: TextStyle(color: AppColors.HINTcOLOR),
                          ),
                          Icon(Icons.arrow_right, color: AppColors.HINTcOLOR),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
