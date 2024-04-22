import 'package:flutter/cupertino.dart';

/// [TextFieldWithIcon] is a custom text field widget with an icon.
class TextFieldWithIcon extends StatelessWidget {
  // Icon to display in the text field
  final IconData icon;
  // Placeholder text for the text field
  final String placeholder;
  // Controller for the text field
  final TextEditingController controller;
  // Flag to make the text field read-only
  final bool readOnly;

  const TextFieldWithIcon({
    required this.icon,
    required this.placeholder,
    required this.controller,
    this.readOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text field's icon
        Icon(
          icon,
          color: CupertinoColors.white,
          size: 32,
        ),
        const SizedBox(width: 16),
        // Text field
        Container(
          width: 280,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: CupertinoColors.white,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CupertinoTextField(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            controller: controller,
            placeholder: placeholder,
            textAlign: TextAlign.center,
            readOnly: readOnly,
            placeholderStyle: const TextStyle(
              color: CupertinoColors.white,
            ),
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
