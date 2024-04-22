import 'package:flutter/cupertino.dart';

/// [SearchField] is a custom widget for entering search text and performing a search.
class SearchField extends StatelessWidget {
  // Controller for the search field
  final TextEditingController searchController;
  // Function to call when the search button is pressed
  final Function(String) onSearch;

  const SearchField({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: CupertinoTextField(
              strutStyle: const StrutStyle(
                height: 1.25,
              ),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              controller: searchController,
              placeholder: "Enter text",
              placeholderStyle: const TextStyle(
                color: CupertinoColors.systemGrey5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.search_circle,
              ),
              onPressed: () => onSearch(searchController.text),
            ),
          ),
        ],
      ),
    );
  }
}
