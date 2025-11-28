import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/theme/theme_provider.dart';
import 'package:resto_app/provider/notification/local_notification_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Theme"),
            subtitle: const Text("Ganti tampilan aplikasi"),
            value: themeProvider.isDarkTheme,
            onChanged: (value) {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
          Consumer<LocalNotificationProvider>(
            builder: (context, notifProvider, child) {
              return SwitchListTile(
                title: const Text("Reminder makan siang"),
                value: notifProvider.isDailyNotifOn,
                onChanged: (val) {
                  notifProvider.toggleDailyNotification();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
