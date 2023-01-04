import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart_practice/widgets/contact_list_tile.dart';
import 'package:rxdart_practice/widgets/gradient_fab.dart';
import 'package:rxdart_practice/widgets/quick_scrollable_bar.dart';

List nameList = [
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

class _ContactsPageState extends State<ContactsPage>
    with TickerProviderStateMixin {
  late ScrollController scrollController;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            CustomScrollView(controller: scrollController, slivers: <Widget>[
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
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ContactRowWidget(name: nameList[index]);
                }, childCount: nameList.length),
              )
            ]),
            Container(
              margin: const EdgeInsets.only(top: 190),
              child: QuickScrollableBar(
                nameList: nameList,
                scrollController: scrollController,
              ),
            ),
          ],
        ),
        floatingActionButton: GradientFab(animation: animation),
      ),
    );
  }

  //scroll listener for checking scroll direction and hide/show fab
  scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
