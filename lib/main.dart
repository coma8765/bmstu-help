import 'package:bmstu_help/src/pages/materials/materials.dart';
import 'package:bmstu_help/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

void main() {
  Fimber.plantTree(DebugTree()); // logging setup

  setupServiceLocator(); // setup services

  runApp(const MyApp()); // run application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appBarTitle,
      initialRoute: HomeScreen.route,
      routes: <String, WidgetBuilder>{
        HomeScreen.route: (BuildContext context) => const HomeScreen(),
        MaterialsPage.route: (BuildContext context) => const MaterialsPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text('home page'),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(MaterialsPage.route),
              child: const Padding(
                padding: EdgeInsets.all(32),
                child: Text('home page'),
              ),
            ),
            const Text('home page'),
          ],
        ),
      ),
    );
  }
}
