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

  Usuario({required this.nome, this.pastas, this.senhas});
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
  DateTime ultimaModificacao;

  @HiveField(4)
  bool favorito;

  Pasta({
    required this.nome,
    this.subpastas,
    this.senhas,
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

  // NOVOS CAMPOS
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