import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../methods/theme.dart';

String textHypertension =
    '''Hypertension is the major cause of premature death worldwide.
This condition has been traditionally identified by assessing blood pressure (BP) in a clinical setting (ie, office [or clinic] BP) and medical treatment adjusted accordingly.

The 2017 American College of Cardiology/American Heart Association proposed office BP of ≥130/80  mm  Hg as a new threshold for diagnosis of hypertension.
Whereas the 2018 European Society of Cardiology/European Society of Hypertension maintained an office BP threshold of ≥140/90 mm Hg to define hypertension, similar to previous guidelines.''';

String textH1 =
    '''Monitoring of BP at regular intervals during normal day life has emerged as a stronger predictor of cardiovascular disease and mortality, with threshold criteria to define hypertension based on 24-hour ABP set at 125/75 and 130/80 mm Hg in the United States2 and European guidelines, respectively.

Particularly, an increased 24-hour and nighttime ABP is associated with a high cardiovascular disease risk9—even if office BP is apparently well controlled (ie, systolic BP [SBP]/diastolic BP [DBP] <130/80 mm Hg), leading to a prevalent and especially unfavorable hypertension phenotype, the socalled 'masked uncontrolled hypertension'.

For this reason, assessment of ABP rather than—or at least together with—office BP is currently proposed for the diagnosis and control of hypertension.''';

String textH2 =
    '''Given the high prevalence and negative consequences of hypertension, strategies other than drug treatment are needed for the management of this condition. 
In this context, a main lifestyle intervention is physical exercise, although unfortunately physical inactivity is reaching pandemic proportions. 

Tailored exercise has been shown not only to reduce office BP in individuals with hypertension, but also to be as effective as most antihypertensive drugs for office BP reduction. 
Furthermore, exercise has minimal side effects compared with drugs.''';

String references =
    '''Exercise Reduces Ambulatory Blood Pressure in Patients With Hypertension: A Systematic Review and Meta-Analysis of Randomized Controlled Trials''';

class HypertensionPage extends StatelessWidget {
  const HypertensionPage({Key? key}) : super(key: key);
  static const routename = 'Hypertension';

  @override
  Widget build(BuildContext context) {
    print('${HypertensionPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(HypertensionPage.routename, style: TextStyle(color: Colors.pink),),
        backgroundColor: Color.fromARGB(255, 245, 242, 248),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
              child: ExpandablePanel(
                header: Title(
                    color: Colors.black,
                    child: Text(
                      'Definition',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    )),
                collapsed: Text(
                  textHypertension,
                  style: TextStyle(fontSize: 14),
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Text(
                  textHypertension,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            )),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
              child: ExpandablePanel(
                header: Title(
                    color: Colors.black,
                    child: Text(
                      'BP monitoring',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    )),
                collapsed: Text(
                  textH1,
                  style: TextStyle(fontSize: 14),
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Text(
                  textH1,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            )),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
              child: ExpandablePanel(
                header: Title(
                    color: Colors.black,
                    child: Text(
                      'Exercise and BP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    )),
                collapsed: Text(
                  textH2,
                  style: TextStyle(fontSize: 14),
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Text(
                  textH2,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            )),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 16),
          child: Column(
            children: [
              Title(color: Colors.pink, child: Text('References')),
              Text(references),
            ],
          ),
               )
        )
      ])),
    );
  } //build
}
