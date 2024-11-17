import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/home_page.dart';
import 'package:gamify_todo/3%20Page/Profile/profile_page.dart';
import 'package:gamify_todo/3%20Page/Store/store_page.dart';
import 'package:gamify_todo/6%20Provider/navbar_provider.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class NavbarPageManager extends StatefulWidget {
  const NavbarPageManager({super.key});

  @override
  State<NavbarPageManager> createState() => _NavbarPageManagerState();
}

class _NavbarPageManagerState extends State<NavbarPageManager> with WidgetsBindingObserver {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const StorePage(),
      const HomePage(),
      const ProfilePage(),
    ];

    return IgnorePointer(
      ignoring: !isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: !isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : screens[context.watch<NavbarProvider>().currentIndex],
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: AppColors.borderRadiusAll,
          ),
          onPressed: () {
            Get.toNamed('/addTask');
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.read<NavbarProvider>().currentIndex,
          onTap: (index) {
            setState(() {
              context.read<NavbarProvider>().currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.store,
              ),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    // todo: veriler veritabanından çekilecek

    isLoading = true;
    setState(() {});
  }
}
