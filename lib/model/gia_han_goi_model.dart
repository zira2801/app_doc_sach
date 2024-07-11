import 'package:flutter/material.dart';

class SubscriptionModel {
  String duration;
  String price;
  Color color;
  List<String> features;

  SubscriptionModel({
    required this.duration,
    required this.price,
    required this.color,
    required this.features,
  });
}
