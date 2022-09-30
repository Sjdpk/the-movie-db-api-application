import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.screen.dart';
import 'search.controller.dart';

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
      ],
      child: MaterialApp(
        home: MoviesHomePage(),
      ),
    );
  }
}
