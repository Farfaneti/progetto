import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}


class AccountPageState extends State<AccountPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferences>(context);
    return Scaffold(
        backgroundColor: FitnessAppTheme.background,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: FitnessAppTheme.nearlyBlack,
          ),
          title: const Text('My Account'),
          centerTitle: true,
          titleTextStyle: FitnessAppTheme.headline2,
          backgroundColor: FitnessAppTheme.background,
        ),
        body: Column(children: [
          const SizedBox(height: 12),
          const CircleAvatar(
            radius: 52,
            backgroundColor: FitnessAppTheme.background,
            backgroundImage: AssetImage('assets/avatar1.png'),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(20.0),
          
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        initialValue:
                            pref.nickname != null ? pref.nickname : '',

                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: FitnessAppTheme.subtitle,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: FitnessAppTheme.lightPurple,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: FitnessAppTheme.lightPurple),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),

                   
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          
                          setState(() {
                            String newnickname = value;
                            pref.nickname = newnickname;
                          });
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: FitnessAppTheme.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: pref.email != null ? pref.email : '',
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: FitnessAppTheme.subtitle,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: FitnessAppTheme.lightPurple,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: FitnessAppTheme.lightPurple),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email: example@example.com';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            String newemail = value;
                            pref.email = newemail;
                          });
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: FitnessAppTheme.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue:
                            pref.age != null ? pref.age.toString() : '',
                        decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle: FitnessAppTheme.subtitle,
                          prefixIcon: const Icon(
                            Icons.numbers_rounded,
                            color: FitnessAppTheme.lightPurple,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: FitnessAppTheme.lightPurple),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your age';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid age';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            int newage = int.tryParse(value) ?? 0;
                            pref.age = newage;
                          });
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: FitnessAppTheme.grey,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              
                              if (_formKey.currentState!.validate()) {
                               

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Profile saved'),
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  FitnessAppTheme.nearlyDarkBlue),
                            ),
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ])),
          ),
        ]));
  }
}
