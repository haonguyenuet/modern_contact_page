import 'package:flutter/material.dart';

class ContactRowWidget extends StatelessWidget {
  const ContactRowWidget({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: "${name.toString().split(' ')[0]} "),
              TextSpan(
                  text: name.toString().split(' ')[1],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
