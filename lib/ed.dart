import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'ed.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject {
  @HiveField(0)
  String nome;

  // Campos legados mantidos para migração
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

  // Campos legados mantidos para migração
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

  // Novos campos para estrutura flat
  @HiveField(6)
  String id;

  @HiveField(7)
  String? parentPastaId;

  Pasta({
    required this.nome,
    this.subpastas,
    this.senhas,
    this.documentos,
    DateTime? ultimaModificacao,
    this.favorito = false,
    String? id,
    this.parentPastaId,
  })  : ultimaModificacao = ultimaModificacao ?? DateTime.now(),
        id = id ?? const Uuid().v4();
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

  // Novos campos para estrutura flat
  @HiveField(4)
  String id;

  @HiveField(5)
  String? parentPastaId;

  Senha({
    required this.nome,
    required this.senha,
    DateTime? ultimaModificacao,
    this.favorito = false,
    String? id,
    this.parentPastaId,
  })  : ultimaModificacao = ultimaModificacao ?? DateTime.now(),
        id = id ?? const Uuid().v4();
}

@HiveType(typeId: 3)
class Documento extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String numero;

  @HiveField(2)
  DateTime? dataEmissao;

  @HiveField(3)
  DateTime? dataVencimento;

  @HiveField(4)
  String? orgaoExpedidor;

  @HiveField(5)
  DateTime ultimaModificacao;

  @HiveField(6)
  bool favorito;

  // Campo legado - será removido do modelo principal após migração ou movido para box separada
  @HiveField(7)
  List<Uint8List>? fotosCriptografadas;

  // Novos campos para estrutura flat
  @HiveField(8)
  String id;

  @HiveField(9)
  String? parentPastaId;

  Documento({
    required this.nome,
    required this.numero,
    this.dataEmissao,
    this.dataVencimento,
    this.orgaoExpedidor,
    DateTime? ultimaModificacao,
    this.favorito = false,
    this.fotosCriptografadas,
    String? id,
    this.parentPastaId,
  })  : ultimaModificacao = ultimaModificacao ?? DateTime.now(),
        id = id ?? const Uuid().v4();
}
