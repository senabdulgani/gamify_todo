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
              subtitle: "Bu proje Görsel Programlama 2 dersi için yapılmıştır.",
              onTap: () {
                hakkimizdaDialog(context);
              },
            ),
            _settingsOption(
              title: "Çıkış Yap",
              onTap: () {
                hakkimizdaDialog(context);
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
        content: const Text(
          "Bu mobil uygulama Bilgisayar Programcılığı 2. sınıf öğrencileri Sümeyye Aycan ve Muhammed İslam Bilseloğlu tarafından Görsel Programlama 2 dersi için Flutter kullanılarak geliştirilmiştir.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Kapat",
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsOption({
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.panelBackground,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
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
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }
}
