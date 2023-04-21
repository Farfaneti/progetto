import 'package:flutter/material.dart';
import 'package:progetto/screens/contents.dart';
import 'package:progetto/screens/graphs_page.dart';

import '../methods/bottom_bar_view.dart';
import '../methods/tab_icon_data.dart';
import '../methods/theme.dart';
import 'graphs_page2.dart';
//import 'package:flutter_login/flutter_login.dart';
//import 'package:login_flow/pages/login.dart';
// da importare quando è fatta la pagina di login

class HomePage extends StatefulWidget {
  static const routename = 'Home Page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    //tabBody = HomePage(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('login_flow'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              //onTap: () => _toLoginPage(context),
            )
          ],
        )),
      ),
    );
  } //build

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      GraphsScreen(animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      GraphsScreen2(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }

  // void _toLoginPage(BuildContext context) {
  //   //Pop the drawer first
  //   Navigator.pop(context);
  //   //Then pop the HomePage
  //   Navigator.of(context)
  //       .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  // } //_toCalendarPage
} //MyApp

