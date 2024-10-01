import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:produce_pos/data/services/auth_service.dart';
import 'package:produce_pos/modules/auth/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/on_generate_route.dart';
import 'core/themes/app_themes.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Initialize Supabase
  Supabase.initialize(
    url: 'https://edmzbkilnucnfkmjcnut.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVkbXpia2lsbnVjbmZrbWpjbnV0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjYxMTU1NDEsImV4cCI6MjA0MTY5MTU0MX0.gH06cttmgom9t5Vd3yjOxn328q28amt5ZtUozw7Hevo',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(_authService)); // Dependency injection
    return ScreenUtilInit(
      designSize:
          Size(1080, 2220), // This is the layout size your UI designer uses
      builder: (context, widget) => GetMaterialApp(
        title: 'eGrocery',
        theme: AppTheme.defaultTheme,
        getPages: RouteGenerator.pages,
        initialRoute:
            initScreen == 0 ? AppRoutes.onboarding : AppRoutes.introLogin,
      ),
    );
  }
}
