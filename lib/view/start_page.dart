import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_planet/view/home_page.dart';

class start_page extends StatefulWidget {
  const start_page({super.key});

  @override
  State<start_page> createState() => _Home_planetState();
}

class _Home_planetState extends State<start_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/start.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 270, left: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Home_planet();
                    },
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 180,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(15)),
                // color: Colors.white,
                child: Center(child: Text("Get Started",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}






