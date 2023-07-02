import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:progetto/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  static const routename = 'InfoPage';

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int activeIndex = 0;
  final List<String> imageList = [
    'assets/Screenshot_1.png',
    'assets/Screenshot_2.png',
    'assets/Screenshot_3.png',
    'assets/Screenshot_4.png',
  ];

  @override
  Widget build(BuildContext context) {

    final pref = Provider.of<Preferences>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Information'),
          titleTextStyle: FitnessAppTheme.headline2,
          backgroundColor: FitnessAppTheme.background,
          iconTheme: const IconThemeData(color: FitnessAppTheme.nearlyBlack),
        ),
        backgroundColor: FitnessAppTheme.background,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                '''Hello, ${pref.nickname}! Welcome to the HyperMET app!''',
                textAlign: TextAlign.center,
                style: FitnessAppTheme.headline,
              ),
            )),
            const Padding(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'What is the goal of the HyperMET app?',
                    style: FitnessAppTheme.title,
                  
                  ),
                )),

            const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '''The HyperMET app has the goal of decreasing the risks of hypertension in a sedentary lifestyle by encouraging exercising.''',
                    style: FitnessAppTheme.body1,
                  ),
                )),

            const Padding(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'What does the HyperMET app do?',
                    style: FitnessAppTheme.title,
                    
                  ),
                )),
            const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '''The HyperMET app calculates the daily MET index. The data needed are the calories consumed during exercise sessions. See the contents page for more information on the MET index.''',
                    style: FitnessAppTheme.body1,
                  ),
                )),

            const Padding(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'HyperMET app pages and functionalities',
                    style: FitnessAppTheme.title,
                  
                  ),
                )),
           
            Center(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 500,
                      enlargeCenterPage: false,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      pageSnapping: false,
                      reverse: false,
                      autoPlayInterval: Duration(seconds: 2),
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                    ),
                    items: imageList
                        .map((path) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                path,
                                width: 220,
                                height: 400,
                                fit: BoxFit.fitHeight,
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  buildIndicator(),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '''The HyperMET app layout: 
\u2022 first page that reports the daily goal of MET percentage reached and the overall weekly levels, 
\u2022 second page with pressure values manually recorded by the patient and other general physical values, 
\u2022 third page is a page of contents to better inform the user on hypertension issues or MET index details, 
\u2022 last page records biometric and general profile data''',
                    style: FitnessAppTheme.body1,
                    textAlign: TextAlign.left,
                  ),
                )),
          ],
        )));
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imageList.length,
        effect: const JumpingDotEffect(
            dotColor: FitnessAppTheme.lightPurple,
            dotHeight: 15,
            dotWidth: 15,
            activeDotColor: FitnessAppTheme.purple),
      );
}
