import 'package:flutter/material.dart';

class GroupNameWidget extends StatelessWidget {
  final String groupTitle;
  final Color? backgroundMid;
  final Color? backgroundStart;

  const GroupNameWidget({
    super.key,
    required this.groupTitle,
    this.backgroundMid,
    this.backgroundStart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 20, top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundMid?.withValues(alpha: 0.5) ?? Colors.grey,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            groupTitle,
            style: TextStyle(
              fontSize: 14,
              color: backgroundStart ?? Colors.black,
              fontFamily: 'Cairo-Bold',
            ),
          ),
        ),
      ),
    );
  }
}
