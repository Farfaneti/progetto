import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:pollutrack/pages/home.dart';
//import 'package:pollutrack/pages/onboarding/purpleair_ob.dart';
//import 'package:pollutrack/services/impact.dart';
//import 'package:pollutrack/utils/shared_preferences.dart';
//import 'package:provider/provider.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/homepage.dart';
import 'package:progetto/screens/profile.dart';
import 'package:provider/provider.dart';

import '../../services/impact.dart';
import '../../utils/shared_preferences.dart';

class ImpactOnboarding extends StatefulWidget {
  static const route = '/impact/';
  static const routeDisplayName = 'ImpactOnboardingPage';

  ImpactOnboarding({Key? key}) : super(key: key);

  @override
  State<ImpactOnboarding> createState() => _ImpactOnboardingState();
}

class _ImpactOnboardingState extends State<ImpactOnboarding> {
  static bool _passwordVisible = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<
      FormState>(); //il comando crea una chiave globale _formKey associata a un widget FormState, che rappresenta lo stato di un widget Form e può essere utilizzata per accedere e manipolare l'oggetto FormState.

  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<bool> _loginImpact(
      String name, String password, BuildContext context) async {
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool logged = await service.getTokens(name, password);
    return logged;
  }

  void _toProfilePage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: ((context) => ProfilePage(
              nickname: '',
            ))));
  } //_toProfilePage

  void _checkProfile(BuildContext context) async {
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? weight = prefs.weight;
    String? height = prefs.height;

    // no user logged in the app
    if (weight == null || height == null) {
      Future.delayed(const Duration(seconds: 1), () => _toProfilePage(context));
    } else {
      Future.delayed(
          const Duration(milliseconds: 300),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(
                    title: '',
                    nickname: '',
                  ))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessAppTheme.grey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/impact_logo.png'),
              const Text('Please authorize to use our app',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Username',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
                controller: userController,
                cursorColor: FitnessAppTheme.grey,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: FitnessAppTheme.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF89453C),
                  ),
                  hintText: 'Username',
                  hintStyle: const TextStyle(color: FitnessAppTheme.grey),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Password',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                controller: passwordController,
                cursorColor: FitnessAppTheme.grey,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: FitnessAppTheme.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color(0xFF89453C),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _showPassword();
                    },
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: FitnessAppTheme.grey),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? validation = await _loginImpact(userController.text,
                          passwordController.text, context);
                      if (!validation) {
                        // if not correct show message
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(8),
                          content: Text('Wrong Credentials'),
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        // QUI CONTROLLO CHE LA PAGINA PROFILE SIA COMPILATA, SE è COMPILATA ALLORA MANDO ALLA HOMEPAGE,
                        //SE NON è COMPILATA MANDO ALLA PROFILE PAGE
                        // Future.delayed(const Duration(seconds: 1), () => _checkProfile(context));

                        Future.delayed(
                            const Duration(milliseconds: 300),
                            () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          title: '',
                                          nickname: '',
                                        ))));
                      }
                    },
                    style: ButtonStyle(
                        //maximumSize: const MaterialStatePropertyAll(Size(50, 20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF89453C))),
                    child: const Text('Authorize'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
