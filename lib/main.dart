import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_services.dart';
import 'package:resto_app/provider/detail/resto_detail_provider.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/provider/main/index_nav_provider.dart';
import 'package:resto_app/screen/detail/detail_screen.dart';
import 'package:resto_app/screen/main/main_screen.dart';
import 'package:resto_app/static/navigation_route.dart';
import 'package:resto_app/style/theme/resto_theme.dart';
import 'package:resto_app/data/local/local_database_service.dart';
import 'package:resto_app/provider/bookmark/local_database_provider.dart';
import 'package:resto_app/provider/theme/theme_provider.dart';
import 'package:resto_app/screen/settings/settings_screen.dart';
import 'package:resto_app/services/http_service.dart';
import 'package:resto_app/services/local_notification_service.dart';
import 'package:resto_app/provider/notification/local_notification_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => BookmarkListProvider(),
        // ),
        Provider(
          create: (context) => HttpService(),
        ),
        Provider(
          create: (context) => LocalNotificationService(
            context.read<HttpService>(),
          )
            ..init()
            // todo-01-notif-07: configure the timezone
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestoListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestoDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Resto App',
          theme: RestoTheme.lightTheme,
          darkTheme: RestoTheme.darkTheme,
          themeMode:
              themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
                  restoId: ModalRoute.of(context)?.settings.arguments as String,
                ),
            NavigationRoute.settingsRoute.name: (context) =>
                const SettingsScreen(),
          },
        );
      },
    );
  }
}
