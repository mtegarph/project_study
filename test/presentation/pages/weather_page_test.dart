import 'dart:async';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_study/features/weather/domain/entities/weather_entity.dart';
import 'package:project_study/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:project_study/features/weather/presentation/pages/weather_page.dart';

//this class is for initiliazed to mock the bloc data or function
class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;
  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });
  tearDown(() {
    Timer.run(() {});
  });
  //in order to the widget to work well we need wrap the widget inside the material app
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeatherEntity = WeatherEntity(
    cityName: 'Pamulang',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 306.24,
    pressure: 1004,
    humidity: 69,
  );
  group("testing the widget with bloc state", () {
    testWidgets('Text Field should trigger state change from empty to loading',
        (widgetTester) async {
      //arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherInitial());

      //act
      //to build and render widget use pumpwidget.
      //widget tester is programmaticaly interact with widgets and the test environment
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);

      //assert
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'pamulang');
      //pump instruct the system to paint a new frame so we can meet our exceptaion
      //with a newly updated user interface
      await widgetTester.pump();
      expect(find.text('pamulang'), findsOneWidget);
    });
    testWidgets('should show progress indicator when state is loading',
        (widgetTester) async {
      //arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      //act
      //to build and render widget use pumpwidget.
      //widget tester is programmaticaly interact with widgets and the test environment

      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));

      //assert

      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    });
    testWidgets(
      'should show widget containing weather data when state is weather loaded',
      (widgetTester) async {
        //The runAsync method will ensure that all asynchronous operations are completed before the test finishes,
        //which should prevent the Timer error.
        await widgetTester.runAsync(() async {
          //arrange
          when(() => mockWeatherBloc.state)
              .thenReturn(const WeatherLoaded(result: testWeatherEntity));
          //act
          await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
          await widgetTester
              .pumpWidget(_makeTestableWidget(const WeatherPage()));

          //assert
          // Make sure you're looking for a widget that's in the WeatherLoaded state
          // to properly test the transition.
          expect(find.byKey(const Key('weather_data')), findsOneWidget);
        });
      },
    );
  });
}
