import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../methods/theme.dart';

String textMET =
    '''The MET, or Metabolic Equivalent of Task, expresses the ratio between the metabolic rate during a specific activity and the resting metabolic rate. Metabolic rate is the rate of energy expended per unit of time. 

1 MET represents the amount of energy used when a person is at rest, it is set by convention at 3.5 mL of oxygen per kg per minute. So, an activity with a MET value of 4 means you're exerting four times the energy than you would if you were sitting still.
1 MET is also equivalent to 1 Kcal/kg/h, 1 kilocalorie per kilogram of body weight for hours of activity.

To put it in perspective, a brisk walk at 5 or 6 km per hour has a value of 4 METs. Jumping rope, which is a more vigorous activity, has a MET value of 12.3. ''';

String textM1 =
    """To calculate the MET based on calories burned and a person's weight, you need to know the activity performed and its intensity in terms of calories burned. 
MET = Total calories burned / (Person's weight (kg) x Duration of the activity (hours)).  """;

String textM2 =
    """According to  WHO, MET-min (MET in minutes) is categorized as: 

  -Insufficient physical activity  with a cut-off of 0 to 600 MET-min per week

  -Moderate physical activity with a cut-off of 601–3000 MET-min per week

  -High physical activity with a cut-off of greater than 3000 MET-min per week """;

String textM3 =
    """Moderate to high physical activity levels are associated with a lower blood pressure level. Awareness of the health benefits of physical activity is associated with a lower level of blood pressure, and people with positive attitudes towards physical activity have 5 to 10 mmHg lower blood pressure levels compared to those who have negative attitudes toward taking part in physical activities.

A study conducted on a total of 307 adults aged 30 to 75 years with hypertension reported that:
MET-min less than 600 min/week was significantly associated with higher SBP 153.8 (148.1, 159.6) than MET-min 600-2999 min/week 148.0 (143.0, 152.9) and MET-min>3000 min/week 146.9 (144.5, 149.3). 
Sitting time more than four hours a day was associated with higher DBP 91.4 (89.7, 93.0) compared to those who had sitting time less than fours a day 88.6 (87.1, 90.1).  """;


String references =
    """Islam FMA, Islam MA et al. (2023) Associations of physical activity levels, and attitudes towards physical activity with blood pressure among adults with high blood pressure in Bangladesh """;

class MetPage extends StatelessWidget {
  const MetPage({Key? key}) : super(key: key);
  static const routename = 'MET index';
  @override
  Widget build(BuildContext context) {
    print('${MetPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: FitnessAppTheme.grey,
        ),
        title: const Text(
          MetPage.routename,
          style: FitnessAppTheme.headline2,
        ),
        backgroundColor: FitnessAppTheme.background,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            shadowColor: FitnessAppTheme.purple,
            color: FitnessAppTheme.nearlyWhite,
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
              child: ExpandablePanel(
                header: Title(
                    color: Colors.black,
                    child: const Text(
                      'What is MET?',
                      style: FitnessAppTheme.title,
                    )),
                collapsed: Text(
                  textMET,
                  style: FitnessAppTheme.body2,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                expanded: Text(
                  textMET,
                  style: FitnessAppTheme.body2,
                  textAlign: TextAlign.justify,
                ),
              ),
            )),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            shadowColor: FitnessAppTheme.purple,
            color: FitnessAppTheme.nearlyWhite,
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
              child: ExpandablePanel(
                header: Title(
                    color: Colors.black,
                    child: const Text(
                      'How is MET calculated?',
                      style: FitnessAppTheme.title,
                    )),
                collapsed: Text(
                  textM1,
                  style: FitnessAppTheme.body2,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                expanded: Text(
                  textM1,
                  style: FitnessAppTheme.body2,
                  textAlign: TextAlign.justify,
                ),
              ),
            )),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            shadowColor: FitnessAppTheme.purple,
            color: FitnessAppTheme.nearlyWhite,
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
              child: ExpandablePanel(
                header: Title(
                    color: Colors.black,
                    child: const Text(
                      'MET-min cut-off',
                      style: FitnessAppTheme.title,
                    )),
                collapsed: Text(
                  textM2,
                  style: FitnessAppTheme.body2,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                expanded: Text(
                  textM2,
                  style: FitnessAppTheme.body2,
                  textAlign: TextAlign.justify,
                ),
              ),
            )),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            shadowColor: FitnessAppTheme.purple,
            color: FitnessAppTheme.nearlyWhite,
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
              child: ExpandablePanel(
                header: Title(
                    color: Colors.black,
                    child: const Text(
                      'Physical activity and blood pressure control',
                      style: FitnessAppTheme.title,
                    )),
                collapsed: Text(
                  textM3,
                  style: FitnessAppTheme.body2,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                expanded: Text(
                  textM3,
                  style: FitnessAppTheme.body2,
                  textAlign: TextAlign.justify,
                ),
              ),
            )),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            shadowColor: FitnessAppTheme.purple,
            color: FitnessAppTheme.nearlyWhite,
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
              child: Column(
                children: [
                  Title(
                      color: Colors.pink,
                      child: const Text('References',
                          style: TextStyle(fontStyle: FontStyle.italic))),
                  Text(
                    references,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ))
      ])),
    );
  } //build
}
