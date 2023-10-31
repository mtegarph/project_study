import 'package:flutter/material.dart';
import 'package:project_study/features/home/utils/home_controller.dart';
import 'package:supercharged/supercharged.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: "F7EADF".toColor(),
      body: Home.pageView.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: '352F44'.toColor(),
          unselectedItemColor: const Color.fromRGBO(244, 67, 54, 1),
          selectedItemColor: '352F44'.toColor(),
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
          ]),
    );
  }
}
