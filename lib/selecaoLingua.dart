import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cores.dart';
import 'main.dart';
import 'widgets/motifs.dart';
import 'widgets/arched_container.dart';

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
    return ArchedContainer(
      archRadius: 20,
      decoration: BoxDecoration(
        color: AppColors.wood.withOpacity(0.5),
        border: Border.all(color: AppColors.brass.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: ListTile(
        title: Text(label, style: const TextStyle(fontSize: 18, color: AppColors.ivory, fontFamily: 'serif')),
        onTap: () => _selectLanguage(context, code),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.mel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundo,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: AzulejoPatternPainter(opacity: 0.02))),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Icon(Icons.translate_rounded, size: 64, color: AppColors.mel),
                  const SizedBox(height: 16),
                  const Text('Select Language', style: TextStyle(fontFamily: 'serif', fontSize: 24, color: AppColors.mel, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildLanguageTile(context: context, code: 'pt', label: 'Português'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'en', label: 'English'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'es', label: 'Español'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'fr', label: 'Français'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'ar', label: 'العربية'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'el', label: 'Ελληνικά'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'it', label: 'Italiano'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'de', label: 'Deutsch'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'ko', label: '한국어'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'ja', label: '日本語'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'zh', label: '简体中文'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'hi', label: 'हिन्दी'),
                        const SizedBox(height: 12),
                        _buildLanguageTile(context: context, code: 'ru', label: 'Русский'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}