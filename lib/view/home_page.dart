import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/json_decode_provider.dart';
import '../controller/theme_provider.dart';
import 'favorite_page.dart';

class Home_planet extends StatefulWidget {
  const Home_planet({super.key});

  @override
  State<Home_planet> createState() => _Home_planetState();
}

class _Home_planetState extends State<Home_planet>
    with SingleTickerProviderStateMixin {
  late AnimationController animcontroller;

  @override
  void initState() {
    super.initState();
    animcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
      lowerBound: 0,
      upperBound: 2 * pi,
    );
    animcontroller.repeat();
    var gp = Provider.of<puzz_provider>(context, listen: false);
    gp.loadJson();

  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var gp= Provider.of<puzz_provider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage()));
            },
            icon: Icon(
              Icons.favorite,
              size: 30,
              color: Colors.red,
            )),
        backgroundColor:Theme.of(context).brightness == Brightness.light
          ? Color(0xFFCCAB8C)
          :Colors.orangeAccent[100],
        title: Text("Planet",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
        // centerTitle: true,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, tp, child) {
              return IconButton(
                onPressed: () {
                  tp.setTheme();
                },
                icon: tp.currentTheme == false
                    ? Icon(Icons.dark_mode,color: Colors.black)
                    : Icon(Icons.light_mode_outlined,color: Colors.black,),
              );
            }),],
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
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                clipBehavior: Clip.antiAlias,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: width / (height / 1.5),
                    crossAxisCount: 2),
                itemCount: gp.galaxyDetails.length,
                itemBuilder: (context, index) {
                  var sample = gp.galaxyDetails[index];
                  // var planet = gp.planetList[index];
                  return Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, top: 80, bottom: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Theme.of(context).brightness == Brightness.light
                            ? sample.getColorFromString(sample.color!)
                            :sample.getColorFromString1(sample.color1!),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 80),
                              child: Text(
                                " ${sample.name}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.orange[300],
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context, "detail_page", arguments:sample
                                    );
                                  },
                                  icon: Icon(Icons.arrow_forward_sharp,color: Colors.black,)),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (animcontroller.isAnimating) {
                            animcontroller.stop();
                          } else {
                            animcontroller.repeat();
                          }
                        },
                        child: AnimatedBuilder(
                          animation: animcontroller,
                          child: Image.asset(
                            "${sample.image}",
                        height: 150,
                            width: 150,
                          ),
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: animcontroller.value,
                              child: child,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animcontroller.dispose();
    super.dispose();
  }

}
