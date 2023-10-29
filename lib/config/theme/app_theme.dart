import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme(),
      useMaterial3: true);
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
      titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18));
}

Widget appBar(BuildContext context) {
  return SizedBox(
    //height: 500, // Adjust this height as needed
    width: MediaQuery.of(context).size.width,
    child: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 108,
          decoration: const BoxDecoration(color: Colors.white),
        ),
        const Positioned(
          left: 24,
          top: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FoodMarket',
                style: TextStyle(
                  color: Color(0xFF020202),
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Let’s get some foods',
                style: TextStyle(
                  color: Color(0xFF8D92A3),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 24, // Adjust positioning as needed
          top: 30,
          child: Container(
            width: 50,
            height: 50,
            decoration: ShapeDecoration(
              color: const Color(0xFFC4C4C4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Image.network(
              "https://via.placeholder.com/50x50",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}

TextStyle headlineStyleText() {
  return GoogleFonts.aBeeZee(fontSize: 16, color: "4D4D4D".toColor());
}
TextStyle titleStyleText() {
  return GoogleFonts.aBeeZee(fontSize: 14, color: "1F1717".toColor());
}
