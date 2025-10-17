import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';
  static const String _defaultLanguage = 'en';

  /// Get the saved language code from SharedPreferences
  static Future<String> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? _defaultLanguage;
  }

  /// Save the language code to SharedPreferences
  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  /// Get the current locale based on saved preference
  static Future<Locale> getCurrentLocale() async {
    final languageCode = await getSavedLanguage();
    return Locale(languageCode);
  }

  /// Change language and save preference
  static Future<void> changeLanguage(String languageCode) async {
    await saveLanguage(languageCode);
  }

  /// Check if the current language is Arabic
  static Future<bool> isArabic() async {
    final languageCode = await getSavedLanguage();
    return languageCode == 'ar';
  }

  /// Check if the current language is English
  static Future<bool> isEnglish() async {
    final languageCode = await getSavedLanguage();
    return languageCode == 'en';
  }

  /// Get the display name for the current language
  static Future<String> getCurrentLanguageDisplayName() async {
    final languageCode = await getSavedLanguage();
    return languageCode == 'en' ? 'English' : 'العربية';
  }

  /// Get the opposite language code (for toggling)
  static Future<String> getOppositeLanguage() async {
    final currentLanguage = await getSavedLanguage();
    return currentLanguage == 'en' ? 'ar' : 'en';
  }
}
