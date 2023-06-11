import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../methods/theme.dart';

String textMET =
    '''The MET, or Metabolic Equivalent of Task, expresses the ratio between the metabolic rate during a specific activity and the resting metabolic rate. Metabolic rate is the rate of energy expended per unit of time. 

1 MET represents the amount of energy used when a person is at rest, it is set by convention at 3.5 mL of oxygen per kg per minute. So, an activity with a MET value of 4 means you're exerting four times the energy than you would if you were sitting still.


To put it in perspective, a brisk walk at 5 or 6 km per hour has a value of 4 METs. Jumping rope, which is a more vigorous activity, has a MET value of 12.3. ''';

String textM1 =
    """To calculate the MET based on calories burned and a person's weight, you need to know the activity performed and its intensity in terms of calories burned. 
MET = Total calories burned / (Person's weight (kg) x Duration of the activity (hours)).  """;
//"""To better understand METs, it’s helpful to know a little about how your body uses energy.

//The cells in your muscles use oxygen to help create the energy needed to move your muscles. One MET is approximately 3.5 milliliters of oxygen consumed per kilogram (kg) of body weight per minute.

//So, for example, if you weigh 160 pounds (72.5 kg), you consume about 254 milliliters of oxygen per minute while you’re at rest (72.5 kg x 3.5 mL).

//Energy expenditure may differ from person to person based on several factors, including your age and fitness level. For example, a young athlete who exercises daily won’t need to expend the same amount of energy during a brisk walk as an older, sedentary person.

//For most healthy adults, MET values can be helpful in planning an exercise regimen, or at least gauging how much you’re getting out of your workout routine. """;

String textM2 =
    """MET-min (MET in minutes) is categorized as insufficient physical activity recommended by WHO with a cut-off of 0 to 600 MET-min, moderate physical activity with a cut-off of 601–3000 MET-min per week and high physical activity with a cut-off of greater than 3000 MET-min per week. """;

String textM3 =
    """Moderate to high physical activity levels are associated with a lower blood pressure level. Awareness of the health benefits of physical activity is associated with a lower level of blood pressure, and people with positive attitudes towards physical activity have 5 to 10 mmHg lower blood pressure levels compared to those who have negative attitudes toward taking part in physical activities.

In a study of dose-response of physical activity in controlling blood pressure, reported that 61–90 minutes/week exercise was associated with a significant
reduction in SBP compared to 30–60 min/week physical activity. 

Another study reported that any physical activity was associated with health benefit and 150–300 min/week of moderate-intensity activity were associated with substantial health benefits. 
International physical activity guidelines recommend that adults should engage in at least 30 minutes a day of at least moderate-intensity activity. """;

//Climie et al. had provided more insight into the association of domain-specific physical activity with cardiovascular diseases through a large cross-sectional.
//The study reported that physical activity related to occupation was associated with worse neural baroreflex sensitivity.
//In contrast, sports physical activity was associated with better neural baroreflex sensitivity. The findings indicate that different mechanisms of associations could be between domains of physical activity and blood pressure control.""";

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
