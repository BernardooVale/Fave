import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import 'main.dart';
import 'cores.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  String? _selectedLocale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString('locale') ?? 'pt';
    setState(() => _selectedLocale = locale);
  }

  Future<void> _setLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
    setState(() => _selectedLocale = locale);
    MyApp.setLocale(context, Locale(locale));
  }

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.config),
        centerTitle: true,
        backgroundColor: AppColors.mel,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
      ),
      body: _selectedLocale == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language, color: Colors.blueAccent),
                        const SizedBox(width: 12),
                        Text(
                          loc.lingua,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: _selectedLocale,
                      underline: const SizedBox(),
                      onChanged: (String? newLocale) {
                        if (newLocale != null) _setLocale(newLocale);
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'pt',
                          child: Text('Português'),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'es',
                          child: Text('Español'),
                        ),
                        DropdownMenuItem(
                          value: 'fr',
                          child: Text('Français'),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text('العربية'),
                        ),
                        DropdownMenuItem(
                          value: 'el',
                          child: Text('Ελληνικά'),
                        ),
                        DropdownMenuItem(
                          value: 'it',
                          child: Text('Italiano'),
                        ),
                        DropdownMenuItem(
                          value: 'de',
                          child: Text('Deutsch'),
                        ),
                        DropdownMenuItem(
                          value: 'ko',
                          child: Text('한국어'),
                        ),
                        DropdownMenuItem(
                          value: 'ja',
                          child: Text('日本語'),
                        ),
                        DropdownMenuItem(
                          value: 'zh',
                          child: Text('简体中文'),
                        ),
                        DropdownMenuItem(
                          value: 'hi',
                          child: Text('हिन्दी'),
                        ),
                        DropdownMenuItem(
                          value: 'ru',
                          child: Text('Русский'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}