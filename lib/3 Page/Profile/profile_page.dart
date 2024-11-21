import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Profile/Widget/trait_list.dart';
import 'package:gamify_todo/3%20Page/Settings/settings_page.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Duration totalDuration;

  @override
  void initState() {
    super.initState();

    // ? her açıldığında tüm taskalrdan çekmek yerine direkt uygulama açılırken bir defa hesaplayıp bir değişkene atayıp gerisini oradan güncellemek iyi olur mu bilmiyorum. 1500 task olduğunda nasıl oalcak bundan şüpheliyim. galiba bir cache yapısı da kurmak lazım
    totalDuration = TaskProvider().taskList.fold(
      Duration.zero,
      (previousValue, element) {
        if (element.remainingDuration != null) {
          if (element.type == TaskTypeEnum.CHECKBOX && element.status != TaskStatusEnum.COMPLETED) {
            return previousValue;
          }
          return previousValue +
              (element.type == TaskTypeEnum.CHECKBOX
                  ? element.remainingDuration!
                  : element.type == TaskTypeEnum.COUNTER
                      ? element.remainingDuration! * element.currentCount!
                      : element.currentDuration!);
        }
        return previousValue;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: const SizedBox(),
        actions: [
          InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: () {
              NavigatorService.goTo(
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        totalDuration.toLevel(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        totalDuration.textShort2hour(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    // TODO: karma eklenince gelecek
                    'Karma -57',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const TraitList(isSkill: false),
              const SizedBox(height: 20),
              const TraitList(isSkill: true),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
