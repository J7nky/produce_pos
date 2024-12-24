import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:produce_pos/data/services/auth_service.dart';
import 'package:produce_pos/modules/auth/controllers/auth_controller.dart';
import 'package:produce_pos/modules/cart/controllers/cart_items_controller.dart';
import 'package:produce_pos/modules/home/controller/favorites_controller.dart';
import 'package:produce_pos/modules/home/controller/search_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/on_generate_route.dart';
import 'core/themes/app_themes.dart';

int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await GetStorage.init(); // Initialize GetStorage

  // Retrieve 'initScreen' and set it to 0 if it's not already set (first launch)
  initScreen = preferences.getInt('initScreen') ?? 0;

  // Set 'initScreen' to 1 to indicate onboarding has been shown for next launch
  await preferences.setInt('initScreen', 1);

  // Lock orientation to portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize Supabase
  await Supabase.initialize(
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
    // Dependency injection for AuthController
    Get.put(AuthController(_authService));
    Get.put(FavoritesController());
    Get.put(CartController());
    Get.put(SearchControllerr());

    return ScreenUtilInit(
      designSize:
          Size(1080, 2220), // This is the layout size your UI designer uses
      builder: (context, widget) => GetMaterialApp(
        title: 'eGrocery',
        theme: AppTheme.defaultTheme,
        getPages: RouteGenerator.pages,
        //  initialRoute: AppRoutes.entryPoint,
        initialRoute:
            initScreen == 0 ? AppRoutes.onboarding : AppRoutes.landingRoute,
      ),
    );
  }
}
