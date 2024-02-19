import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_planet/controller/json_decode_provider.dart';
import 'package:provider/provider.dart';

import '../model/json_decode.dart';

class DetailsPage extends StatefulWidget {
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  bool isFav = false;
  late JsonDecodeModel sample;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
      lowerBound: 0,
      upperBound: 2 * pi,
    );
    animationController.repeat();
    var gp = Provider.of<puzz_provider>(context, listen: false);
    gp.getData();
  }

  @override
  void didChangeDependencies() {
    sample = ModalRoute.of(context)!.settings.arguments as JsonDecodeModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor:  Theme.of(context).brightness == Brightness.light
            ? sample.getColorFromString(sample.color!)
            :sample.getColorFromString1(sample.color1!),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            InkWell(
              onTap: () {
                if (animationController.isAnimating) {
                  animationController.stop();
                } else {
                  animationController.repeat();
                }
              },
              child: AnimatedBuilder(
                animation: animationController,
                child: Image.asset(
                  sample.image ?? "",
                  height: 300,
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: animationController.value,
                    child: child,
                  );
                },
              ),
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              height: 436,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.transparent
                  : Colors.black54,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 320, top: 20),
                      child: Consumer<puzz_provider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return IconButton(
                            onPressed: () {
                              if (value.isFavorite(sample)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Already in favorites'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to favorites'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              value.addFavorite(sample);
                              value.saveData();
                            },
                            icon: (value.isFavorite(sample))
                                ? Icon(Icons.favorite,color: Colors.red,)
                                : Icon(Icons.favorite_border_outlined,color: Colors.red,),
                          );
                        },
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              sample.name ?? "",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: double.infinity,
                            margin: EdgeInsets.all(8),
                            color: Theme.of(context).brightness ==
                                    Brightness.light
                                ? sample.getColorFromString(sample.color!)
                                : sample.getColorFromString1(sample.color1!),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(
                                      text: "Type : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: "${sample.type}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal))
                                      ])),
                                  Text.rich(TextSpan(
                                      text: "Radius : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: "${sample.radius}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal))
                                      ])),
                                  Text.rich(TextSpan(
                                      text: "Orbital Period : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: "${sample.orbitalPeriod}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal))
                                      ])),
                                  Text.rich(TextSpan(
                                      text: "Gravity : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: "${sample.gravity}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal))
                                      ])),
                                  Text.rich(TextSpan(
                                      text: "Velocity : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: "${sample.velocity}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal))
                                      ])),
                                  Text.rich(TextSpan(
                                      text: "Distance : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: "${sample.distance}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal))
                                      ]))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(left: 8,right: 8,bottom: 8),
                            color:
                            Theme.of(context).brightness == Brightness.light
                                ? sample.getColorFromString(sample.color!)
                                :sample.getColorFromString1(sample.color1!),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(TextSpan(
                                  text: "Description : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: "${sample.description}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal))
                                  ])),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
