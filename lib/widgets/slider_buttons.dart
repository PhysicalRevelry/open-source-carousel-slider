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
      return Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              splashColor: Colors.blue[50],
              onPressed: () {
                carouselState.skipButton(sliderScreens.length);
              },
              child: Text(
                leftButtonLabel,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  for (int i = 0; i < sliderScreens.length; i++)
                    i == carouselState.currentPage
                        ? buildPageIndicator(true)
                        : buildPageIndicator(false)
                ],
              ),
            ),
            FlatButton(
              splashColor: Colors.blue[50],
              onPressed: () {
                carouselState.nextButton();
              },
              child: Text(
                rightButtonLabel,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
