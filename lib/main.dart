import 'package:flutter/material.dart';
import 'package:resultnomad/router.dart';

void main() {
  runApp(const NomadFlutter());
}

class NomadFlutter extends StatelessWidget {
  const NomadFlutter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Nomad Flutter',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}
