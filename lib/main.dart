import 'package:flutter/material.dart';
import 'package:movie_app/demo.screen.dart';
import 'package:movie_app/movie.service.dart';
import 'package:provider/provider.dart';

import 'homepage.screen.dart';
import 'search.controller.dart';
import 'search.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchController()),
        ChangeNotifierProvider(create: (_) => MovieService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: MoviesHomePage(),
        initialRoute: '/',
        routes: {
          '/': (context) => MoviesHomePage(),
          '/search': (context) => MovieSearch(),
          '/test': (context) => DemoScreen(),
        },
      ),
    );
  }
}
