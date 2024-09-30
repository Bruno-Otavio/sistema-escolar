import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.margin = EdgeInsets.zero,
  });

  final Function()? onPressed;
  final String text;
  final EdgeInsets margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: margin,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(
              double.minPositive,
              double.minPositive,
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
