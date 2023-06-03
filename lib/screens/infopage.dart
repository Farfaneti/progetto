import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/text_contents/text1.dart';
import 'package:progetto/screens/text_contents/text2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key? key}) : super(key: key);

  static const routename = 'InfoPage';

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int activeIndex = 0;
  final List<String> imageList = [
    'assets/Screenshot1.png',
    'assets/Screenshot2.png',
    'assets/Screenshot3.png',
    'assets/Screenshot4.png',
  ];

  @override
  Widget build(BuildContext context) {
    print('${InfoPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Info Page'),
          titleTextStyle: FitnessAppTheme.headline2,
          backgroundColor: FitnessAppTheme.background,
          iconTheme: const IconThemeData(color: FitnessAppTheme.nearlyBlack),
        ),
        backgroundColor: FitnessAppTheme.background,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //mettere logo app
            const Center(
                child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Welcome to the HyperMET app!',
                textAlign: TextAlign.center,
                style: FitnessAppTheme.headline,
              ),
            )),
            const Padding(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'What does the HyperMET app do?',
                    style: FitnessAppTheme.title,
                    // textAlign: TextAlign.left,
                  ),
                )),

            const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Mettere il testo di descrizione dellapp e obiettivo',
                    style: FitnessAppTheme.body1,
                  ),
                )),

            //inserire immagini tipo screenshot dell'app in uno slideshow widget
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
            )
          ],
        )));
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imageList.length,
        effect: JumpingDotEffect(
            dotColor: FitnessAppTheme.lightPurple,
            dotHeight: 15,
            dotWidth: 15,
            activeDotColor: FitnessAppTheme.purple),
      );
}
