import 'package:flutter/widgets.dart';
import 'package:resto_app/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService) {
    _loadNotifStatus();
  }

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  // simpan status toggle notifikasi
  static const _notifKey = "dailyNotification";
  bool _isDailyNotifOn = false;
  bool get isDailyNotifOn => _isDailyNotifOn;

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  // schedule notif harian
  void scheduleDailyTenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyTenAMNotification(
      id: _notificationId,
    );
  }

  // toggle notif ON/OFF
  Future<void> toggleDailyNotification() async {
    _isDailyNotifOn = !_isDailyNotifOn;
    await _saveNotifStatus(_isDailyNotifOn);

    if (_isDailyNotifOn) {
      scheduleDailyTenAMNotification();
    } else {
      await cancelNotification(_notificationId);
    }
    notifyListeners();
  }

  // cancel notifikasi
  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
  }

  // load status toggle dari SharedPreferences
  Future<void> _loadNotifStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isDailyNotifOn = prefs.getBool(_notifKey) ?? false;
    notifyListeners();
  }

  // simpan status toggle ke SharedPreferences
  Future<void> _saveNotifStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notifKey, value);
  }
}
