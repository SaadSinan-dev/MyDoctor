import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_doctor/core/routing/app_routes.dart';

class HomeWireframe extends StatefulWidget {
  const HomeWireframe({super.key});

  @override
  State<HomeWireframe> createState() => _HomeWireframeState();
}

class _HomeWireframeState extends State<HomeWireframe>
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

    _navigationTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _shimmerBox(
                  width: 320.w,
                  height: 180.h,
                  radius: 20.r,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 45.h,
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      return _shimmerBox(
                        width: 90.w,
                        height: 35.h,
                        radius: 30.r,
                      );
                    }),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: _shimmerBox(
                  width: 160.w,
                  height: 18.h,
                  radius: 20.r,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return _shimmerBox(
                      width: double.infinity,
                      height: double.infinity,
                      radius: 16.r,
                    );
                  },
                ),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: _shimmerBox(
                  width: 140.w,
                  height: 18.h,
                  radius: 20.r,
                ),
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 8.h,
                    ),
                    child: _shimmerBox(
                      width: double.infinity,
                      height: 90.h,
                      radius: 16.r,
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
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
    );
  }
}
