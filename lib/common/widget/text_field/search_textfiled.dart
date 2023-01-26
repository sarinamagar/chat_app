import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';
import 'package:forum/common/constant/textStyle.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final VoidCallback? onSearched;
  const SearchTextField({
    super.key,
    required this.hintText,
    this.textInputType,
    required this.controller,
    this.onSearched,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: CustomTheme.lightTextColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: const Icon(
              Icons.search_rounded,
              color: CustomTheme.blue3,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                style: CustomTextStyle.searchText,
                cursorColor: CustomTheme.black,
                maxLines: 1,
                keyboardType: TextInputType.text,
                controller: controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 12,
                  ),
                  counterText: "",
                  hintText: hintText,
                  hintStyle: CustomTextStyle.hintText2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
