// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.response,
    required this.message,
    required this.data,
  });

  String response;
  String message;
  List<DatumCategory> data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        response: json["response"],
        message: json["message"],
        data: List<DatumCategory>.from(
            json["Data"].map((x) => DatumCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumCategory {
  DatumCategory({
    required this.id,
    required this.foodName,
    required this.portion,
    required this.uom,
    required this.foodType,
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
  String foodType;
  String calories;
  String carbohydrate;
  String fat;
  String protein;
  String sugar;
  String fiber;

  factory DatumCategory.fromJson(Map<String, dynamic> json) => DatumCategory(
        id: json["id"],
        foodName: json["FoodName"],
        portion: json["Portion"],
        uom: json["Uom"],
        foodType: json["FoodType"],
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
        "FoodType": foodType,
        "Calories": calories,
        "Carbohydrate": carbohydrate,
        "Fat": fat,
        "Protein": protein,
        "Sugar": sugar,
        "Fiber": fiber,
      };
}
