import 'package:blog_explorer/screens/downloadspage.dart';
import 'package:blog_explorer/screens/favoritespage.dart';
import 'package:blog_explorer/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_explorer/cubit/blog_cubit.dart';

void main() {
  ErrorWidget.builder =   (FlutterErrorDetails details) {
    return Container(
      color: Colors.black,
      child: Text('error: ${details.exception}', style: const TextStyle(color: Colors.white),),
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogCubit(),
      child: MaterialApp(
        title: 'Blog Explorer',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        routes: {
            '/': (context) => const HomePage(),
            'homePage': (context) => const HomePage(),
            'favoritesPage': (context) => const FavoritesPage(),
            'downloadsPage': (context) => const DownloadsPage(),
          }
      ),
    );
  }
}
