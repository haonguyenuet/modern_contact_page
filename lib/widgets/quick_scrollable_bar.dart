import 'package:flutter/material.dart';

class QuickScrollableBar extends StatefulWidget {
  final List nameList;
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
  int _scrollBarPosSelected = 0;
  bool _scrollBarBubbleVisibility = false;

  ScrollController get scrollController => widget.scrollController;
  List get nameList => widget.nameList;

  List alphabetList = [
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

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _scrollBarBubbleVisibility = true;
      print(_offsetContainer);
      print(details);
      if ((_offsetContainer + details.delta.dy) >= 0 &&
          (_offsetContainer + details.delta.dy) <=
              (_scrollBarContainerHeight - _scrollBarHeight)) {
        _offsetContainer += details.delta.dy;
        print(_offsetContainer);
        _scrollBarPosSelected =
            ((_offsetContainer / _scrollBarHeight) % alphabetList.length)
                .round();
        print(_scrollBarPosSelected);
        _scrollBarText = alphabetList[_scrollBarPosSelected];
        if (_scrollBarText != _scrollBarTextPrev) {
          for (var i = 0; i < nameList.length; i++) {
            print(_scrollBarText.toString());
            if (_scrollBarText
                    .toString()
                    .compareTo(nameList[i].toString().toUpperCase()[0]) ==
                0) {
              print(nameList[i]);
              scrollController.jumpTo(i * _contactRowSize);
              break;
            }
          }
          _scrollBarTextPrev = _scrollBarText;
        }
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _offsetContainer = details.globalPosition.dy - _scrollBarHeightDiff;
    setState(() {
      _scrollBarBubbleVisibility = true;
    });
  }

  getBubble() {
    if (!_scrollBarBubbleVisibility) {
      return Container();
    }
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      width: 30,
      height: 30,
      child: Center(
        child: Text(
          _scrollBarText,
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }

  _getAlphabetItem(int index) {
    return Expanded(
      child: Container(
        width: 40,
        height: 20,
        alignment: Alignment.center,
        child: Text(
          alphabetList[index],
          style: (index == _scrollBarPosSelected)
              ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
              : const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  void _onVerticalEnd(DragEndDetails details) {
    setState(() {
      _scrollBarBubbleVisibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (context, constraints) {
      _scrollBarHeightDiff = _screenHeight - constraints.biggest.height;
      _scrollBarHeight = (constraints.biggest.height) / alphabetList.length;
      _scrollBarContainerHeight = (constraints.biggest.height); //NO
      return Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onVerticalDragEnd: _onVerticalEnd,
              onVerticalDragUpdate: _onVerticalDragUpdate,
              onVerticalDragStart: _onVerticalDragStart,
              child: Container(
                //height: 20.0 * 26,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      alphabetList.length,
                      (index) => _getAlphabetItem(index),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: _scrollBarMarginRight,
            top: _offsetContainer,
            child: getBubble(),
          ),
        ],
      );
    });
  }
}
