import 'dart:typed_data';
import 'dart:convert';
import 'dart:developer';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _chaveSeguraKey = 'chave_aes_segura';
final _secureStorage = FlutterSecureStorage();

Future<Uint8List> _obterOuCriarChave() async {
  String? chaveBase64 = await _secureStorage.read(key: _chaveSeguraKey);

  if (chaveBase64 == null) {
    final novaChave = Key.fromSecureRandom(32); // 256 bits
    await _secureStorage.write(
      key: _chaveSeguraKey,
      value: base64Encode(novaChave.bytes),
    );
    print('🔐 Nova chave criada e salva. Tamanho: ${novaChave.bytes.length}');
    return novaChave.bytes;
  } else {
    final chave = base64Decode(chaveBase64);
    print('🔐 Chave carregada. Tamanho: ${chave.length}');
    return chave;
  }
}

Future<Uint8List> criptografar(Uint8List dados) async {
  final chaveBytes = await _obterOuCriarChave();
  if (chaveBytes.length != 32) {
    throw Exception("❌ Chave AES inválida. Tamanho esperado: 32 bytes, recebido: ${chaveBytes.length}");
  }

  final chave = Key(chaveBytes);
  final iv = IV.fromSecureRandom(16);

  if (iv.bytes.length != 16) {
    throw Exception("❌ IV inválido. Tamanho esperado: 16 bytes, recebido: ${iv.bytes.length}");
  }

  final encrypter = Encrypter(AES(chave, mode: AESMode.cbc));
  final encrypted = encrypter.encryptBytes(dados, iv: iv);

  final resultado = Uint8List.fromList(iv.bytes + encrypted.bytes);

  print('✅ Criptografado com sucesso. Tamanho final: ${resultado.length}');
  print('📸 Hash do dado original: ${dados.hashCode}');
  print('🔐 Hash do criptografado: ${resultado.hashCode}');

  return resultado;
}

Future<Uint8List> descriptografar(Uint8List dadosCriptografados) async {
  try {
    final chaveBytes = await _obterOuCriarChave();

    if (chaveBytes.length != 32) {
      throw Exception("❌ Chave AES inválida. Tamanho esperado: 32 bytes, recebido: ${chaveBytes.length}");
    }

    final chave = Key(chaveBytes);
    final iv = IV(dadosCriptografados.sublist(0, 16));
    final conteudo = dadosCriptografados.sublist(16);

    if (iv.bytes.length != 16) {
      throw Exception("❌ IV inválido na descriptografia. Esperado: 16 bytes, recebido: ${iv.bytes.length}");
    }

    final encrypter = Encrypter(AES(chave, mode: AESMode.cbc));
    final decrypted = encrypter.decryptBytes(Encrypted(conteudo), iv: iv);

    print('✅ Descriptografado com sucesso.');
    print('🔓 Hash do descriptografado: ${decrypted.hashCode}');
    return Uint8List.fromList(decrypted);
  } catch (e, stack) {
    print('❌ Erro na descriptografia: $e');
    print('🔍 Stacktrace:\n$stack');
    rethrow;
  }
}