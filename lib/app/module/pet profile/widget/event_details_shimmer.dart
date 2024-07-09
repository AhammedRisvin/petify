import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EventDetailsShimmer extends StatelessWidget {
  const EventDetailsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: Column(
        children: [
          _buildShimmeringImage(),
          const SizedBox(height: 10),
          _buildShimmeringText(),
          const SizedBox(height: 10),
          _buildShimmeringText(),
          const SizedBox(height: 10),
          _buildShimmeringText(),
        ],
      ),
    );
  }

  Widget _buildShimmeringImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildShimmeringText() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20,
        width: double.infinity,
        color: Colors.grey,
      ),
    );
  }
}
