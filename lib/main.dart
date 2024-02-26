import 'package:crm_dashboard/config/flavor/flavors.dart';
import 'package:crm_dashboard/feature/splash_screen/ui/splash_screen.dart';
import 'package:crm_dashboard/firebase_options.dart';
import 'package:crm_dashboard/routes/router.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void mainApp(Flavor flavor) {
  AppFlavors.appFlavor = flavor;
  getFirebase();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

Future<void> getFirebase() async {
  if (!kIsWeb) {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  }
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final themeMode = ref.watch(appThemeProvider);
    return MaterialApp(
      title: AppFlavors.title,
      theme: ThemeData(
          fontFamily: FontName.montserrat,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.primaryBg),
      //darkTheme: AppTheme.darkTheme,
      //themeMode: themeMode,
      home: SpashScreen(),
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
