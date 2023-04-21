// § The HomePage must show the provided username.

import 'package:flutter/material.dart';

import '../methods/bottom_bar_view.dart';
import '../methods/tab_icon_data.dart';
import '../methods/theme.dart';
//import 'package:flutter_login/flutter_login.dart';
//import 'package:login_flow/pages/login.dart';
// da imortare quando è fatta la pagina di login

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const routename = 'Home Page';
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

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
          children: const [
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
          // changeIndex: (int index) {
          //   if (index == 0 || index == 2) {
          //     animationController?.reverse().then<dynamic>((data) {
          //       if (!mounted) {
          //         return;
          //       }
          //       setState(() {
          //         tabBody =
          //             MyDiaryScreen(animationController: animationController);
          //       });
          //     });
          //   } else if (index == 1 || index == 3) {
          //     animationController?.reverse().then<dynamic>((data) {
          //       if (!mounted) {
          //         return;
          //       }
          //       setState(() {
          //         tabBody =
          //             TrainingScreen(animationController: animationController);
          //       });
          //     });
          //   }
          // },
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

