import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../../methods/theme.dart';
import '../../user/user_data.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void updateUserValue(String phone) {
    String formattedPhoneNumber = "(" +
        phone.substring(0, 3) +
        ") " +
        phone.substring(3, 6) +
        "-" +
        phone.substring(6, phone.length);
    user.phone = formattedPhoneNumber;
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
                        "What's Your Phone Number?",
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
                              return 'Please enter your phone number';
                            } else if (isAlpha(value)) {
                              return 'Only Numbers Please';
                            } else if (value.length < 10) {
                              return 'Please enter a VALID phone number';
                            }
                            return null;
                          },
                          controller: phoneController,
                          decoration: const InputDecoration(
                              labelText: 'Your Phone Number',
                              floatingLabelStyle: FitnessAppTheme.body1,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start),
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
                                  isNumeric(phoneController.text)) {
                                updateUserValue(phoneController.text);
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
