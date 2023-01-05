import 'package:flutter/material.dart';
import 'package:rxdart_practice/widgets/contact_list_tile.dart';

const List<String> alphabets = [
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
  final List<String> names;
  final ScrollController scrollController;

  const QuickScrollableBar({
    super.key,
    required this.names,
    required this.scrollController,
  });

  @override
  State<QuickScrollableBar> createState() => _QuickScrollableBarState();
}

class _QuickScrollableBarState extends State<QuickScrollableBar> {
  final double _scrollBarItemHeight = 20;

  String _scrollBarText = "";
  String _scrollBarTextPrev = "";
  double _screenHeight = 0.0;
  double _bubbleOffset = 0.0;
  double _scrollBarHeight = 0.0;
  double _remainingHeight = 0.0;
  int _selectedAlphabetIndex = 0;
  bool _bubbleVisibility = false;

  ScrollController get scrollController => widget.scrollController;
  List<String> get names => widget.names;

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _bubbleVisibility = true;
      if ((_bubbleOffset + details.delta.dy) >= 0 &&
          (_bubbleOffset + details.delta.dy) <= (_scrollBarHeight - _scrollBarItemHeight)) {
        _bubbleOffset += details.delta.dy;
        _selectedAlphabetIndex =((_bubbleOffset / _scrollBarItemHeight) % alphabets.length).round();
        _scrollBarText = alphabets[_selectedAlphabetIndex];

        if (_scrollBarText != _scrollBarTextPrev) {
          final nameIndex = names.indexWhere((name) => _scrollBarText == name.toUpperCase()[0]);
          if (nameIndex != -1) {
            scrollController.animateTo(
              (nameIndex + 1) * contactListTileHeight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceIn,
            );
          }
          _scrollBarTextPrev = _scrollBarText;
        }
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _bubbleOffset = details.globalPosition.dy - _remainingHeight / 2;
    setState(() {
      _bubbleVisibility = true;
    });
  }

  void _onVerticalEnd(DragEndDetails details) {
    setState(() {
      _bubbleVisibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _scrollBarHeight = _scrollBarItemHeight * alphabets.length;
    _remainingHeight = _screenHeight - _scrollBarHeight;

    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onVerticalDragEnd: _onVerticalEnd,
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragStart: _onVerticalDragStart,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                alphabets.length,
                (index) => _buildAlphabetItem(index),
              ),
            ),
          ),
        ),
        Positioned(
          right: 50.0,
          top: _bubbleOffset + _remainingHeight / 2,
          child: _buildBubble(),
        ),
      ],
    );
  }

  Widget _buildAlphabetItem(int index) {
    return Container(
      width: 40,
      height: _scrollBarItemHeight,
      alignment: Alignment.center,          
      child: Text(
        alphabets[index],
        style: const TextStyle(
          fontSize: 12, 
          fontWeight: FontWeight.w400, 
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBubble() {
    if (!_bubbleVisibility) {
      return const SizedBox();
    }
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
      ),
      child: Text(
        _scrollBarText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
