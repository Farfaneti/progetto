import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/homepage.dart';
import 'package:progetto/screens/onboarding/onboarding_impact.dart';
import 'package:progetto/services/impact.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routeDisplayName = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  static bool _passwordVisible = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: FitnessAppTheme.background,
        title: const Text('Login', style: FitnessAppTheme.headline),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                'Please login to use our app',
                style: FitnessAppTheme.body1,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Username', style: FitnessAppTheme.body1),
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
                cursorColor: FitnessAppTheme.lightPurple,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: FitnessAppTheme.purple,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: FitnessAppTheme.lightPurple,
                  ),
                  hintText: 'Username',
                  hintStyle: FitnessAppTheme.caption,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Password', style: FitnessAppTheme.body1),
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
                cursorColor: FitnessAppTheme.lightPurple,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: FitnessAppTheme.purple,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: FitnessAppTheme.lightPurple,
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
                  hintStyle: FitnessAppTheme.caption,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if ( userController.text!= 'Re2JCHK5jL' ||passwordController.text!='12345678!'){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(8),
                          content: Text('Wrong Credentials'),
                          duration: Duration(seconds: 2)
                            )
                            );

                      }
                      else if (_formKey.currentState!.validate()) {
                        var prefs =
                            Provider.of<Preferences>(context, listen: false);
                        prefs.username = userController.text;
                        prefs.password = passwordController.text;
                        ImpactService service =
                            Provider.of<ImpactService>(context, listen: false);
                        bool responseAccessToken = service
                            .checkSavedToken(); //Check if there is a token
                        bool refreshAccessToken =
                            service.checkSavedToken(refresh: true);

                        //if we have a valid token for impact, proceed
                        if (responseAccessToken || refreshAccessToken) {
                          Future.delayed(
                              const Duration(seconds: 1),
                              () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: ((context) => const HomePage(
                                            title: '',
                                          )))));
                        } else {
                          Future.delayed(
                              const Duration(seconds: 1),
                              () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          ImpactOnboarding()))));
                        }
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
                            FitnessAppTheme.purple)),
                    child: const Text('Log In'),
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
