import 'package:flutter/material.dart';
import 'package:introcarousel/widgets/final_screen_bottom_sheet.dart';
import 'package:introcarousel/widgets/slider_buttons.dart';

class CarouselState extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  void turnPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  Widget checkPage(List<Widget> screens, String leftButton, String rightButton,
      String finalText, Function nextPage) {
    if (currentPage != screens.length - 1) {
      return BottomSheetButtons(screens, leftButton, rightButton);
    } else {
      return FinalScreenBottomSheet(finalText, nextPage);
    }
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
