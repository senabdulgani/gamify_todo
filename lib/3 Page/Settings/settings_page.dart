import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Widgets/language_pop.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/hive_service.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/6%20Provider/store_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/6%20Provider/trait_provider.dart';
import 'package:gamify_todo/8%20Model/user_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Settings.tr()),
        leading: InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _settingsOption(
              title: LocaleKeys.SelectLanguage.tr(),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const LanguageSelectionPopup(),
                );
              },
            ),
            _settingsOption(
              title: LocaleKeys.Help.tr(),
              subtitle: LocaleKeys.HelpText.tr(),
              onTap: () {
                yardimDialog(context);
              },
            ),
            _settingsOption(
              title: "Delete all Data",
              color: AppColors.red,
              onTap: () async {
                Helper().getDialog(
                    withTimer: true,
                    message: "Are you sure you want to delete all data?",
                    onAccept: () async {
                      await HiveService().deleteAllData();

                      TaskProvider().taskList = [];
                      TaskProvider().routineList = [];
                      TraitProvider().traitList = [];
                      StoreProvider().storeItemList = [];
                      loginUser = UserModel(
                        id: 0,
                        email: "",
                        password: "",
                        creditProgress: Duration.zero,
                        userCredit: 0,
                      );
                    },
                    acceptButtonText: "ok",
                    title: "Hurra?");
              },
            ),
            _settingsOption(
              title: LocaleKeys.Exit.tr(),
              color: AppColors.red,
              onTap: () {
                NavigatorService().logout();
              },
            ),
            // TODO: tema ayaralnınca açılacak
            // _settingsOption(
            //   title: "Tema Seçimi",
            //   subtitle: "Koyu/Açık temayı değiştirin.",
            //   trailing: Switch(
            //     value: true,
            //     // value: ThemeProvider().themeMode == ThemeMode.dark,
            //     // onChanged: onThemeChanged,
            //     onChanged: (value) {
            //       // onThemeChanged();
            //       // ThemeProvider().changeTheme();
            //       AppColors.updateTheme(isDarkTheme: false);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> yardimDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          LocaleKeys.Help.tr(),
        ),
        content: Text(
          // TODO:
          LocaleKeys.HelpDialog.tr(),
        ),
      ),
    );
  }

  Widget _settingsOption({
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color ?? AppColors.panelBackground,
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: subtitle != null ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
