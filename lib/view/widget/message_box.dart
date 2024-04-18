import 'package:flutter/cupertino.dart';
import 'package:pre_assessment/enum/fraud.dart';
import 'package:pre_assessment/enum/mode.dart';

class MessageBox extends StatefulWidget {
  final Mode mode;
  final String id;
  final Fraud? isFound;

  const MessageBox({
    super.key,
    required this.id,
    required this.mode,
    this.isFound = Fraud.unknown,
  });

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.mode == Mode.admin;

    return Row(
      mainAxisAlignment:
          isAdmin ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: const BoxConstraints(
            maxWidth: 250,
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              children: [
                if (isAdmin) const TextSpan(text: "ID: "),
                TextSpan(
                  text: widget.id,
                  style: TextStyle(
                    color: isAdmin
                        ? widget.isFound == Fraud.unknown
                            ? CupertinoColors.systemOrange
                            : widget.isFound == Fraud.yes
                                ? CupertinoColors.systemRed
                                : CupertinoColors.systemGreen
                        : CupertinoColors.white,
                  ),
                ),
                if (isAdmin) ...[
                  TextSpan(
                    text: widget.isFound == Fraud.unknown
                        ? " 正在搜尋中..."
                        : widget.isFound == Fraud.yes
                            ? " 疑似是詐騙帳號，請注意！！"
                            : " 目前是安全帳號，尚未發現異常。",
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
