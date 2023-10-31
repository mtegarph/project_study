import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_study/config/routes/routes.dart';
import 'package:project_study/config/theme/app_theme.dart';
import 'package:project_study/features/dashboard/presentation/bloc/product/remote/remote_product_bloc.dart';
import 'package:project_study/features/history/presentation/bloc/history_bloc.dart';
import 'package:project_study/features/login/views/login_screen.dart';
import 'package:project_study/features/news/presentations/bloc/article/remote/remote_article_bloc.dart';
import 'package:project_study/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:project_study/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticleBlocBloc>(
          create: (context) => sl()..add(const GetArticles()),
        ),
        BlocProvider<RemoteProductBloc>(
          create: (context) => sl()..add(const GetProducts()),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => sl()..add(const GetHistory()),
        ),
        BlocProvider<WeatherBloc>(
          create: (context) =>
              sl()..add(const OnCityChanged(cityName: 'pamulang')),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const LoginScreen(),
      ),
    );
  }
}
