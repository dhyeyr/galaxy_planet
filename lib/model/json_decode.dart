// To parse this JSON data, do
//
//     final jsonDecodeModel = jsonDecodeModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

List<JsonDecodeModel> jsonDecodeModelFromJson(String str) => List<JsonDecodeModel>.from(json.decode(str).map((x) => JsonDecodeModel.fromJson(x)));

String jsonDecodeModelToJson(List<JsonDecodeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonDecodeModel {


  String? position;
  String? name;
  String? type;
  String? radius;
  String? orbitalPeriod;
  String? gravity;
  String? velocity;
  String? distance;
  String? description;
  String? image;
  String? color;
  String? color1;

  JsonDecodeModel({
    this.position,
    this.name,
    this.type,
    this.radius,
    this.orbitalPeriod,
    this.gravity,
    this.velocity,
    this.distance,
    this.description,
    this.image,
    this.color,
    this.color1,
  });

  factory JsonDecodeModel.fromJson(Map<String, dynamic> json) => JsonDecodeModel(

    position: json["position"],
    name: json["name"],
    type: json["type"],
    radius: json["radius"],
    orbitalPeriod: json["orbital_period"],
    gravity: json["gravity"],
    velocity: json["velocity"],
    distance: json["distance"],
    description: json["description"],
    image: json["image"],
    color: json["color"],
    color1: json["color1"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "name": name,
    "type": type,
    "radius": radius,
    "orbital_period": orbitalPeriod,
    "gravity": gravity,
    "velocity": velocity,
    "distance": distance,
    "description": description,
    "image": image,
    "color": color,
    "color1": color1,
  };
  Color getColorFromString(String colorString) {
    switch (colorString) {
      case 'Colors.black':
        return Colors.black;
      case 'Colors.white':
        return Colors.white;
      case 'Colors.yellow':
        return Colors.yellow;
      case 'Colors.amber':
        return Colors.amber;
        case 'Colors.brown':
        return Colors.brown;
      case 'Colors.lightBlueAccent':
        return Colors.lightBlueAccent;
      case 'Colors.orange':
        return Colors.orange;
      case 'Colors.cyanAccent':
        return Colors.cyanAccent;
      case 'Colors.lightBlue':
        return Colors.lightBlue;
      default:
        return Colors.black; // Default color
    }
  }
  Color getColorFromString1(String colorString) {
    switch (colorString) {
      case 'Colors.black':
        return Colors.black;
      case 'Colors.grey':
        return Colors.grey;
      case 'Colors.yellowAccent':
        return Colors.yellowAccent;
      case 'Colors.orangeAccent':
        return Colors.orangeAccent;
      case 'Colors.lightBlue':
        return Colors.lightBlue;
      case 'Colors.amber':
        return Colors.amber;
      case 'Colors.cyan':
        return Colors.cyan;
      case 'Colors.blue':
        return Colors.blue;
      default:
        return Colors.black; // Default color
    }
  }

}
