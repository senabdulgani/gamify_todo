import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Profile/Widget/trait_list.dart';

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
            onTap: () {},
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
              Row(
                children: [
                  Text(
                    // TODO: all traits and tasks duraitons to lvl
                    '12 LVL',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    // TODO: karma eklenince gelecek
                    'Karma -57',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              TraitList(isSkill: false),
              SizedBox(height: 20),
              TraitList(isSkill: true),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
