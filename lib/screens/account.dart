import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

//This class holds data related to the form.
class _AccountPageState extends State<AccountPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferences>(context);
    return Scaffold(
        backgroundColor: FitnessAppTheme.background,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: FitnessAppTheme.nearlyBlack, //change your color here
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
            // Build a Form widget using the _formKey created above.
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

                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          // La funzione onChanged viene chiamata ogni volta che l'utente modifica il testo del campo di input.
                          //La utilizzo per aggiornare lo stato del widget, cioè per aggiornare il valore di una variabile
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
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar and save the information in a database.

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
