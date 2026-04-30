import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/provider_config.dart';

class SettingsProvider extends ChangeNotifier {
  ProviderConfig _config = ProviderConfig();
  bool _isLoading = false;

  ProviderConfig get config => _config;
  bool get isLoading => _isLoading;

  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      _config = ProviderConfig(
        provider: prefs.getString('provider') ?? 'openrouter',
        apiKey: prefs.getString('apiKey') ?? '',
        baseUrl: prefs.getString('baseUrl') ?? 'https://openrouter.ai/api/v1',
        maxTokens: prefs.getInt('maxTokens') ?? 1000,
        temperature: prefs.getDouble('temperature') ?? 0.7,
      );
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveSettings(ProviderConfig newConfig) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('provider', newConfig.provider);
    await prefs.setString('apiKey', newConfig.apiKey);
    await prefs.setString('baseUrl', newConfig.baseUrl);
    await prefs.setInt('maxTokens', newConfig.maxTokens);
    await prefs.setDouble('temperature', newConfig.temperature);

    _config = newConfig;
    notifyListeners();
  }
}