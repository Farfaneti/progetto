import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/text_contents/text1.dart';
import 'package:progetto/screens/text_contents/text2.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InfoPage extends StatelessWidget {
  InfoPage({Key? key}) : super(key: key);

  static const routename = 'InfoPage';

  final List imageList = [
    Image.asset('Screenshot1.png'),
    Image.asset('Screenshot2.png'),
    Image.asset('Screenshot3.png'),
    Image.asset('Screenshot4.png'),
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
              child: CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                ),
                items: imageList
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network(
                                e,
                                width: 1050,
                                height: 350,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        )));
  } //build
}
