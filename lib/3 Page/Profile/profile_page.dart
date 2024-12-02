import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Profile/Widget/top_item.dart';
import 'package:gamify_todo/3%20Page/Profile/Widget/weekly_progress_chart.dart';
import 'package:gamify_todo/3%20Page/Profile/Widget/profile_page_top_section.dart';
import 'package:gamify_todo/3%20Page/Profile/Widget/trait_list.dart';
import 'package:gamify_todo/3%20Page/Settings/settings_page.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: const SizedBox(),
        actions: [
          InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: () async {
              await NavigatorService().goTo(
                const SettingsPage(),
                transition: Transition.rightToLeft,
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfilePageTopSection(),
              SizedBox(height: 40),
              TraitList(isSkill: false),
              SizedBox(height: 20),
              TraitList(isSkill: true),
              SizedBox(height: 40),
              WeeklyProgressChart(),
              SizedBox(height: 40),
              TopItem(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
