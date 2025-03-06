import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';

class EventCard extends StatelessWidget {
  final String? eventImage;
  final String? eventTitle;
  final String? eventDate;
  final String? eventLocation;
  final int? numberOfGoing;
  final List<String>? attendees;

  const EventCard({
    super.key,
    this.eventImage,
    this.eventTitle,
    this.eventDate,
    this.eventLocation,
    this.attendees,
    this.numberOfGoing,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.7;
    DateTime dateTime = DateTime.parse(eventDate!);

    String day = DateFormat('d').format(dateTime);
    String month = DateFormat('MMMM').format(dateTime);

    return Container(
      width: cardWidth,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: eventImage!,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.blue[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          color: Colors.white,
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Icon(Icons.image_not_supported),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tColorCardEvent,
                        ),
                      ),
                      Text(
                        month,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tColorCardEvent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.bookmark_border,
                    color: AppColors.tColorCardEvent,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Text(
            eventTitle!,
            style: AppTextStyles.font18BlackMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(8),
          Row(
            children: [
              ...attendees!
                  .take(3)
                  .map(
                    (attendee) => Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(attendee),
                      ),
                    ),
                  ),
              horizontalSpace(30),
              Text(
                "+${numberOfGoing.toString()} Going",
                style: TextStyle(color: AppColors.CPrimary, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey, size: 18),
              SizedBox(width: 4),
              Text(
                eventLocation ?? "",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
