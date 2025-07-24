import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

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
      ),
      body: _selectedLocale == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          ListTile(
            title: Text(loc.lingua),
            trailing: DropdownButton<String>(
              value: _selectedLocale,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}