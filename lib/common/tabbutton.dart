import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/localization_controller.dart';
import '../utils/icons.dart';
import 'icons.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? onTap;
  const CustomBackButton({this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8)
          .copyWith(left: !isLtr ? 0 : 16, right: !isLtr ? 16 : 0),
      child: CustomIcon(
        icon: FFIcons.leftArrow2,
        iconSize: 28,
        border: 8,
        onTap: onTap ?? () => Navigator.pop(context),
      ),
    );
  }
}

class AnimatedTabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Function()? onTap;
  final bool expanded;
  const AnimatedTabButton(
      {required this.text,
      required this.onTap,
      this.selected = false,
      this.expanded = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return expanded ? Expanded(child: _child(context)) : _child(context);
  }

  _child(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          margin: expanded ? null : const EdgeInsets.only(right: 10),
          padding: expanded ? null : const EdgeInsets.symmetric(horizontal: 20),
          duration: const Duration(milliseconds: 300),
          height: 45,
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Theme.of(context)
                          .hintColor
                          .withOpacity(Get.isDarkMode ? 0.1 : 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color:
                      selected ? Colors.white : Theme.of(context).primaryColor),
            ),
          ),
        ),
      );
}
