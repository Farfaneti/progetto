import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class Login_screen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Widget buildEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Email',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color.fromARGB(204, 219, 61, 233),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black26)),
          ))
    ],
  );
}

Widget buildPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Password',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: const TextField(
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color.fromARGB(204, 219, 61, 233),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black26)),
          ))
    ],
  );
}

// Widget BuildForgotPassword() {
//   return Container(
//     alignment: Alignment.centerRight,
//     child: TextButton(
//       onPressed: () => print('Forgot Password Pressed'),
//       child: Text('Forgot Password',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//     ),
//   );
// }

Widget buildLoginBtn() {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => print('Login Pressed'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(
              color: Color.fromARGB(204, 219, 61, 233),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ));
}

class _LoginScreenState extends State<Login_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(195, 188, 148, 213),
                      Color.fromARGB(195, 179, 111, 221),
                      Color.fromARGB(195, 166, 75, 222),
                      Color.fromARGB(195, 152, 41, 221),
                    ])),
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Sign in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 50),
                        buildEmail(),
                        SizedBox(height: 20),
                        buildPassword(),
                        // BuildForgotPassword(),
                        buildLoginBtn()
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
