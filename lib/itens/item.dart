import '../ed.dart';

class Item {
  final String tipo; // "pasta", "senha" ou "documento"
  final Pasta? pasta;
  final Senha? senha;
  final Documento? documento;
  final DateTime ultimaModificacao;

  Item.pasta(this.pasta)
      : tipo = 'pasta',
        senha = null,
        documento = null,
        ultimaModificacao = pasta?.ultimaModificacao ?? DateTime.fromMillisecondsSinceEpoch(0);

  Item.senha(this.senha)
      : tipo = 'senha',
        pasta = null,
        documento = null,
        ultimaModificacao = senha?.ultimaModificacao ?? DateTime.fromMillisecondsSinceEpoch(0);

  Item.documento(this.documento)
      : tipo = 'documento',
        pasta = null,
        senha = null,
        ultimaModificacao = documento?.ultimaModificacao ?? DateTime.fromMillisecondsSinceEpoch(0);

  bool get favorito {
    switch (tipo) {
      case 'pasta':
        return pasta?.favorito ?? false;
      case 'senha':
        return senha?.favorito ?? false;
      case 'documento':
        return documento?.favorito ?? false;
      default:
        return false;
    }
  }

  String get nome {
    switch (tipo) {
      case 'pasta':
        return pasta?.nome ?? '';
      case 'senha':
        return senha?.nome ?? '';
      case 'documento':
        return documento?.nome ?? '';
      default:
        return '';
    }
  }

  @override
  bool operator ==(Object other) {
    return other is Item &&
        tipo == other.tipo &&
        ((tipo == 'pasta' && pasta == other.pasta) ||
            (tipo == 'senha' && senha == other.senha) ||
            (tipo == 'documento' && documento == other.documento));
  }

  @override
  int get hashCode {
    switch (tipo) {
      case 'pasta':
        return tipo.hashCode ^ pasta.hashCode;
      case 'senha':
        return tipo.hashCode ^ senha.hashCode;
      case 'documento':
        return tipo.hashCode ^ documento.hashCode;
      default:
        return tipo.hashCode;
    }
  }
}