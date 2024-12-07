import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
              title: "Hakkımızda",
              subtitle: "Bu proje Görsel Programlama 2 dersi için yapılmıştır",
              onTap: () {
                hakkimizdaDialog(context);
              },
            ),
            _settingsOption(
              title: "Yardım",
              subtitle: "Uygulamanın amacı ve ipuçları",
              onTap: () {
                yardimDialog(context);
              },
            ),
            _settingsOption(
              title: "Çıkış Yap",
              color: AppColors.red,
              onTap: () {
                // TODO: exit app
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

  Future<dynamic> hakkimizdaDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text(
          "Hakkımızda",
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bu mobil uygulama Bilgisayar Programcılığı 2. sınıf öğrencileri Sümeyye Aycan ve Muhammed İslam Bilseloğlu tarafından Görsel Programlama 2 dersi için Flutter kullanılarak geliştirilmiştir.",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              """

Sümeyye Aycan
Smaycan69@gmail.com
+90 546 685 32 23

Muhammed İslam Bilseloğlu
m.islam0422@gmail.com
+90 551 394 47 26
""",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
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
        title: const Text(
          "Yardım",
        ),
        content: const Text(
          // TODO:
          """Bu uygulama ile yapılacaklar listenizi oluşturabilir, düzenleyebilir ve silebilirsiniz.
1 saat çalışma 1 krediye denk gelmektedir.
rutin günleri seçilirse o task rutin olarak kaydedilir. Eğer seçilmezse normal task olarak kaydedilir.

""",
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
                        fontSize: 14,
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
