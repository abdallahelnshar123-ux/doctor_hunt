import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdminDoctorsShimmer extends StatelessWidget {
  const AdminDoctorsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        spacing: 10,
        children: [
          // Specialties Shimmer
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: 5,
            ),
          ),
          // const SizedBox(height: 10),
          // Doctor Cards Shimmer
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) => AppContainerWithShadow(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                // child: Row(
                //   spacing: 15,
                //   children: [
                //     Container(
                //       width: double.infinity,
                //       height: 300,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12),
                //         // color: Colors.white,
                //       ),
                //     ),
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             width: double.infinity,
                //             height: 16,
                //             color: Colors.white,
                //           ),
                //           const SizedBox(height: 8),
                //           Container(
                //             width: context.width * 0.3,
                //             height: 12,
                //             color: Colors.white,
                //           ),
                //           const SizedBox(height: 8),
                //           Container(
                //             width: 60,
                //             height: 25,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(30),
                //               color: Colors.white,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 7,
            ),
          ),
        ],
      ),
    );
  }
}
