import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/home_page.dart';
import 'package:gamify_todo/3%20Page/Profile/profile_page.dart';
import 'package:gamify_todo/3%20Page/Store/store_page.dart';
import 'package:gamify_todo/3%20Page/navbar_page_manager.dart';
import 'package:gamify_todo/2%20General/init_app.dart';
import 'package:gamify_todo/6%20Provider/navbar_provider.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  await initApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NavbarProvider()),
    ],
    child: Main(),
  ));
}

class Main extends StatelessWidget {
  Main({super.key});

  final routeList = [
    GetPage(name: '/navbar', page: () => const NavbarPageManager()),
    GetPage(name: '/home', page: () => const HomePage()),
    GetPage(name: '/store', page: () => const StorePage()),
    GetPage(name: '/profile', page: () => const ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2400),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'NextLevel',
          getPages: routeList,
          initialRoute: '/navbar',
          theme: AppColors().appTheme,
          debugShowCheckedModeBanner: true,
          showPerformanceOverlay: false,
        );
      },
    );
  }
}
