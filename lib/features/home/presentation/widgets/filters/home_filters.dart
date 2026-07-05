import 'package:flutter/material.dart';
import 'package:my_doctor/features/home/data/filters_data.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({super.key});

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return OutlinedButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: isSelected ? Colors.indigo : Colors.white,
              foregroundColor: isSelected ? Colors.white : Colors.black87,
              side: BorderSide(
                color: isSelected ? Colors.indigo : Colors.grey.shade300,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(filters[index]),
          );
        },
      ),
    );
  }
}
