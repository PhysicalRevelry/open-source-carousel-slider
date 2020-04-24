library introcarousel;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introcarousel/state/state.dart';
import 'package:introcarousel/widgets/final_screen_bottom_sheet.dart';
import 'package:introcarousel/widgets/slider_buttons.dart';
import 'package:provider/provider.dart';

//You will need
//1) a list of widget to pass into the carouselScreens
//2) a string for the buttons on either side of the page indicators
//3) text for the final carousel widget button
//4) a navigation target for the final button
class IntroductionCarousel extends StatelessWidget {
  final List<Widget> carouselScreens;
  final String finalScreenText;
  final String sliderButtonLeftText;
  final String sliderButtonRightText;
  final Function nextPage;

  IntroductionCarousel(
    this.carouselScreens,
    this.nextPage, {
    String finalScreenText,
    String sliderButtonLeftText,
    String sliderButtonRightText,
  })  : this.finalScreenText =
            finalScreenText == null ? "Continue" : finalScreenText,
        this.sliderButtonLeftText =
            sliderButtonLeftText == null ? "SKIP" : sliderButtonLeftText,
        this.sliderButtonRightText =
            sliderButtonRightText == null ? "NEXT" : sliderButtonRightText;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CarouselState(),
        ),
      ],
      child: Consumer<CarouselState>(builder: (context, carouselState, _) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: carouselState.pageController,
                  onPageChanged: (int page) {
                    carouselState.turnPage(page);
                  },
                  children: <Widget>[
                    if (carouselScreens != null)
                      for (var card in carouselScreens) card,
                  ],
                ),
              ),
            ],
          ),
          bottomSheet: carouselState.isLastPage(carouselScreens)
              ? BottomSheetButtons(
                  carouselScreens, sliderButtonLeftText, sliderButtonRightText)
              : FinalScreenBottomSheet(finalScreenText, nextPage),
        );
      }),
    );
  }
}
