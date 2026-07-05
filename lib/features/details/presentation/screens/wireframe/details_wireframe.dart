import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_doctor/core/routing/app_routes.dart';
import 'package:my_doctor/features/details/data/details_data.dart';

class DetailsWireframe extends StatefulWidget {
  final DetailsData doctor;
  const DetailsWireframe({super.key, required this.doctor});

  @override
  State<DetailsWireframe> createState() => _DetailsWireframeState();
}

class _DetailsWireframeState extends State<DetailsWireframe>
    with TickerProviderStateMixin {
  late final AnimationController _shimmerController;
  late final AnimationController _dotsController;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _navigationTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.details,
          arguments: widget.doctor,
        );
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _shimmerController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double radius = 0,
  }) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Color(0xFFD8D8D8),
                Color(0xFFF2F2F2),
                Color(0xFFD8D8D8),
              ],
              stops: const [0.1, 0.5, 0.9],
              begin: Alignment(-1.0 - _shimmerController.value * 2, 0),
              end: Alignment(1.0 - _shimmerController.value * 2, 0),
            ).createShader(bounds);
          },
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFFD8D8D8),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        );
      },
    );
  }

  Widget _dot(int index) {
    return AnimatedBuilder(
      animation: _dotsController,
      builder: (context, child) {
        final delay = index * 0.2;
        double t = (_dotsController.value - delay) % 1.0;
        if (t < 0) t += 1.0;

        final colorValue = (1 - (2 * (t - 0.5)).abs()).clamp(0.0, 1.0);

        return Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(
              const Color(0xFFE0E0E0),
              const Color(0xFF9E9E9E),
              colorValue,
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItemPlaceholder() {
    return Column(
      children: [
        _shimmerBox(width: 22.w, height: 22.w, radius: 6.r),
        SizedBox(height: 6.h),
        _shimmerBox(width: 36.w, height: 12.h, radius: 6.r),
        SizedBox(height: 4.h),
        _shimmerBox(width: 50.w, height: 10.h, radius: 6.r),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40.h,
      width: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor.withOpacity(0.15),
            flexibleSpace: FlexibleSpaceBar(
              background: _shimmerBox(
                width: double.infinity,
                height: 300.h,
                radius: 0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _shimmerBox(
                                width: 160.w, height: 22.h, radius: 6.r),
                            SizedBox(height: 8.h),
                            _shimmerBox(
                                width: 100.w, height: 16.h, radius: 6.r),
                          ],
                        ),
                      ),
                      _shimmerBox(width: 60.w, height: 30.h, radius: 12.r),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItemPlaceholder(),
                        _buildDivider(),
                        _buildStatItemPlaceholder(),
                        _buildDivider(),
                        _buildStatItemPlaceholder(),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _shimmerBox(width: 130.w, height: 18.h, radius: 6.r),
                  SizedBox(height: 12.h),
                  _shimmerBox(
                      width: double.infinity, height: 12.h, radius: 6.r),
                  SizedBox(height: 8.h),
                  _shimmerBox(
                      width: double.infinity, height: 12.h, radius: 6.r),
                  SizedBox(height: 8.h),
                  _shimmerBox(
                      width: double.infinity, height: 12.h, radius: 6.r),
                  SizedBox(height: 8.h),
                  _shimmerBox(width: 200.w, height: 12.h, radius: 6.r),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(0),
                      SizedBox(width: 10.w),
                      _dot(1),
                      SizedBox(width: 10.w),
                      _dot(2),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: _shimmerBox(
          width: double.infinity,
          height: 54.h,
          radius: 14.r,
        ),
      ),
    );
  }
}
