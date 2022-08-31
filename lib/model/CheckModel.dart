// To parse this JSON data, do
//
//     final checkModel = checkModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CheckModel checkModelFromJson(String str) =>
    CheckModel.fromJson(json.decode(str));

String checkModelToJson(CheckModel data) => json.encode(data.toJson());

class CheckModel {
  CheckModel({
    required this.response,
    required this.message,
    required this.data,
  });

  String response;
  String message;
  List<dynamic> data;

  factory CheckModel.fromJson(Map<String, dynamic> json) => CheckModel(
        response: json["response"],
        message: json["message"],
        data: List<dynamic>.from(json["Data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "Data": List<dynamic>.from(data.map((x) => x)),
      };
}
