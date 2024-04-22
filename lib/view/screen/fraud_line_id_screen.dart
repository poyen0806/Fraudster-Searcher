import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pre_assessment/enum/fraud.dart';
import 'package:pre_assessment/enum/mode.dart';
import 'package:pre_assessment/repo/fraud_line_id_repo.dart';
import 'package:pre_assessment/view/widget/message_box.dart';
import 'package:pre_assessment/view/widget/search_field.dart';
import 'package:pre_assessment/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

/// [FraudLineIdScreen] is a screen for searching the fraud line id list.
/// If the input exists in the fraud line id list, it shows a warning message.
/// Otherwise, it shows a safe message.
class FraudLineIdScreen extends StatefulWidget {
  const FraudLineIdScreen({super.key});

  @override
  State<FraudLineIdScreen> createState() => _FraudLineIdScreenState();
}

class _FraudLineIdScreenState extends State<FraudLineIdScreen> {
  // Search field controller
  final TextEditingController search = TextEditingController();
  // ListView controller
  final ScrollController _controller = ScrollController();
  // Loading animation flag
  bool isLoading = true;
  // List to store search results
  List<Fraud?> searchResults = [];

  // Scroll ListView to the bottom
  void _scrollToBottom() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // Initialize the loading animation and scroll ListView to the bottom
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => _handleTimeout());
    // Scroll ListView to the bottom after the ListView is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  // Handle the loading animation
  void _handleTimeout() {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
      _scrollToBottom();
    }
  }

  // Search the fraud line id list
  void searchFraudLineId(String id, int index) async {
    final frauds = await FraudLineIdRepo().getFrauds();
    Fraud result = Fraud.no;
    for (Map<String, dynamic> fraud in frauds) {
      if (fraud["帳號"] == id) {
        result = Fraud.yes;
        break;
      }
    }
    if (mounted) {
      setState(() {
        searchResults[index] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userVM, child) => SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Message field
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ListView.separated(
                      controller: _controller,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: userVM.messages != null
                          ? userVM.messages.length * 2
                          : 0,
                      itemBuilder: (context, index) {
                        if (index == userVM.messages.length * 2 - 1) {
                          // Scroll ListView to the bottom after the ListView is rendered
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) => _scrollToBottom());
                        }
                        String currentMessage = userVM.messages[index ~/ 2];
                        if (searchResults.length <= index ~/ 2) {
                          searchResults.add(Fraud.unknown);
                          searchFraudLineId(currentMessage, index ~/ 2);
                        }
                        Fraud? isFound = searchResults[index ~/ 2];
                        if (index % 2 == 0) {
                          // user -> search
                          return MessageBox(
                            id: currentMessage,
                            mode: Mode.user,
                          );
                        } else {
                          // search -> user
                          return MessageBox(
                            id: currentMessage,
                            mode: Mode.admin,
                            isFound: isFound,
                          );
                        }
                      },
                    ),
                  ),
                ),
                // Make the search field and the message field separated
                const Divider(
                  color: CupertinoColors.systemGrey,
                  thickness: 1,
                ),
                // Search field
                SearchField(
                  searchController: search,
                  onSearch: (text) {
                    if (text != "") {
                      userVM.addMessage(text);
                      search.clear();
                    }
                  },
                ),
              ],
            ),
            // Loading animation for beginning
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
