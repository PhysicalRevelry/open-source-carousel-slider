import 'package:flutter/material.dart';
import 'dart:io';

//Creates a large button to slide up over the page indicator when the last
// carousel page shows.
class FinalScreenBottomSheet extends StatelessWidget {
  final String finalScreenText;
  final Function nextPage;
  final Color bottomSheetText;
  FinalScreenBottomSheet(
      this.finalScreenText, this.nextPage, this.bottomSheetText);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: InkWell(
        onTap: () {
          nextPage();
        },
        child: Container(
          height: Platform.isIOS ? 100 : 90,
          color: theme.primaryColor,
          alignment: Alignment.center,
          child: Text(
            finalScreenText,
            style: TextStyle(
              color: bottomSheetText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
