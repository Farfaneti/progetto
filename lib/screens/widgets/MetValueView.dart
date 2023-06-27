import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/provider/homeprovider.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

class MetValueView extends StatefulWidget {
  // final AnimationController? animationController;
  // final Animation<double>? animation;

  const MetValueView({Key? key}) : super(key: key);

  @override
  State<MetValueView> createState() => _MetValueView();
}

class _MetValueView extends State<MetValueView> {
  double WeeklyMet = 0;
  double targetMETmin = 4000 * 0.75;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final pref = Provider.of<Preferences>(context);
    var weight = pref.weight;

    // Calculate the Met value
    DateTime specificDay =
        DateTime.now(); // Replace with your desired specific day
    // Calculate the weekly Met value until the specific day
    Future<double> WeeklyMet =
        homeProvider.calculateMET(specificDay, weight!);
       
    return Container(
      //animation: animationController!,

      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          
          decoration: BoxDecoration(
            color: FitnessAppTheme.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FitnessAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8, top: 8),
                      child: Text(
                        "Weekly Met/min value:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: -0.1,
                            color: FitnessAppTheme.nearlyDarkBlue),
                      ),
                    ),
                    FutureBuilder<double>(
                        future: WeeklyMet,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            double WeeklyMet = snapshot.data ?? 0;

                            double remainingValue = max(0, targetMETmin - WeeklyMet);

                            
                            String message;
                          if (remainingValue > 500) {
                            message = "Keep working out! \nYou need ${remainingValue.toStringAsFixed(0)} MET/min to reach the target!";

                          } else if
                          (remainingValue>0 ){
                            message = 'Keep going! \nYou have almost reached your target for this week, you just need ${remainingValue.toStringAsFixed(0)} MET/min';
                          } else 

                          {
                            message = 'Well done! \nYou have reached your MET target for this week.';
                          }

                          return Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  WeeklyMet == 0 ? '0' : '${WeeklyMet.toStringAsFixed(0)}',
                                  
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 26,
                                    color: WeeklyMet < 600?
                                           Colors.red
                                          : WeeklyMet<3000? 
                                             Colors.orange
                                             : Colors.green ,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: FitnessAppTheme.lightPurple,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}