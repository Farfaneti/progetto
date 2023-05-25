import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../account.dart';
import '../utils/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  static const route = 'Profile';
  static const routename = 'ProfilePage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

//This class holds data related to the form.
class _ProfilePageState extends State<ProfilePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferences>(context);

    return Scaffold(
        backgroundColor: FitnessAppTheme.background,
        body  : Padding(
                    padding: const EdgeInsets.all(20.0),
                    // Build a Form widget using the _formKey created above.
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            initialValue: pref.nickname != null
                                ? pref.nickname
                                : '',

                            decoration: InputDecoration(
                              labelText: 'Name',
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
                                return 'Please enter your nickname';
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
                            initialValue: pref.height != null
                                ? pref.height.toString()
                                : '',
                            decoration: InputDecoration(
                              labelText: 'Height in cm',
                              labelStyle: FitnessAppTheme.subtitle,
                              prefixIcon: const Icon(
                                Icons.height,
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
                                return 'Please enter your height';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid height';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                int newheight = int.tryParse(value) ?? 0;
                                pref.height = newheight;
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
                            initialValue: pref.weight != null
                                ? pref.weight.toString()
                                : '',
                            decoration: InputDecoration(
                              labelText: 'Weight in Kg',
                              labelStyle: FitnessAppTheme.subtitle,
                              prefixIcon: const Icon(
                                Icons.monitor_weight,
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
                                return 'Please enter your weight';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid weight';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                int newweight = int.tryParse(value) ?? 0;
                                pref.weight = newweight;
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(
                                                  title: '',
                                                  
                                                )));
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          FitnessAppTheme.nearlyDarkBlue),
                                ),
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                );
              } 
            }
  
