import 'package:flutter/material.dart';

class TextInputToggle extends StatefulWidget {
  const TextInputToggle({
    super.key,
    required this.validator,
    required this.controller,
    required this.hintText,
    this.margin = EdgeInsets.zero,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hintText;
  final EdgeInsets margin;

  @override
  State<TextInputToggle> createState() => _TextInputToggleState();
}

class _TextInputToggleState extends State<TextInputToggle> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ),
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              blurStyle: BlurStyle.inner,
            ),
          ],
        ),
        child: TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          obscureText: obscureText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.onSurface,
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
