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
      documentos: (fields[3] as List?)?.cast<Documento>(),
    );
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.pastas)
      ..writeByte(2)
      ..write(obj.senhas)
      ..writeByte(3)
      ..write(obj.documentos);
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
      documentos: (fields[3] as List?)?.cast<Documento>(),
      ultimaModificacao: fields[4] as DateTime?,
      favorito: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Pasta obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.subpastas)
      ..writeByte(2)
      ..write(obj.senhas)
      ..writeByte(3)
      ..write(obj.documentos)
      ..writeByte(4)
      ..write(obj.ultimaModificacao)
      ..writeByte(5)
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

class DocumentoAdapter extends TypeAdapter<Documento> {
  @override
  final int typeId = 3;

  @override
  Documento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Documento(
      nome: fields[0] as String,
      numero: fields[1] as String,
      dataEmissao: fields[2] as DateTime?,
      dataVencimento: fields[3] as DateTime?,
      orgaoExpedidor: fields[4] as String?,
      ultimaModificacao: fields[5] as DateTime?,
      favorito: fields[6] as bool,
      fotosCriptografadas: (fields[7] as List?)?.cast<Uint8List>(),
    );
  }

  @override
  void write(BinaryWriter writer, Documento obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.numero)
      ..writeByte(2)
      ..write(obj.dataEmissao)
      ..writeByte(3)
      ..write(obj.dataVencimento)
      ..writeByte(4)
      ..write(obj.orgaoExpedidor)
      ..writeByte(5)
      ..write(obj.ultimaModificacao)
      ..writeByte(6)
      ..write(obj.favorito)
      ..writeByte(7)
      ..write(obj.fotosCriptografadas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
