// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioAdapter extends TypeAdapter<Usuario> {
  @override
  final int typeId = 0;

  @override
  Usuario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usuario(
      nome: fields[0] as String,
      pastas: (fields[1] as List?)?.cast<Pasta>(),
      senhas: (fields[2] as List?)?.cast<Senha>(),
    );
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.pastas)
      ..writeByte(2)
      ..write(obj.senhas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PastaAdapter extends TypeAdapter<Pasta> {
  @override
  final int typeId = 1;

  @override
  Pasta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pasta(
      nome: fields[0] as String,
      subpastas: (fields[1] as List?)?.cast<Pasta>(),
      senhas: (fields[2] as List?)?.cast<Senha>(),
      ultimaModificacao: fields[3] as DateTime?,
      favorito: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Pasta obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.subpastas)
      ..writeByte(2)
      ..write(obj.senhas)
      ..writeByte(3)
      ..write(obj.ultimaModificacao)
      ..writeByte(4)
      ..write(obj.favorito);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PastaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SenhaAdapter extends TypeAdapter<Senha> {
  @override
  final int typeId = 2;

  @override
  Senha read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Senha(
      nome: fields[0] as String,
      senha: fields[1] as String,
      ultimaModificacao: fields[2] as DateTime?,
      favorito: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Senha obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.senha)
      ..writeByte(2)
      ..write(obj.ultimaModificacao)
      ..writeByte(3)
      ..write(obj.favorito);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SenhaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
