import '../ed.dart';

/// Representa um item genérico que pode ser uma pasta, senha ou documento.
class Item {
  /// Define o tipo do item: 'pasta', 'senha' ou 'documento'.
  final String tipo;

  /// Objeto do tipo Pasta, se for esse o tipo do item.
  final Pasta? pasta;

  /// Objeto do tipo Senha, se for esse o tipo do item.
  final Senha? senha;

  /// Objeto do tipo Documento, se for esse o tipo do item.
  final Documento? documento;

  /// Data da última modificação do item.
  final DateTime ultimaModificacao;

  /// Construtor nomeado para criar um Item do tipo Pasta.
  Item.pasta(this.pasta)
      : tipo = 'pasta',
        senha = null,
        documento = null,
        ultimaModificacao = pasta?.ultimaModificacao ?? DateTime.fromMillisecondsSinceEpoch(0);

  /// Construtor nomeado para criar um Item do tipo Senha.
  Item.senha(this.senha)
      : tipo = 'senha',
        pasta = null,
        documento = null,
        ultimaModificacao = senha?.ultimaModificacao ?? DateTime.fromMillisecondsSinceEpoch(0);

  /// Construtor nomeado para criar um Item do tipo Documento.
  Item.documento(this.documento)
      : tipo = 'documento',
        pasta = null,
        senha = null,
        ultimaModificacao = documento?.ultimaModificacao ?? DateTime.fromMillisecondsSinceEpoch(0);

  /// Retorna se o item está marcado como favorito.
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

  /// Retorna o nome do item, independentemente do tipo.
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

  /// Compara dois objetos Item com base no tipo e no conteúdo correspondente.
  @override
  bool operator ==(Object other) {
    return other is Item &&
        tipo == other.tipo &&
        ((tipo == 'pasta' && pasta == other.pasta) ||
            (tipo == 'senha' && senha == other.senha) ||
            (tipo == 'documento' && documento == other.documento));
  }

  /// Gera um hashCode consistente com o operador de igualdade.
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