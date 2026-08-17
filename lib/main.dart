import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'cores.dart';
import 'selecao/selecao.dart';
import 'selecaoLingua.dart';
import 'widgets/arched_container.dart';
import 'widgets/motifs.dart';

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
      primary: AppColors.mel,
      onPrimary: Colors.black,
      secondary: AppColors.brass,
      onSecondary: AppColors.wood,
      tertiary: AppColors.azulejo,
      onTertiary: Colors.white,
      surface: AppColors.fundo,
      onSurface: AppColors.ivory,
      error: const Color(0xFFCF6679),
      onError: Colors.black,
    );

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: cs,
        scaffoldBackgroundColor: AppColors.fundo,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: AppColors.brass,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontFamily: 'serif',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.brass,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mel,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.wood.withOpacity(0.5),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.brass.withOpacity(0.2)),
          ),
        ),
      ),
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          // Pattern de fundo sutil
          Positioned.fill(
            child: CustomPaint(painter: AzulejoPatternPainter(opacity: 0.03)),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: 'app_logo',
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ArchedContainer(
                            width: 160,
                            height: 200,
                            archRadius: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.mel.withOpacity(0.2),
                                  Colors.transparent,
                                ],
                              ),
                              border: Border.all(color: AppColors.mel.withOpacity(0.3)),
                            ),
                            child: const Center(
                              child: Icon(Icons.lock_outline_rounded, size: 80, color: AppColors.mel),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Fave',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize: 65,
                              color: AppColors.mel,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mel.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _authenticating ? null : _authenticate,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: AppColors.mel,
                        foregroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_authenticating)
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            )
                          else
                            const Icon(Icons.fingerprint_rounded, size: 32),
                          const SizedBox(width: 16),
                          Text(
                            _authenticating ? s.loadingData : s.confirmButtonText,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}