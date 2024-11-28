import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/add_task_page.dart';
import 'package:gamify_todo/3%20Page/Home/home_page.dart';
import 'package:gamify_todo/3%20Page/Profile/profile_page.dart';
import 'package:gamify_todo/3%20Page/Store/store_page.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/6%20Provider/navbar_provider.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';

class NavbarPageManager extends StatefulWidget {
  const NavbarPageManager({super.key});

  @override
  State<NavbarPageManager> createState() => _NavbarPageManagerState();
}

class _NavbarPageManagerState extends State<NavbarPageManager> with WidgetsBindingObserver {
  bool isLoading = false;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    getData();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: !isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.expand(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => context.read<NavbarProvider>().currentIndex = index);
                  },
                  children: const <Widget>[
                    StorePage(),
                    HomePage(),
                    ProfilePage(),
                  ],
                ),
              ),
        floatingActionButton: context.read<NavbarProvider>().currentIndex == 1 || context.read<NavbarProvider>().currentIndex == 0
            ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: AppColors.borderRadiusAll,
                ),
                onPressed: () {
                  NavigatorService.goTo(
                    AddTaskPage(
                      isStore: context.read<NavbarProvider>().currentIndex == 0,
                    ),
                    transition: Transition.downToUp,
                  );
                },
                child: const Icon(Icons.add),
              )
            : const SizedBox(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: context.read<NavbarProvider>().currentIndex,
            onTap: (index) {
              _onItemTapped(index);
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
      ),
    );
  }

  Future getData() async {
    // TODO: veriler veritabanından çekilecek

    isLoading = true;
    setState(() {});
  }

  void _onItemTapped(int index) {
    context.read<NavbarProvider>().currentIndex = index;

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
