import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progetto/screens/contents.dart';
import 'package:progetto/screens/login_screen.dart';
import 'package:progetto/screens/profile.dart';

import '../methods/tab_icon_data.dart';
import '../methods/theme.dart';
import 'graphs_page.dart';

class HomePage extends StatefulWidget {
  static const routename = 'Home Page';
  static const route = '/home/';
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  String? _selectAppBarTitle;
  String appBarTitle = 'Graph';

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return GraphPage();
      case 1:
        return GraphPage();
      case 2:
        return Contents();
      case 3:
        return ProfilePage();
      default:
        return GraphPage();
    }
  }

  String _selectTitle({
    required int index,
  }) {
    switch (index) {
      case 0:
        return 'Graph';
      case 1:
        return 'Analysis';
      case 2:
        return 'Contents';
      case 3:
        return 'Profile';
      default:
        return 'Graph';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE4DFD4),
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: Text(_selectTitle(index: _selectedIndex)),
          // (Text(
          //   'AppName',
          // )),
          titleTextStyle: FitnessAppTheme.headline2,
          iconTheme: const IconThemeData(color: FitnessAppTheme.nearlyBlack),
          elevation: 0,
          backgroundColor: FitnessAppTheme.background,
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    // onPressed: () {
                    //Navigator.push(
                    //     context,
                    //MaterialPageRoute(
                    //fullscreenDialog: true,
                    //builder: (context) => ProfilePage()));
                    //},
                    Icon(
                  MdiIcons.accountCircle,
                  size: 40,
                  color: FitnessAppTheme.background,
                )),
          ],
        ),
        body: _selectPage(index: _selectedIndex),
        bottomNavigationBar: Container(
          color: FitnessAppTheme.background,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
              child: GNav(
                backgroundColor: FitnessAppTheme.background,
                color: FitnessAppTheme.deactivatedText,
                activeColor: FitnessAppTheme.nearlyBlue,
                tabBackgroundColor: FitnessAppTheme.dismissibleBackground,
                gap: 8,
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                padding: EdgeInsets.all(16),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Graphs',
                    textStyle: FitnessAppTheme.button,
                  ),
                  GButton(
                    icon: Icons.auto_graph_outlined,
                    text: 'Analysis',
                    textStyle: FitnessAppTheme.button,
                  ),
                  GButton(
                    icon: Icons.description_outlined,
                    text: 'Contents',
                    textStyle: FitnessAppTheme.button,
                  ),
                  GButton(
                    icon: Icons.account_circle,
                    text: 'Profile',
                    textStyle: FitnessAppTheme.button,
                  ),
                ],
              )),
        ));
  }
}


