import 'package:flutter/material.dart';
import 'package:introcarousel/widgets/final_screen_bottom_sheet.dart';
import 'package:introcarousel/widgets/slider_buttons.dart';

class CarouselState extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  bool isPage(int i) {
    return i == currentPage;
  }

  void turnPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  bool isLastPage(List<Widget> screens) => currentPage != screens.length - 1;

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
