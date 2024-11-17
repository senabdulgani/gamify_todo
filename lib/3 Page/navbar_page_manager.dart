import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/home_page.dart';
import 'package:gamify_todo/3%20Page/Profile/profile_page.dart';
import 'package:gamify_todo/3%20Page/Store/store_page.dart';
import 'package:gamify_todo/6%20Provider/navbar_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
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

    checkRoutineTasks();
  }

  // TODO: sadece yeni güne geçildiğinde otomatik çalıaşcak. arkaplanda çalışacak
  // TODO: ayrıca yeni rutin oluşturulduğunda da eğer o günde de oalcak ise task oluşturulacak.
  void checkRoutineTasks() {
    if (routineList.isNotEmpty) {
      for (var rutin in routineList) {
        // !!!!!!!!!!!!!!!!!! burada gün gün aynı veya daha önce ise olacak
        debugPrint("""
        repeatDays: ${rutin.repeatDays}
        startDate: ${rutin.startDate}
        now: ${DateTime.now()}
        DateTime.now().weekday: ${DateTime.now().weekday}
        Helper().isBeforeDay(rutin.startDate, DateTime.now()): ${Helper().isBeforeDay(rutin.startDate, DateTime.now())}
""");

        if (rutin.repeatDays.contains(DateTime.now().weekday) && (Helper().isSameDay(rutin.startDate, DateTime.now()) || Helper().isBeforeDay(rutin.startDate, DateTime.now()))) {
          TaskProvider().addTask(
            TaskModel(
              // TODO: id si benzersiz olsun
              id: DateTime.now().millisecondsSinceEpoch,
              rutinID: rutin.id,
              title: rutin.title,
              type: rutin.type,
              taskDate: DateTime.now().subtract(const Duration(hours: 1)),
              time: rutin.time,
              isNotificationOn: rutin.isNotificationOn,
              currentDuration: rutin.type == TaskTypeEnum.TIMER ? Duration.zero : null,
              remainingDuration: rutin.remainingDuration,
              currentCount: rutin.type == TaskTypeEnum.COUNTER ? 0 : null,
              targetCount: rutin.targetCount,
              isTimerActive: rutin.type == TaskTypeEnum.TIMER ? false : null,
              attirbuteIDList: rutin.attirbuteIDList,
              skillIDList: rutin.skillIDList,
            ),
          );
        }
      }
    }
  }
}
