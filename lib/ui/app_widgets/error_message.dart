/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  final String message;
  final Color? color;

  const MessageView({super.key, required this.message, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: color ?? Colors.grey, fontSize: 18),
      ),
    );
  }
}

class ErrorMessageView extends StatelessWidget {
  final String message;

  const ErrorMessageView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return MessageView(
      message: message,
      color: Colors.redAccent,
    );
  }
}
