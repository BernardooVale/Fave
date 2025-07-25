import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cores.dart';
import 'main.dart';

class SelecaoLingua extends StatelessWidget {
  const SelecaoLingua({super.key});

  Future<void> _selectLanguage(BuildContext context, String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', code);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MyApp(initialLocaleCode: code)),
    );
  }

  Widget _buildLanguageTile({
    required BuildContext context,
    required String code,
    required String label,
  }) {
    return Card(
      color: AppColors.mel.withOpacity(0.85),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(label, style: const TextStyle(fontSize: 18)),
        onTap: () => _selectLanguage(context, code),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundo,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 72),
              _buildLanguageTile(
                context: context,
                code: 'pt',
                label: 'Português',
              ),
              _buildLanguageTile(
                context: context,
                code: 'en',
                label: 'English',
              ),
              _buildLanguageTile(
                context: context,
                code: 'es',
                label: 'Español',
              ),
              _buildLanguageTile(
                context: context,
                code: 'fr',
                label: 'Français',
              ),
              _buildLanguageTile(
                context: context,
                code: 'ar',
                label: 'العربية',
              ),
              _buildLanguageTile(
                context: context,
                code: 'el',
                label: 'Ελληνικά',
              ),
              _buildLanguageTile(
                context: context,
                code: 'it',
                label: 'Italiano',
              ),
              _buildLanguageTile(
                context: context,
                code: 'de',
                label: 'Deutsch',
              ),
              _buildLanguageTile(
                context: context,
                code: 'ko',
                label: '한국어',
              ),
              _buildLanguageTile(
                context: context,
                code: 'ja',
                label: '日本語',
              ),
              _buildLanguageTile(
                context: context,
                code: 'zh',
                label: '简体中文',
              ),
              _buildLanguageTile(
                context: context,
                code: 'hi',
                label: 'हिन्दी',
              ),
              _buildLanguageTile(
                context: context,
                code: 'ru',
                label: 'Русский',
              ),
              SizedBox(height: 36)
            ],
          ),
        ),
      ),
    );
  }
}