import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class SelecaoLingua extends StatelessWidget {
  const SelecaoLingua({super.key});

  Future<void> _selectLanguage(BuildContext context, String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', code);

    // Substitui a tela atual pelo app com o idioma selecionado
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MyApp(initialLocaleCode: code)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecione o idioma / Select language',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectLanguage(context, 'pt'),
              child: const Text('Português'),
            ),
            ElevatedButton(
              onPressed: () => _selectLanguage(context, 'en'),
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () => _selectLanguage(context, 'es'),
              child: const Text('Español'),
            ),
          ],
        ),
      ),
    );
  }
}