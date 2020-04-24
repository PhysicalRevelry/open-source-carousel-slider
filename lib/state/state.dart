import 'package:flutter/material.dart';

class CarouselState extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  void turnPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void skipButton(int length) {
    pageController.animateToPage(length,
        duration: Duration(
          milliseconds: 400,
        ),
        curve: Curves.linear);
  }

  void nextButton() {
    pageController.animateToPage(currentPage + 1,
        duration: Duration(
          milliseconds: 400,
        ),
        curve: Curves.linear);
  }
}
