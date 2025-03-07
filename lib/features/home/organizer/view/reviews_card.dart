import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';

class ReviewCard extends StatelessWidget {
  final String? reviewerPicture;
  final String? reviewerName;
  final int? rate;
  final String? review;
  final String? reviewDate;

  ReviewCard({
    super.key,
    this.reviewerPicture,
    this.reviewerName,
    this.rate,
    this.review,
    this.reviewDate,
  });

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(reviewDate!);
    String formattedDate = DateFormat('d MMM').format(date);

    return Card(
      elevation: 2,
      color: AppColors.CWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: reviewerPicture!,
                  imageBuilder:
                      (context, imageProvider) => CircleAvatar(
                        radius: 20.r,
                        backgroundImage: imageProvider,
                      ),
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
                ),
                horizontalSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewerName ?? "",
                        style: AppTextStyles.font14DarkLight,
                      ),
                      Row(
                        children: List.generate(rate!, (index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(12),
                Text(
                  formattedDate ?? "",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Text(review ?? "", style: TextStyle(fontSize: 14, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
