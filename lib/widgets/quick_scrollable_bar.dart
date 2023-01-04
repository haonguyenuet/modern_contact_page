import 'package:flutter/material.dart';

const List alphabets = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

class QuickScrollableBar extends StatefulWidget {
  final List<String> nameList;
  final ScrollController scrollController;

  const QuickScrollableBar({
    super.key,
    required this.nameList,
    required this.scrollController,
  });

  @override
  State<QuickScrollableBar> createState() => _QuickScrollableBarState();
}

class _QuickScrollableBarState extends State<QuickScrollableBar> {
  final double _contactRowSize = 45.0;
  final double _scrollBarMarginRight = 50.0;

  String _scrollBarText = "";
  String _scrollBarTextPrev = "";
  double _screenHeight = 0.0;
  double _offsetContainer = 0.0;
  double _scrollBarHeight = 0.0;
  double _scrollBarContainerHeight = 0.0;
  double _scrollBarHeightDiff = 0.0;
  int _scrollBarIndexSelected = 0;
  bool _scrollBarBubbleVisibility = false;

  ScrollController get scrollController => widget.scrollController;
  List<String> get nameList => widget.nameList;

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    print("details.delta.dy ${details.delta.dy}");
    setState(() {
      _scrollBarBubbleVisibility = true;
      if ((_offsetContainer + details.delta.dy) >= 0 &&
          (_offsetContainer + details.delta.dy) <=
              (_scrollBarContainerHeight - _scrollBarHeight)) {
        _offsetContainer += details.delta.dy;
        _scrollBarIndexSelected =
            ((_offsetContainer / _scrollBarHeight) % alphabets.length).round();
        _scrollBarText = alphabets[_scrollBarIndexSelected];
        if (_scrollBarText != _scrollBarTextPrev) {
          for (var i = 0; i < nameList.length; i++) {
            print(_scrollBarText.toString());
            if (_scrollBarText == nameList[i].toUpperCase()[0]) {
              scrollController.animateTo(
                i * _contactRowSize,
                duration: const Duration(milliseconds: 200),
                curve: Curves.bounceIn,
              );
              break;
            }
          }
          _scrollBarTextPrev = _scrollBarText;
        }
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    print("details.globalPosition.dy ${details.globalPosition.dy}");

    _offsetContainer = details.globalPosition.dy - _scrollBarHeightDiff;
    setState(() {
      _scrollBarBubbleVisibility = true;
    });
  }

  void _onVerticalEnd(DragEndDetails details) {
    setState(() {
      _scrollBarBubbleVisibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    // print("_screenHeight $_screenHeight");

    return LayoutBuilder(
      builder: (context, constraints) {
        _scrollBarContainerHeight = 20.0 * alphabets.length;
        _scrollBarHeightDiff = _screenHeight - _scrollBarContainerHeight;
        _scrollBarHeight = 20;

        // _scrollBarHeightDiff = _screenHeight - constraints.biggest.height;
        // _scrollBarHeight = (constraints.biggest.height) / alphabets.length;
        // _scrollBarContainerHeight = (constraints.biggest.height); //NO
        print("_scrollBarHeightDiff $_scrollBarHeightDiff");
        print("_scrollBarHeight $_scrollBarHeight");
        print("_scrollBarContainerHeight $_scrollBarContainerHeight");
        return Container(
          color: Colors.amber,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onVerticalDragEnd: _onVerticalEnd,
                  onVerticalDragUpdate: _onVerticalDragUpdate,
                  onVerticalDragStart: _onVerticalDragStart,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        alphabets.length,
                        (index) => _buildAlphabetItem(index),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: _scrollBarMarginRight,
                top: _offsetContainer,
                child: _buildBubble(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlphabetItem(int index) {
    return Container(
      width: 40,
      height: 20,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text(
        alphabets[index],
        style: (index == _scrollBarIndexSelected)
            ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
            : const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildBubble() {
    if (!_scrollBarBubbleVisibility) {
      return const SizedBox();
    }
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      width: 30,
      height: 30,
      child: Text(_scrollBarText),
    );
  }
}
