/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension ShimmerExtension on Widget {
  Widget shimmer(bool isEnable) {
    return isEnable
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade700,
            highlightColor: Colors.grey.shade400,
            child: this)
        : this;
  }
}
