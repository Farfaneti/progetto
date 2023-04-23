import 'package:flutter/material.dart';

import '../methods/theme.dart';
import '../methods/title_view.dart';

class GraphPage extends StatelessWidget {
  GraphPage({Key? key}) : super(key: key);

  static const routename = 'GraphPage';

  @override
  Widget build(BuildContext context) {
    print('${GraphPage.routename} built');
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
      body: Column(
        children: [
          //TitleView(
          //   titleTxt: 'Graph1',
          // ),
          Text('Graph1',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: 0.5,
                color: FitnessAppTheme.lightText,
              ))
        ],
      ),
    );
  } //build
}
