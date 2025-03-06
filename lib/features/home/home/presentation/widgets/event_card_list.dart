import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';

class EventCardList extends StatelessWidget {
  final String? eventImage;
  final String? eventTitle;
  final String? eventDate;
  final String? eventLocation;
  final int? numberOfGoing;
  final List<String>? attendees;

  const EventCardList({
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

    String formattedDate = DateFormat('E, MMM d • h:mm a').format(dateTime);

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: eventImage!,
              width: 79,
              height: 92,
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
          horizontalSpace(18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(8),
              Text(
                formattedDate,
                style: AppTextStyles.font12PRIMER,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(4),
              Text(
                eventTitle!,
                style: AppTextStyles.font18BlackMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(8),
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

        ],
      ),
    );
  }
}
