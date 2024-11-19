import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_card_swiper_pro/example.dart';

class Example extends StatefulWidget {
  const Example({
    super.key,
  });

  @override
  State<Example> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Example> {
  final CardSwiperController controller = CardSwiperController();

  final cards = candidates.map(ExampleCard.new).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 20),

              /// Given height because you'll have to wrap this widget with
              /// flexible in order to make this work, change this according to
              /// your preference
              height: 500,
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(40, 0),
                padding: const EdgeInsets.all(40.0),
                // padding: EdgeInsets.zero,
                cardBuilder: (
                  context,
                  index,
                  horizontalThresholdPercentage,
                  verticalThresholdPercentage,
                ) =>
                    cards[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                    child: const Icon(Icons.keyboard_arrow_left),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.right),
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.top),
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.bottom),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
