import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/grimoire.dart';
import 'providers/scribe.dart';
import 'screens/getting_started_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'variables/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx1) => Scribe()),
        ChangeNotifierProvider(create: (ctx1) => Grimoire()),
      ],
      child: Consumer<Scribe>(
        builder: (ctx, auth, child) => MaterialApp(
          builder: (BuildContext ctx2, Widget? child) {
            final MediaQueryData data = MediaQuery.of(ctx2);
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor: data.textScaleFactor * TEXT_SCALE_FACTOR),
              child: child!,
            );
          },
          title: 'Grimoire',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          ),
          home: FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authSnapshot) {
              if (authSnapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (auth.isAuth) {
                return const HomeScreen();
              }
              return const GettingStartedScreen();
            },
          ),
        ),
      ),
    );
  }
}
