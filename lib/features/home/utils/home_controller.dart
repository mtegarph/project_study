import 'package:flutter/material.dart';
import 'package:project_study/features/chat/pages/index.dart';
import 'package:project_study/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:project_study/features/history/presentation/pages/history_page.dart';
import 'package:project_study/features/news/presentations/page/news/daily_news.dart';
import 'package:project_study/features/weather/presentation/pages/weather_page.dart';

 class Home  {
  static const List<Widget> pageView = <Widget>[
    WeatherPage(),
    DashBoardPage(),
    DailyNews(),
    HistoryPage(),
    IndexPage()
  ];
}
