// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  FavoriteModel({
    required this.response,
    required this.message,
    required this.data,
  });

  String response;
  String message;
  List<DatumFavorite> data;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        response: json["response"],
        message: json["message"],
        data: List<DatumFavorite>.from(json["Data"].map((x) => DatumFavorite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumFavorite {
  DatumFavorite({
    required this.id,
    required this.foodName,
    required this.portion,
    required this.uom,
    required this.calories,
    required this.carbohydrate,
    required this.fat,
    required this.protein,
    required this.sugar,
    required this.fiber,
  });

  String id;
  String foodName;
  String portion;
  String uom;
  String calories;
  String carbohydrate;
  String fat;
  String protein;
  String sugar;
  String fiber;

  factory DatumFavorite.fromJson(Map<String, dynamic> json) => DatumFavorite(
        id: json["id"],
        foodName: json["FoodName"],
        portion: json["Portion"],
        uom: json["Uom"],
        calories: json["Calories"],
        carbohydrate: json["Carbohydrate"],
        fat: json["Fat"],
        protein: json["Protein"],
        sugar: json["Sugar"],
        fiber: json["Fiber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "FoodName": foodName,
        "Portion": portion,
        "Uom": uom,
        "Calories": calories,
        "Carbohydrate": carbohydrate,
        "Fat": fat,
        "Protein": protein,
        "Sugar": sugar,
        "Fiber": fiber,
      };
}
