import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_indicator.dart';
import 'package:introcarousel/state/state.dart';

//The right and left text buttons on either side of the page indicators
//They are usually used for "SKIP" and "NEXT"
class BottomSheetButtons extends StatelessWidget {
  final List<Widget> sliderScreens;
  final String leftButtonLabel;
  final String rightButtonLabel;

  BottomSheetButtons(
      this.sliderScreens, this.leftButtonLabel, this.rightButtonLabel);

  @override
  Widget build(BuildContext context) {
    return Consumer<CarouselState>(builder: (context, carouselState, _) {
      final theme = Theme.of(context);

      return Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              splashColor: theme.splashColor,
              onPressed: () {
                carouselState.skipButton(sliderScreens.length);
              },
              child: Text(
                leftButtonLabel,
                style: theme.textTheme.button,
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  for (int page = 0; page < sliderScreens.length; page++)
                    buildPageIndicator(carouselState.isPage(page), theme)
                ],
              ),
            ),
            FlatButton(
              splashColor: theme.splashColor,
              onPressed: () {
                carouselState.nextButton();
              },
              child: Text(
                rightButtonLabel,
                style: theme.textTheme.button,
              ),
            ),
          ],
        ),
      );
    });
  }
}
