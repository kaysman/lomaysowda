import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> sendData({
  @required int productId,
  @required String name,
  @required String phone,
  @required String message,
}) async {
  assert(name != null);
  assert(phone != null);
  assert(message != null);

  Map<String, dynamic> data = {
    'name': name,
    'phone': phone,
    'message': message,
  };

  final http.Response response = await http.post(
    "http://95.85.122.49/api/product/$productId/order",
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    },
    body: data,
  );
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data['message'];
  } else {
    return null;
  }
}
