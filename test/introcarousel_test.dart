import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:introcarousel/introcarousel.dart';

class Harness extends StatelessWidget {
  final Widget child;

  Harness({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: Scaffold(body: child)));
  }
}

void main() {
  final a = Text("A", style: TextStyle(fontSize: 120, color: Colors.red));
  final b = Text("B", style: TextStyle(fontSize: 120, color: Colors.blue));
  final c = Text("C", style: TextStyle(fontSize: 120, color: Colors.orange));

  final aFinder = find.text('A');
  final bFinder = find.text('B');
  final cFinder = find.text('C');
  final nextFinder = find.text(textNext);
  final continueFinder = find.text(textContinue);

  const Duration settle = Duration(milliseconds: 100);

  testWidgets('Swipe through, renders all screens',
      (WidgetTester tester) async {
    await tester.pumpWidget(Harness(
      child: IntroductionCarousel(screens: [a, b, c], callback: () {}),
    ));
    // Verify A renders
    await expectLater(find.byType(Harness), matchesGoldenFile('a.png'));
    expect(aFinder, findsOneWidget);

    // Swipe to B and verify
    await tester.drag(find.byType(PageView), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle(settle);

    await expectLater(find.byType(Harness), matchesGoldenFile('b.png'));

    expect(bFinder, findsOneWidget);
    expect(continueFinder, findsNothing);

    // Swipe to C and verify
    await tester.drag(find.byType(PageView), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle(settle);

    await expectLater(find.byType(Harness), matchesGoldenFile('c.png'));

    expect(cFinder, findsOneWidget);
    expect(continueFinder, findsOneWidget);
  });

  testWidgets('Next through, renders all screens', (WidgetTester tester) async {
    await tester.pumpWidget(Harness(
      child: IntroductionCarousel(screens: [a, b, c], callback: () {}),
    ));

    await expectLater(find.byType(Harness), matchesGoldenFile('a.png'));

    await tester.tap(nextFinder);
    await tester.pumpAndSettle(settle);

    await expectLater(find.byType(Harness), matchesGoldenFile('b.png'));

    expect(bFinder, findsOneWidget);

    await tester.tap(nextFinder);
    await tester.pumpAndSettle(settle);

    await expectLater(find.byType(Harness), matchesGoldenFile('c.png'));

    expect(cFinder, findsOneWidget);
  });

  testWidgets('Skip through, then continue', (WidgetTester tester) async {
    bool clicked = false;
    await tester.pumpWidget(Harness(
      child: IntroductionCarousel(
          screens: [a, b, c],
          callback: () {
            clicked = true;
          }),
    ));

    await tester.tap(find.text(textSkip));
    await tester.pumpAndSettle(settle);

    await expectLater(find.byType(Harness), matchesGoldenFile('c.png'));

    expect(cFinder, findsOneWidget);

    expect(clicked, equals(false));
    await tester.tap(continueFinder);
    expect(clicked, equals(true));
  });
}
