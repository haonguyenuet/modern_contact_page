import 'package:flutter/material.dart';

const contactListTileHeight = 45.0;

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: contactListTileHeight,
      padding: const EdgeInsets.only(left: 30),
      color: Colors.black,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: "${name.toString().split(' ')[0]} ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: name.toString().split(' ')[1],
            ),
          ],
        ),
      ),
    );
  }
}
