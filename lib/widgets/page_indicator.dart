import 'package:flutter/material.dart';

//A series of dots indicating how many carousel sliders there are
//A larger and darker dot will indicate which page you're on
Widget buildPageIndicator(bool isCurrentPage) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 375),
    margin: EdgeInsets.symmetric(horizontal: 2),
    height: isCurrentPage ? 10 : 6,
    width: isCurrentPage ? 10 : 6,
    decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12)),
  );
}
