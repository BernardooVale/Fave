import 'dart:typed_data';
import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _chaveSeguraKey = 'chave_aes_segura'; // Chave para armazenamento seguro da chave AES
final _secureStorage = FlutterSecureStorage(); // Instância para acesso ao armazenamento seguro

/// Obtém a chave AES salva de forma segura, ou cria uma nova caso não exista.
/// A chave tem 32 bytes (256 bits), ideal para AES-256.
Future<Uint8List> _obterOuCriarChave() async {
  String? chaveBase64 = await _secureStorage.read(key: _chaveSeguraKey);

  if (chaveBase64 == null) {
    // Chave não existe, cria nova chave aleatória e salva em base64
    final novaChave = Key.fromSecureRandom(32);
    await _secureStorage.write(
      key: _chaveSeguraKey,
      value: base64Encode(novaChave.bytes),
    );
    print('🔐 Nova chave criada e salva. Tamanho: ${novaChave.bytes.length}');
    return novaChave.bytes;
  } else {
    // Chave já existe, decodifica base64 para bytes
    final chave = base64Decode(chaveBase64);
    print('🔐 Chave carregada. Tamanho: ${chave.length}');
    return chave;
  }
}

/// Criptografa os dados fornecidos usando AES-CBC com chave segura e IV aleatório.
/// Retorna os bytes do IV concatenados com os dados criptografados.
/// O IV tem 16 bytes e deve ser armazenado junto para a descriptografia.
Future<Uint8List> criptografar(Uint8List dados) async {
  final chaveBytes = await _obterOuCriarChave();

  // Valida o tamanho da chave
  if (chaveBytes.length != 32) {
    throw Exception("❌ Chave AES inválida. Tamanho esperado: 32 bytes, recebido: ${chaveBytes.length}");
  }

  final chave = Key(chaveBytes);
  final iv = IV.fromSecureRandom(16); // Vetor de inicialização aleatório de 16 bytes

  // Validação do IV (mais por segurança)
  if (iv.bytes.length != 16) {
    throw Exception("❌ IV inválido. Tamanho esperado: 16 bytes, recebido: ${iv.bytes.length}");
  }

  // Criptografia AES modo CBC
  final encrypter = Encrypter(AES(chave, mode: AESMode.cbc));
  final encrypted = encrypter.encryptBytes(dados, iv: iv);

  // Retorna IV + dados criptografados, para que o IV possa ser usado na descriptografia
  final resultado = Uint8List.fromList(iv.bytes + encrypted.bytes);

  print('✅ Criptografado com sucesso. Tamanho final: ${resultado.length}');
  print('📸 Hash do dado original: ${dados.hashCode}');
  print('🔐 Hash do criptografado: ${resultado.hashCode}');

  return resultado;
}

/// Descriptografa os dados fornecidos que devem conter o IV concatenado ao início.
/// Retorna os bytes descriptografados.
/// Caso haja erro, lança exceção e imprime stacktrace para debug.
Future<Uint8List> descriptografar(Uint8List dadosCriptografados) async {
  try {
    final chaveBytes = await _obterOuCriarChave();

    if (chaveBytes.length != 32) {
      throw Exception("❌ Chave AES inválida. Tamanho esperado: 32 bytes, recebido: ${chaveBytes.length}");
    }

    final chave = Key(chaveBytes);
    final iv = IV(dadosCriptografados.sublist(0, 16)); // Extrai IV dos primeiros 16 bytes
    final conteudo = dadosCriptografados.sublist(16);  // Dados criptografados restantes

    if (iv.bytes.length != 16) {
      throw Exception("❌ IV inválido na descriptografia. Esperado: 16 bytes, recebido: ${iv.bytes.length}");
    }

    // Descriptografia AES modo CBC
    final encrypter = Encrypter(AES(chave, mode: AESMode.cbc));
    final decrypted = encrypter.decryptBytes(Encrypted(conteudo), iv: iv);

    print('✅ Descriptografado com sucesso.');
    print('🔓 Hash do descriptografado: ${decrypted.hashCode}');
    return Uint8List.fromList(decrypted);
  } catch (e, stack) {
    // Loga erro e stacktrace para debug e rethrow para tratar na camada superior
    print('❌ Erro na descriptografia: $e');
    print('🔍 Stacktrace:\n$stack');
    rethrow;
  }
}