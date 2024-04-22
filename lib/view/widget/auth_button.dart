import 'package:flutter/cupertino.dart';

/// [AuthButton] is a custom authentication button for sign up, sign in, update and sign out actions.
class AuthButton extends StatelessWidget {
  // Text to display on the button
  final String text;
  // Function to call when the button is pressed
  final VoidCallback onPressed;
  // Background color of the button
  final Color color;
  // Text color of the button
  final Color textColor;

  const AuthButton({
    required this.text,
    required this.onPressed,
    this.color = CupertinoColors.darkBackgroundGray,
    this.textColor = CupertinoColors.systemOrange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: textColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
