import 'package:flutter/material.dart';

class GradientFab extends StatelessWidget {
  const GradientFab({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.linear,
      child: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomRight,
                colors: [
                  Colors.greenAccent,
                  Colors.green,
                ],
              ),
            ),
            child: const Icon(Icons.add),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
