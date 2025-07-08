import '../ed.dart';

class Item {
  final String tipo; // "pasta" ou "senha"
  final Pasta? pasta;
  final Senha? senha;
  final DateTime ultimaModificacao;

  Item.pasta(this.pasta)
      : tipo = 'pasta',
        senha = null,
        ultimaModificacao = pasta?.ultimaModificacao ?? DateTime.fromMillisecondsSinceEpoch(0);

  Item.senha(this.senha)
      : tipo = 'senha',
        pasta = null,
        ultimaModificacao = senha?.ultimaModificacao ?? DateTime.fromMillisecondsSinceEpoch(0);

  bool get favorito => tipo == 'pasta' ? (pasta?.favorito ?? false) : (senha?.favorito ?? false);
  String get nome => tipo == 'pasta' ? pasta!.nome : senha!.nome;

  @override
  bool operator ==(Object other) {
    return other is Item &&
        tipo == other.tipo &&
        ((tipo == 'pasta' && pasta == other.pasta) ||
            (tipo == 'senha' && senha == other.senha));
  }

  @override
  int get hashCode => tipo.hashCode ^ (tipo == 'pasta' ? pasta.hashCode : senha.hashCode);
}