import 'package:flutter/material.dart';


class MetPage extends StatelessWidget {
const MetPage({Key? key}) : 
super(key: key);
static const routename = 'Met Index';
@override
Widget build(BuildContext context) {
print('${MetPage.routename} built');
return Scaffold(
appBar: AppBar(
title: Text(MetPage.routename),
),

body: Center(
child: Column(
  
),
),
);
} //build
} 