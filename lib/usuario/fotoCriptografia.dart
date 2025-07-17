import 'dart:typed_data';
import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _chaveSeguraKey = 'chave_aes_segura';
final _secureStorage = FlutterSecureStorage();

Future<Uint8List> _obterOuCriarChave() async {
  String? chaveBase64 = await _secureStorage.read(key: _chaveSeguraKey);

  if (chaveBase64 == null) {
    final novaChave = Key.fromSecureRandom(32); // 256 bits
    await _secureStorage.write(key: _chaveSeguraKey, value: base64Encode(novaChave.bytes));
    return novaChave.bytes;
  } else {
    return base64Decode(chaveBase64);
  }
}

Future<Uint8List> criptografar(Uint8List dados) async {
  final chave = Key(await _obterOuCriarChave());
  final iv = IV.fromSecureRandom(16);
  final encrypter = Encrypter(AES(chave, mode: AESMode.cbc));

  final encrypted = encrypter.encryptBytes(dados, iv: iv);

  // Retorna IV + dados criptografados juntos
  return Uint8List.fromList(iv.bytes + encrypted.bytes);
}

Future<Uint8List> descriptografar(Uint8List dadosCriptografados) async {
  final chave = Key(await _obterOuCriarChave());

  // Separa IV e conteúdo criptografado
  final iv = IV(dadosCriptografados.sublist(0, 16));
  final conteudo = dadosCriptografados.sublist(16);

  final encrypter = Encrypter(AES(chave, mode: AESMode.cbc));
  final decrypted = encrypter.decryptBytes(Encrypted(conteudo), iv: iv);

  return Uint8List.fromList(decrypted);
}