import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'cores.dart';
import 'selecao/selecao.dart';
import 'selecaoLingua.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final localeCode = prefs.getString('locale') ?? '';
  runApp(MyApp(initialLocaleCode: localeCode));
}

class MyApp extends StatefulWidget {
  final String initialLocaleCode;
  const MyApp({super.key, required this.initialLocaleCode});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    if (widget.initialLocaleCode.isNotEmpty) {
      _locale = _parseLocale(widget.initialLocaleCode);
    }
  }

  Locale _parseLocale(String localeCode) {
    final parts = localeCode.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(parts[0]);
    }
  }

  Future<void> changeLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    final localeString = newLocale.countryCode != null && newLocale.countryCode!.isNotEmpty
        ? '${newLocale.languageCode}_${newLocale.countryCode}'
        : newLocale.languageCode;
    await prefs.setString('locale', localeString);
    setState(() {
      _locale = newLocale;
    });
  }

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
      theme: ThemeData(useMaterial3: true, colorScheme: cs),
      locale: _locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: widget.initialLocaleCode.isEmpty ? const SelecaoLingua() : const AuthGate(),
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
        localizedReason: S.of(context).writeAPasswordNotification,
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
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Fave',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 65,
                    color: AppColors.mel,
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
                      _authenticating ? s.loadingData : s.confirmButtonText,
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