import 'package:flutter/material.dart';
import 'package:my_doctor/features/home/data/doctors_data.dart';
import 'package:my_doctor/features/home/presentation/widgets/appbar/app_bar.dart';
import 'package:my_doctor/features/home/presentation/widgets/favourite/home_card.dart';
import 'package:my_doctor/features/home/presentation/widgets/favourite/home_grid.dart';
import 'package:my_doctor/features/home/presentation/widgets/filters/home_filters.dart';
import 'package:my_doctor/features/home/presentation/widgets/title/home_title.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: CustomAppBar(searchController: _controller)),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          const SliverToBoxAdapter(
            child: HomeFilters(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          const SliverToBoxAdapter(
            child: HomeTitle(title: 'Favourite Doctor'),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          HomeGrid(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          const SliverToBoxAdapter(
            child: HomeTitle(title: 'Top Doctor'),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final doctor = doctors[index];

                return HomeCard(doctor: doctor);
              },
              childCount: doctors.length,
            ),
          ),
        ],
      ),
    );
  }
}
