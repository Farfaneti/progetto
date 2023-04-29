import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';

import '../../user/user_data.dart';

// This class handles the Page to edit the About Me Section of the User Profile.
class EditDescriptionFormPage extends StatefulWidget {
  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
    user.aboutMeDescription = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit description'),
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
                        "What type of passenger are you?",
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
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 200) {
                              return 'Please describe yourself but keep it under 200 characters.';
                            }
                            return null;
                          },
                          controller: descriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              //contentPadding: EdgeInsets.fromLTRB(8, 15, 8, 70),
                              hintMaxLines: 3,
                              hintText:
                                  'Possible survey questions: Do you practise any sport? What sport do you practise? How many times a week? Are you a smoker?'),
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
                              if (_formKey.currentState!.validate()) {
                                updateUserValue(descriptionController.text);
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
