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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Graph1',
              textAlign: TextAlign.left,
              style: FitnessAppTheme.title,
            ),
          ),
          // va messo il grafico 1
          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Graph2',
              textAlign: TextAlign.left,
              style: FitnessAppTheme.title,
            ),
          ),
          // va messo il grafico 2
        ],
      ),
    );
  } //build
}
