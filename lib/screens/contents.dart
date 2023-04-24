import 'package:flutter/material.dart';
import 'package:progetto/screens/text_contents/text1.dart';
import 'package:progetto/screens/text_contents/text2.dart';

import '../methods/theme.dart';

class Contents extends StatelessWidget {
  const Contents({Key? key}) : super(key: key);

  static const routename = 'Content';

  @override
  Widget build(BuildContext context) {
    print('${Contents.routename} built');
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
      body:  SingleChildScrollView(
        child: Column(children: <Widget>[
      
        Hypertension(),
        METindex(),
       
      ]),
      )
    );
  } //build
}

class Hypertension extends StatelessWidget {
  const Hypertension({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: FitnessAppTheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: const AssetImage('assets/hypertension.jpg'),
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            Title(
                color: FitnessAppTheme.darkText,
                child: Text(
                  'Hypertension',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                    fontSize: 24,
                  ),
                )),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              child: const Text(
                'Hypertension is the major cause of premature death worldwide.  Aerobic exercise is an effective coadjuvant treatment for reducing ambulatory blood pressure in patients with hypertension.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => HypertensionPage())),
                    child: const Text('Learn more'))
              ],
            )
          ],
        ));
  }
}

class METindex extends StatelessWidget {
  const METindex({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: FitnessAppTheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Stack(children: [
              Ink.image(
                image: const AssetImage('assets/Met.png'),
                height: 250,
                fit: BoxFit.fill,
              ),
            ]),
            Title(
                color: FitnessAppTheme.darkText,
                child: Text(
                  'Metabolic Equivalent of Task (MET)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                    fontSize: 24,
                  ),
                )),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              child: const Text(
                '''A MET is a ratio of your working metabolic rate relative to your resting metabolic rate. Metabolic rate is the rate of energy expended per unit of time. Aiming for at least 600 MET minutes a week is a good goal for optimal cardiovascular health.''',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MetPage())),
                    child: const Text('Learn more'))
              ],
            )
          ],
        ));
  }
}
