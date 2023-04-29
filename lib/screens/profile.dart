import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';

import '../user/user.dart';

import '../user/user_data.dart';

import 'edit_profile_pages/edit_description.dart';
import 'edit_profile_pages/edit_mail.dart';
import 'edit_profile_pages/edit_name.dart';
import 'edit_profile_pages/edit_phone.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          Column(
            children: [
              const Center(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'User Profile',
                        style: FitnessAppTheme.headline,
                      ))),
              Center(
                  child: CircleAvatar(
                      radius: 70, child: Image.asset('assets/avatar.png'))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(width: 10),
                        const Text('Gender', style: FitnessAppTheme.subtitle),
                        Radio(
                          fillColor: MaterialStateColor.resolveWith((states) =>
                              const Color.fromARGB(255, 140, 138, 138)),
                          value: 1,
                          groupValue: 1,
                          onChanged: (val) {},
                        ),
                        const Text(
                          'MALE',
                          style: FitnessAppTheme.body1,
                        ),
                        Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color.fromARGB(255, 140, 138, 138)),
                            value: 2,
                            groupValue: 1,
                            onChanged: (val) {}),
                        const Text(
                          'FEMALE',
                          style: FitnessAppTheme.body1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildAbout(user),
          ])
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                  color: FitnessAppTheme.purple),
                            ))),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 80,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.aboutMeDescription,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                    color: FitnessAppTheme.purple,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
