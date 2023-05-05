import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:progetto/methods/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    //Check if the user is already logged in before rendering the login page
    _checkLogin();
  }//initState



  

  void _checkLogin() async {
    //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
    final sp = await SharedPreferences.getInstance();
    if(sp.getString('username') != null){
      //If 'username is set, push the HomePage
      _toHomePage(context);
    }//if
  }//_checkLogin

  Future<String> _loginUser(LoginData data) async {
    if(data.name == 'bug@expert.com' && data.password == '5TrNgP5Wd'){

      final sp = await SharedPreferences.getInstance();
      sp.setString('username', data.name);

      return '';
    } else {
      return 'Wrong credentials';
    }
  } 
 // _loginUser
  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  } 
 // _signUpUser
  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  } 


 // _recoverPassword

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Sign in',
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async{
        _toHomePage(context);
      },
      theme: LoginTheme(primaryColor: FitnessAppTheme.lightPurple,
      accentColor: Colors.white),
    );
  } // build
  void _toHomePage(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(title: 'Homepage',)));
  }//_toHomePage
  
  } // LoginScreen