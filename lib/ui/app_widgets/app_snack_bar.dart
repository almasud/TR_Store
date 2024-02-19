/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

import 'package:flutter/material.dart';

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    int duration = 2000,
    Color color = Colors.blueAccent,
    Icon? icon,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  message,
                ),
              ),
              if (icon != null) icon,
            ],
          ),
          backgroundColor: color,
          duration: Duration(milliseconds: duration),
        ),
      );
  }
}
