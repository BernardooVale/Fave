import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'cores.dart';
import 'selecao/selecao.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaria,
      onPrimary: Colors.white,
      secondary: AppColors.secundaria,
      onSecondary: Colors.black,
      tertiary: AppColors.terciaria,
      onTertiary: Colors.white,
      surface: AppColors.fundo,
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.white,
    );
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: cs, scaffoldBackgroundColor: AppColors.fundo),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});
  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final auth = LocalAuthentication();
  bool _authenticating = false;

  Future<void> _authenticate() async {
    setState(() => _authenticating = true);
    final can = await auth.canCheckBiometrics;
    final supported = can || await auth.isDeviceSupported();
    if (!supported) {
      setState(() => _authenticating = false);
      return;
    }

    bool ok = false;
    try {
      ok = await auth.authenticate(
        localizedReason: 'Para acessar o app, autentique-se',
        options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true),
      );
    } catch (e) {
      debugPrint('Erro na autenticação: $e');
    }

    if (!mounted) return;
    setState(() => _authenticating = false);

    if (ok) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Selecao()),
      );
    }
    // Se falhar, permanece na tela com botão ativo novamente
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Autenticador',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _authenticating ? null : _authenticate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _authenticating
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: _authenticating
                          ? const CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : const Icon(Icons.fingerprint, size: 32),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      _authenticating ? 'Autenticando...' : 'Autenticar',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}