import 'dart:math';

import 'package:flutter/material.dart';

class SwippablePageProvider extends StatelessWidget {
  const SwippablePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swippable Page'),
      ),
      body: const SafeArea(
        child: SwippableUiPage(),
      ),
    );
  }
}

class SwippableUiPage extends StatefulWidget {
  const SwippableUiPage({super.key});

  @override
  State<SwippableUiPage> createState() => _SwippableUiPageState();
}

class _SwippableUiPageState extends State<SwippableUiPage>
    with TickerProviderStateMixin {
  AnimationController? dragAnimation;
  double containerHeight = 60;
  int? startIndex;
  int? offset;
  ScrollController sc = ScrollController();
  double actionThreshold = .2;
  List<int> emails = List.generate(20, (i) => i);

  @override
  void initState() {
    super.initState();
    dragAnimation = AnimationController.unbounded(value: 0, vsync: this);
  }

  Widget getActionRect() {
    if (!sc.hasClients || startIndex == null || offset == null) {
      return Container();
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double actionThresholdPixels = screenWidth * actionThreshold;

    int topIndex = min(startIndex!, startIndex! + offset!);
    int bottomIndex = max(startIndex!, startIndex! + offset!);

    double topPixel = topIndex * 60 - sc.offset;
    double bottomPixel = (bottomIndex + 1) * 60 - sc.offset;

    if (dragAnimation!.value > 0) {
      return AnimatedBuilder(
          animation: dragAnimation!,
          builder: (context, snapshot) {
            return Positioned(
                left: 0,
                width: dragAnimation!.value,
                top: topPixel,
                height: bottomPixel - topPixel,
                child: AnimatedContainer(
                    color: dragAnimation!.value.abs() > actionThresholdPixels
                        ? Colors.green
                        : Colors.grey,
                    duration: const Duration(milliseconds: 200),
                    child: const Center(
                        child: Icon(Icons.archive, color: Colors.white))));
          });
    } else {
      return AnimatedBuilder(
          animation: dragAnimation!,
          builder: (context, snapshot) {
            return Positioned(
                right: 0,
                width: dragAnimation!.value.abs(),
                top: topPixel,
                height: bottomPixel - topPixel,
                child: AnimatedContainer(
                    color: dragAnimation!.value.abs() > actionThresholdPixels
                        ? Colors.red
                        : Colors.grey,
                    duration: const Duration(milliseconds: 200),
                    child: const Center(
                        child: Icon(Icons.delete, color: Colors.white))));
          });
    }
  }

  void removeItemsOnAnimationCompletion() {
    void Function(AnimationStatus)? removeItemListener;
    removeItemListener = (status) {
      if (status == AnimationStatus.completed) {
        int topIndex = min(startIndex!, startIndex! + offset!);
        int bottomIndex = max(startIndex!, startIndex! + offset!);
        emails.removeRange(topIndex, bottomIndex + 1);
        startIndex = null;
        offset = null;
        dragAnimation!.removeStatusListener(removeItemListener!);
        dragAnimation!.value = 0;
        setState(() {});
      }
    };
    dragAnimation!.addStatusListener(removeItemListener);
  }

  void animateDragEnd() {
    double screenWidth = MediaQuery.of(context).size.width;
    if (dragAnimation!.value > screenWidth * actionThreshold) {
      dragAnimation!.animateTo(screenWidth,
          curve: Curves.easeInOut, duration: const Duration(milliseconds: 300));
      removeItemsOnAnimationCompletion();
    } else if (dragAnimation!.value < -(screenWidth * actionThreshold)) {
      dragAnimation!.animateTo(-screenWidth,
          curve: Curves.easeInOut, duration: const Duration(milliseconds: 300));
      removeItemsOnAnimationCompletion();
    } else {
      dragAnimation!.animateBack(0,
          curve: Curves.easeInOut, duration: const Duration(milliseconds: 300));
    }
  }

  List<Widget> getListTiles(items) {
    List<Widget> results = [];
    for (int i = 0; i < items.length; i++) {
      results.add(
        GestureDetector(
          key: Key('${items[i]}'),
          onHorizontalDragStart: (DragStartDetails deets) {
            startIndex = i;
            offset = 0;
          },
          onHorizontalDragUpdate: (DragUpdateDetails deets) {
            if (deets.primaryDelta != null) {
              setState(() {
                dragAnimation!.value += deets.primaryDelta!;
              });
            }
            offset = (deets.localPosition.dy / containerHeight).floor();
          },
          onHorizontalDragEnd: (DragEndDetails deets) {
            setState(() {
              animateDragEnd();
            });
          },
          child: AnimatedBuilder(
              animation: dragAnimation!,
              builder: (context, child) {
                return Transform.translate(
                  offset: startIndex != null &&
                          offset != null &&
                          (i >= startIndex! && i <= startIndex! + offset! ||
                              i >= startIndex! + offset! && i <= startIndex!)
                      ? Offset(dragAnimation!.value, 0)
                      : const Offset(0, 0),
                  child: Container(
                    height: containerHeight - 1,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Buy more spam! ${items[i]}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start),
                            const Text(
                              'Now with twice the salt!',
                              textAlign: TextAlign.start,
                            ),
                          ]),
                    ),
                  ),
                );
              }),
        ),
      );
      results.add(AnimatedBuilder(
          animation: dragAnimation!,
          builder: (context, snapshot) {
            return Divider(
                height: 1,
                thickness: 1,
                indent: dragAnimation!.value > 0 ? dragAnimation!.value : 0,
                endIndent:
                    dragAnimation!.value < 0 ? dragAnimation!.value.abs() : 0);
          }));
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      getActionRect(),
      ListView(controller: sc, children: getListTiles(emails))
    ]);
  }
}
