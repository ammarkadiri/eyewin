import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/demoData/kpi_list.dart';

class MainKpiList extends StatelessWidget {
  const MainKpiList({super.key});

  @override
  Widget build(BuildContext context) {
    final kpiList = getKpiList(context);
    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kpiList.length,
        itemBuilder: (context, i) {
          final startColor =
              kpiList[i].backgroundStart ?? AppColors.darkGreenColor;
          final endColor = kpiList[i].backgroundMid ?? AppColors.darkGreenColor;

          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 10, // diameter = 2 * radius = 10
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [startColor, endColor, startColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  kpiList[i].title ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textGreyColor,
                    height: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
