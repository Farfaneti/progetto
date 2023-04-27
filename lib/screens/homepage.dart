import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progetto/screens/contents.dart';
import 'package:progetto/screens/login_screen.dart';
import 'package:progetto/screens/profile.dart';

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
        return GraphPage();
      case 2:
        return Contents();
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
                  GButton(icon: Icons.auto_graph_outlined, text: 'Analysis'),
                  GButton(icon: Icons.description_outlined, text: 'Contents'),
                  GButton(icon: Icons.account_circle, text: 'Profile'),
                ],
              )),
        ));
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) => Material(
      color: Colors.pink.shade100,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: const [
              CircleAvatar(
                radius: 52,
              ),
              SizedBox(height: 12),
              Text(
                ' nome utente',
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
              Text(
                'utente@mail.com',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ));
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Information'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Contents(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Login_screen(),
                  ),
                );
              },
            )
          ],
        ),
      );
}
