import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

class CustomFilterTabBar extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  final TabController controller;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomFilterTabBar({
    Key? key,
    required this.tabs,
    required this.controller,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        isScrollable: false,
        controller: controller,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: onTap,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: const BoxDecoration(
          color: AppColors.firstBlueColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF222222),
        tabs: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Tab(
            height: 40,
            child: Text(
              tabs[index]['title'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.darkGrey,
                fontSize: 13,
              ),
            ),
          );
        }),
      ),
    );
  }
}
