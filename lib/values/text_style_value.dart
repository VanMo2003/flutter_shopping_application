import 'package:flutter/material.dart';

class TextStyleValue {
  static const TextStyle h1 = TextStyle(
    color: Color(0xff2C3F50),
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );
  // Color(0xffBEC3C7)
  // 22
  // fontWeight: FontWeight.normal
  static const TextStyle h3 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h4 = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle error =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red);
}
