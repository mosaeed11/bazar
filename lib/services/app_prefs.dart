import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  AppPrefs._();

  static const String _seenOnboardingKey = 'seen_onboarding';
  static const String _nameKey = 'profile_name';
  static const String _emailKey = 'profile_email';
  static const String _phoneKey = 'profile_phone';

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenOnboardingKey) ?? false;
  }

  static Future<void> setSeenOnboarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenOnboardingKey, value);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey) ?? '';
  }

  static Future<void> setName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, value);
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey) ?? '';
  }

  static Future<void> setEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, value);
  }

  static Future<String> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneKey) ?? '';
  }

  static Future<void> setPhone(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneKey, value);
  }

  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_phoneKey);
  }
}