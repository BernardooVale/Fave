import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import 'ed.dart';

final _secure = const FlutterSecureStorage();

// Gera ou recupera a chave AES-256 para esse usuário
Future<Uint8List> getKeyForUser(String userId) async {
  const androidOpts = AndroidOptions(encryptedSharedPreferences: true);
  final keyName = 'hive_key_$userId';
  final stored = await _secure.read(key: keyName, aOptions: androidOpts);

  if (stored != null) {
    return base64Url.decode(stored);
  }

  final key = Hive.generateSecureKey(); // AES-256
  await _secure.write(
    key: keyName,
    value: base64UrlEncode(key),
    aOptions: androidOpts,
  );
  return Uint8List.fromList(key);
}

// Abre caixa criptografada do usuário
Future<Box<Usuario>> openEncryptedUserBox(String userId) async {
  final key = await getKeyForUser(userId);
  return Hive.openBox<Usuario>(
    'user_$userId',
    encryptionCipher: HiveAesCipher(key),
  );
}