import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_doctor/core/routing/app_routes.dart';

class SplashWireframe extends StatefulWidget {
  const SplashWireframe({super.key});

  @override
  State<SplashWireframe> createState() => _SplashWireframeState();
}

class _SplashWireframeState extends State<SplashWireframe>
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
        Navigator.pushReplacementNamed(context, AppRoutes.splash);
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
    double borderRadius = 0,
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
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        );
      },
    );
  }

  Widget _loadingDot(int index) {
    return AnimatedBuilder(
      animation: _dotsController,
      builder: (context, child) {
        final delay = index * 0.2;
        double t = (_dotsController.value - delay) % 1.0;
        if (t < 0) t += 1.0;

        final colorValue = (1 - (2 * (t - 0.5)).abs()).clamp(0.0, 1.0);
        final color = Color.lerp(
          const Color(0xFFE0E0E0),
          const Color(0xFF9E9E9E),
          colorValue,
        )!;

        return Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _shimmerBox(width: 290.w, height: 500.h, borderRadius: 20.r),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 44.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(
                          width: 220.w, height: 14.h, borderRadius: 20.r),
                      SizedBox(height: 14.h),
                      _shimmerBox(
                          width: 180.w, height: 14.h, borderRadius: 20.r),
                      SizedBox(height: 14.h),
                      _shimmerBox(
                          width: 140.w, height: 14.h, borderRadius: 20.r),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _loadingDot(0),
                          SizedBox(width: 10.w),
                          _loadingDot(1),
                          SizedBox(width: 10.w),
                          _loadingDot(2),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
