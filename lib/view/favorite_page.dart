// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_planet/controller/json_decode_provider.dart';
import 'package:provider/provider.dart';

import '../controller/theme_provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

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
  Widget build(BuildContext context) {
    var gp = Provider.of<puzz_provider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back_sharp,color: Colors.black,)),
        backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Color(0xFFCCAB8C)
          :Colors.orangeAccent[100],
        title: Text("Favorites Planet",style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: (gp.favoriteList.isNotEmpty)
          ? Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.gif'),
            fit: BoxFit.cover,
          ),
        ),
            child: Expanded(
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return Consumer<puzz_provider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return ListView.builder(
                        itemCount: gp.favoriteList.length,
                        itemBuilder: (context, index) {
                          var planet = gp.favoriteList[index];
                          return Container(
                            height: MediaQuery.of(context).size.height / 6,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? Color(0xFFCCAB8C)
                                  :Colors.orangeAccent[100], // Change the color based on the theme
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedBuilder(
                                  animation: animationController,
                                  child: Image.asset(
                                    planet.image ?? "",
                                    height: MediaQuery.of(context).size.height / 4,
                                    width: MediaQuery.of(context).size.width / 4,
                                  ),
                                  builder: (context, widget) {
                                    return Transform.rotate(
                                      angle: animationController.value,
                                      child: widget,
                                    );
                                  },
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          planet.name ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black, // Change the text color based on the theme
                                          ),
                                        ),
                                        Text(
                                          'Distance from Sun: ${planet.distance}',style: TextStyle(color: Colors.black),
                                        ),
                                        Text('Radius: ${planet.radius}',style: TextStyle(color: Colors.black),),
                                        Text('velocity: ${planet.velocity}',style: TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                    child: IconButton(
                                        onPressed: () {
                                          value.removeFavorite(index);
                                          value.saveData();
                                        },
                                        icon: Icon(Icons.delete)))
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          )
          : Center(child: Text("You Still not added any Planet to Favorite")),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
