import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import '../../methods/theme.dart';
import '../../user/user_data.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void updateUserValue(String email) {
    user.email = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit email'),
          titleTextStyle: FitnessAppTheme.headline2,
          backgroundColor: FitnessAppTheme.background,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                      width: 350,
                      child: const Text(
                        "What's your email?",
                        style: FitnessAppTheme.headline,
                        textAlign: TextAlign.center,
                      )),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(8, 30, 8, 8),
                    child: SizedBox(
                        height: 100,
                        width: 350,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              // contentPadding: EdgeInsets.fromLTRB(8, 15, 8, 70),
                              labelText: 'Your email address',
                              floatingLabelStyle: FitnessAppTheme.body1,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start),
                          controller: emailController,
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => FitnessAppTheme.purple)),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate() &&
                                  EmailValidator.validate(
                                      emailController.text)) {
                                updateUserValue(emailController.text);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
