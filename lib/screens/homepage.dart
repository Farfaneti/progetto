import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progetto/account.dart';
import 'package:progetto/screens/contents.dart';
import 'package:progetto/screens/login_screen.dart';
import 'package:progetto/screens/profile.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../methods/theme.dart';
import 'graphs_page.dart';

class HomePage extends StatefulWidget {
  static const routename = 'Home Page';
  static const route = '/home/';
  final String title;
  final String username;

  const HomePage({Key? key, required this.title, required this.username})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  String? _selectAppBarTitle;
  String appBarTitle = 'Graph';

  //String get username => null;

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return GraphPage();
      case 1:
        return GraphPage();
      case 2:
        return const Contents();
      case 3:
        return ProfilePage(
          username: '',
        );
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

  String username = '';

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE4DFD4),
        drawer: Drawer(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: UserAccountsDrawerHeader(
                  accountName: Center(
                      child: Text(
                    username,
                    style: FitnessAppTheme.subtitle,
                  )),
                  accountEmail: null,
                  decoration: const BoxDecoration(
                    backgroundBlendMode: BlendMode.colorBurn,
                    color: FitnessAppTheme.lightText,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                child: Wrap(
                  runSpacing: 16,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text(
                        'Information',
                        style: FitnessAppTheme.body1,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Contents(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text(
                        'My account',
                        style: FitnessAppTheme.body1,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AccountPage(
                              username: '',
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(color: FitnessAppTheme.grey),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text(
                        'Logout',
                        style: FitnessAppTheme.body1,
                      ),
                      onTap: () async {
                        bool reset = await Preferences().resetSettings();
                        if (reset) {
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
        ),
        appBar: AppBar(
          title: Text(_selectTitle(index: _selectedIndex)),
          // (Text(
          //   'AppName',
          // )),
          titleTextStyle: FitnessAppTheme.headline2,
          iconTheme: const IconThemeData(color: FitnessAppTheme.nearlyBlack),
          elevation: 0,
          backgroundColor: FitnessAppTheme.background,
          actions: const [
            Padding(
                padding: EdgeInsets.all(8.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
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
                padding: const EdgeInsets.all(16),
                tabs: const [
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
