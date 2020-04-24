library introcarousel;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introcarousel/state/state.dart';
import 'package:introcarousel/widgets/final_screen_bottom_sheet.dart';
import 'package:introcarousel/widgets/slider_buttons.dart';
import 'package:provider/provider.dart';

class Hello extends StatelessWidget {
  final List<Widget> carouselScreens;

  Hello(this.carouselScreens);

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
          bottomSheet: carouselState.currentPage != carouselScreens.length - 1
              ? BottomSheetButtons(carouselScreens)
              : FinalScreenBottomSheet(),
        );
      }),
    );
  }
}
