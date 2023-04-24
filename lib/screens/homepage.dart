import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progetto/screens/contents.dart';

import '../methods/tab_icon_data.dart';
import '../methods/theme.dart';
import 'graphs_page.dart';

//import 'package:flutter_login/flutter_login.dart';
//import 'package:login_flow/pages/login.dart';
// da importare quando è fatta la pagina di login

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
        return Contents();
      case 2:
        return GraphPage();
      case 3:
        return Contents();
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
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                  leading: const Icon(
                    MdiIcons.logout,
                    color: FitnessAppTheme.nearlyBlue,
                  ),
                  title: const Text(
                    'Logout',
                    selectionColor: FitnessAppTheme.darkText,
                  ),
                  // delete all data from the database
                  onTap: () => {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => LoginPage(),
                        // ))
                      }),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('About'),
              ),
              ListTile(
                  leading: const Icon(MdiIcons.imageFilterDrama,
                      color: FitnessAppTheme.nearlyBlue),
                  title: const Text('Profile',
                      selectionColor: FitnessAppTheme.darkText),
                  //delete all data from the database
                  onTap: () => {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => UserPage(),
                        // ))
                      }),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(_selectTitle(index: _selectedIndex)),
          // (Text(
          //   'AppName',
          // )),
          titleTextStyle: FitnessAppTheme.headline,
          iconTheme: const IconThemeData(color: FitnessAppTheme.nearlyBlack),
          elevation: 0,
          backgroundColor: FitnessAppTheme.background,
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    // onPressed: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           fullscreenDialog: true,
                    //           builder: (context) => Profile()));
                    // },
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
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
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
                  GButton(icon: Icons.home, text: 'Graphs'),
                  GButton(icon: Icons.favorite_border, text: 'Analysis'),
                  GButton(icon: Icons.content_copy, text: 'Contents'),
                  GButton(icon: Icons.settings, text: 'Profile'),
                ],
              )),
        ));
  }
}
