import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'ed.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  List<Pasta>? pastas;

  @HiveField(2)
  List<Senha>? senhas;

  @HiveField(3)
  List<Documento>? documentos;

  Usuario({required this.nome, this.pastas, this.senhas, this.documentos});
}

@HiveType(typeId: 1)
class Pasta extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  List<Pasta>? subpastas;

  @HiveField(2)
  List<Senha>? senhas;

  @HiveField(3)
  List<Documento>? documentos;

  @HiveField(4)
  DateTime ultimaModificacao;

  @HiveField(5)
  bool favorito;

  Pasta({
    required this.nome,
    this.subpastas,
    this.senhas,
    this.documentos,
    DateTime? ultimaModificacao,
    this.favorito = false,
  }) : ultimaModificacao = ultimaModificacao ?? DateTime.now();
}

@HiveType(typeId: 2)
class Senha extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String senha;

  @HiveField(2)
  DateTime ultimaModificacao;

  @HiveField(3)
  bool favorito;

  Senha({
    required this.nome,
    required this.senha,
    DateTime? ultimaModificacao,
    this.favorito = false,
  }) : ultimaModificacao = ultimaModificacao ?? DateTime.now();
}

@HiveType(typeId: 3)
class Documento extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String numero;

  @HiveField(2)
  DateTime? dataEmissao;          // opcional

  @HiveField(3)
  DateTime? dataVencimento;       // opcional

  @HiveField(4)
  String? orgaoExpedidor;         // opcional

  @HiveField(5)
  DateTime ultimaModificacao;

  @HiveField(6)
  bool favorito;

  @HiveField(7)
  List<Uint8List> fotosCriptografadas; // imagens do documento já criptografadas

  Documento({
    required this.nome,
    required this.numero,
    this.dataEmissao,
    this.dataVencimento,
    this.orgaoExpedidor,
    DateTime? ultimaModificacao,
    this.favorito = false,
    List<Uint8List>? fotosCriptografadas,
  })  : ultimaModificacao = ultimaModificacao ?? DateTime.now(),
        fotosCriptografadas = fotosCriptografadas ?? [];
}
