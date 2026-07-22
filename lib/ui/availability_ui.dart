import 'package:flutter/material.dart';
import 'package:social_walking_2/models/classes/sw_time.dart';
import 'package:social_walking_2/models/classes/sw_time_range.dart';

Widget availabilityTable() {
  return ListView(
    children: [
      Row(
        children: [
          Expanded(flex: 1, child: Column()),
          Expanded(flex: 2, child: Column()),
        ],
      ),
    ],
  );
}
