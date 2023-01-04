import 'package:flutter/material.dart';
import 'package:rxdart_practice/widgets/contact_list_tile.dart';
import 'package:rxdart_practice/widgets/quick_scrollable_bar.dart';

const List<String> nameList = [
  'Anya Ostrem',
  'Burt Hutchison',
  'Chana Sobolik',
  'Chasity Nutt',
  'Deana Tenenbaum',
  'Denae Cornelius',
  'Elisabeth Saner',
  'Eloise Rocca',
  'Eloy Kallas',
  'Esther Hobby',
  'Euna Sulser',
  'Florinda Convery',
  'Franklin Nottage',
  'Gale Nordeen',
  'Garth Vanderlinden',
  'Gracie Schulte',
  'Inocencia Eaglin',
  'Jillian Germano',
  'Jimmy Friddle',
  'Juliann Bigley',
  'Kia Gallaway',
  'Larhonda Ariza',
  'Larissa Reichel',
  'Lavone Beltz',
  'Lazaro Bauder',
  'Len Northup',
  'Leonora Castiglione',
  'Lynell Hanna',
  'Madonna Heisey',
  'Marcie Borel',
  'Margit Krupp',
  'Marvin Papineau',
  'Mckinley Yocom',
  'Melita Briones',
  'Moses Strassburg',
  'Nena Recalde',
  'Norbert Modlin',
  'Onita Sobotka',
  'Raven Ecklund',
  'Robert Waldow',
  'Roxy Lovelace',
  'Rufina Chamness',
  'Saturnina Hux',
  'Shelli Perine',
  'Sherryl Routt',
  'Soila Phegley',
  'Tamera Strelow',
  'Tammy Beringer',
  'Vesta Kidd',
  'Yan Welling'
];

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactsPageState();

  const ContactsPage({super.key});
}

class _ContactsPageState extends State<ContactsPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            slivers: [
              const SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 180.0,
                pinned: true,
                elevation: 0,
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Contacts"),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ContactListTile(name: nameList[index]);
                  },
                  childCount: nameList.length,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: QuickScrollableBar(
              nameList: nameList,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
