import 'package:flutter/material.dart';
//ini kelas untuk open/close principle dan ini adalah master class yang akan dipake untuk class lain
abstract class Item {
  Widget buildArea(BuildContext context);
}
