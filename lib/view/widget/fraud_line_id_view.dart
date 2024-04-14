import 'package:flutter/cupertino.dart';
import 'package:pre_assessment/repo/fraud_line_id_repo.dart';
import 'package:pre_assessment/view/widget/sign_in_button.dart';

/// A page has a search field to search the fraud line id list,
/// if the input exists in the fraud line id list, show the warning message,
/// otherwise, show the safe message.
class FraudLineIdView extends StatefulWidget {
  const FraudLineIdView({super.key});

  @override
  State<FraudLineIdView> createState() => _FraudLineIdViewState();
}

class _FraudLineIdViewState extends State<FraudLineIdView> {
  // Get the fraud line id list
  Future<List<Map<String, dynamic>>> fraudLineIdList =
      FraudLineIdRepo().getFraudLineIdList();
  // Search field controller
  TextEditingController searchController = TextEditingController();

  // Check if the input exists in the fraud line id list, the time complexity is O(n)
  bool isFound = false;
  void seartch() {
    setState(() {
      fraudLineIdList.then((value) {
        for (var fraudLineId in value) {
          if (fraudLineId["帳號"] == searchController.text) {
            isFound = true;
            return;
          }
        }
        isFound = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: 250,
            decoration: BoxDecoration(
              color: (isFound)
                  ? CupertinoColors.systemRed
                  : CupertinoColors.systemGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CupertinoTextField(
              controller: searchController,
              placeholder: "Enter text",
              textAlign: TextAlign.center,
              onChanged: (_) {
                seartch();
              },
            ),
          ),
          if (isFound)
            const Text("Warning: This is a fraud line id.")
          else
            const Text("Safe: This is not a fraud line id."),
          const SizedBox(height: 16),
          const SignInButton(),
        ],
      ),
    );
  }
}
