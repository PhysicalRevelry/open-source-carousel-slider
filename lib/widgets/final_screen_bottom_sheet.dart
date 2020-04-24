import 'package:flutter/material.dart';
import 'dart:io';

//Creates a large button to slide up over the page indicator when the last
// carousel page shows.
class FinalScreenBottomSheet extends StatelessWidget {
  final String finalScreenText;
  final Function nextPage;
  FinalScreenBottomSheet(this.finalScreenText, this.nextPage);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          nextPage();
        },
        child: Container(
          height: Platform.isIOS ? 100 : 90,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            finalScreenText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
