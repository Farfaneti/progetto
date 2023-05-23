import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  final String nickname;
  AccountPage({super.key, required this.nickname});

  @override
  _AccountPageState createState() => _AccountPageState();
}

//This class holds data related to the form.
class _AccountPageState extends State<AccountPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String _nickname = '';
  String _email = '';
  int _age = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nickname = prefs.getString('nickname') ??
          ''; //legge il valore della chiave username dalle SharedPreferences e restituisce una stringa vuota se il valore non è stato trovato
      _email = prefs.getString('email') ?? '';
      _age = prefs.getInt('age') ?? 0;
    });
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _nickname);
    await prefs.setString('email', _email);
    await prefs.setInt('age', _age);
    final username = prefs.getString('username') ?? '';
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(nickname: _nickname, title: '')),
    );
  }

  Future<void> _deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('nickname');
    prefs.remove('email');
    prefs.remove('age');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(nickname: '', title: '')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  const SizedBox(height: 12),
                  const CircleAvatar(
                    radius: 52,
                    backgroundColor: FitnessAppTheme.background,
                    backgroundImage: AssetImage('assets/avatar.png'),
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
                            initialValue: _nickname,

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
                                _nickname = value;
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
                            initialValue: _email,
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
                                _email = value;
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
                            initialValue: _age.toString(),
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
                                _age = int.tryParse(value) ?? 0;
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
                                    _saveUserData();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Profile saved'),
                                      ),
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          FitnessAppTheme.nearlyDarkBlue),
                                ),
                                child: const Text('Save'),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // If the form is valid, display a snackbar and save the information in a database.
                                  _deleteUserData();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AccountPage(
                                            nickname: '',
                                          )));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Profile deleted'),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          FitnessAppTheme.nearlyDarkBlue),
                                ),
                                child: const Text('Delete All'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]);
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
