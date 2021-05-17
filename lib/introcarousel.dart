library introcarousel;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introcarousel/widgets/page_indicator.dart';

const textContinue = "CONTINUE";
const textNext = "NEXT";
const textSkip = "SKIP";


// You will need
// 1) a list of widgets to pass into the carouselScreens ("screens")
// 2) a navigation target for the final button ("callback")
class IntroductionCarousel extends StatefulWidget {
  final List<Widget> screens; // the widgets for each slide of explanation
  final Function callback; // invoked after the last screen

  const IntroductionCarousel(
      {Key key, @required this.screens, @required this.callback})
      : super(key: key);

  @override
  _IntroductionCarouselState createState() =>
      _IntroductionCarouselState(this.screens, this.callback);
}

class _IntroductionCarouselState extends State<IntroductionCarousel> {
  final PageController pageController = PageController(initialPage: 0);
  final List<Widget> screens; // the widgets for each slide of explanation
  final Function callback; // invoked after the last screen
  int page = 0; // current page

  _IntroductionCarouselState(this.screens, this.callback);

  // controls current page and animation to switch screens
  void changePage(int page) {
    setState(() {
      this.page = page;
      pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (int page) => setState(() => this.page = page),
            children: <Widget>[
              for (var card in screens) card,
            ],
          ),
        ),
        Controls(
          page: page,
          lastPage: screens.length - 1,
          changePage: changePage,
          callback: callback,
        )
      ],
    );
  }
}

class Controls extends StatelessWidget {
  final int page; // current page
  final int lastPage; // final screen in list
  final Function changePage; // controls current page and animation to switch screens
  final Function callback; // invoked after the last screen

  const Controls(
      {Key key, this.page, this.lastPage, this.changePage, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLastPage) {
      return TextButton(onPressed: callback, child: Text(textContinue));
    }

    final theme = Theme.of(context);
    return Row(
      children: [
        TextButton(onPressed: skip, child: Text(textSkip)),
        for (int p = 0; p <= lastPage; p++)
          buildPageIndicator(page == p, theme),
        TextButton(onPressed: next, child: Text(textNext))
      ],
    );
  }

  bool get isLastPage => page == lastPage; // checks if on last page
  void skip() => changePage(lastPage); // takes user to final screen
  void next() => changePage(min(page + 1, lastPage)); // takes user to next screen
}
