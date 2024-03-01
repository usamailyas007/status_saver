// ignore_for_file: unrelated_type_equality_checks

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.title,
    required this.icon,
    required this.function,
  });
  final String title;
  final IconData icon;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              FlexColorScheme.dark() == FlexColorScheme.dark().toTheme
                  ? Colors.black
                  : Colors.white,
          shadowColor: Colors.transparent,
          // padding: EdgeInsets.zero,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
