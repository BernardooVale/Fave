import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../ed.dart';
import '../cores.dart';

import '../itens/item.dart';
import 'novoItemDialog.dart';
import 'filtro.dart';
import 'deletarItens.dart';
import 'pasta.dart';

class UsuarioPage extends StatefulWidget {
  final String userId;
  const UsuarioPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  late Box<Usuario> userBox;
  bool loading = true;
  bool isVisible = false;
  String filtro = 'todos';

  final ScrollController _scrollController = ScrollController();

  final Set<Item> selecionados = {};
  bool get selecionando => selecionados.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _loadUserBox();
  }

  Future<void> _loadUserBox() async {
    userBox = await _openUserBox(widget.userId);
    setState(() => loading = false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    });
  }

  Future<Box<Usuario>> _openUserBox(String userId) async {
    final name = 'user_$userId';
    if (Hive.isBoxOpen(name)) return Hive.box<Usuario>(name);
    return Hive.openBox<Usuario>(name);
  }

  @override
  void dispose() {
    if (userBox.isOpen) userBox.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleSelecionado(Item item) {
    setState(() {
      if (selecionados.contains(item)) {
        selecionados.remove(item);
      } else {
        selecionados.add(item);
      }
    });
  }

  void _cancelarSelecao() => setState(() => selecionados.clear());

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final usuario = userBox.values.isNotEmpty ? userBox.values.first : null;
    if (usuario == null) {
      return const Scaffold(body: Center(child: Text('Usuário não encontrado')));
    }

    final List<Item> itens = [
      if (usuario.pastas != null) ...usuario.pastas!.map(Item.pasta),
      if (usuario.senhas != null) ...usuario.senhas!.map(Item.senha),
    ]..sort((a, b) {
      if (a.favorito && !b.favorito) return -1;
      if (!a.favorito && b.favorito) return 1;
      return b.ultimaModificacao.compareTo(a.ultimaModificacao);
    });

    final itensFiltrados = filtro == 'pastas'
        ? itens.where((i) => i.tipo == 'pasta').toList()
        : filtro == 'senhas'
        ? itens.where((i) => i.tipo == 'senha').toList()
        : itens;

    return Scaffold(
      appBar: AppBar(
        title: selecionando
            ? Text('${selecionados.length} selecionado(s)')
            : Text(usuario.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: selecionando
            ? IconButton(icon: const Icon(Icons.close), onPressed: _cancelarSelecao)
            : null,
        actions: [
          if (!selecionando)
            IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              tooltip: isVisible ? 'Ocultar senhas' : 'Mostrar senhas',
              onPressed: () => setState(() => isVisible = !isVisible),
            ),
        ],
        backgroundColor: AppColors.mel.withOpacity(0.7),
        elevation: 2,
      ),

    body: itensFiltrados.isEmpty
          ? Center(
        child: Text(
          'Nenhum item para mostrar.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      )
          : ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        reverse: true,
        itemCount: itensFiltrados.length,
        itemBuilder: (context, index) {
          final item = itensFiltrados[index];
          final selecionado = selecionados.contains(item);

          Future<void> toggleFavorito() async {
            if (item.tipo == 'pasta') {
              item.pasta!.favorito = !item.pasta!.favorito;
            } else {
              item.senha!.favorito = !item.senha!.favorito;
            }
            await userBox.putAt(0, usuario);
            setState(() {});
          }

          return Card(
            elevation: selecionado ? 6 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: selecionado
                  ? BorderSide(color: AppColors.terciaria, width: 2)
                  : BorderSide.none,
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: item.tipo == 'pasta'
                ? AppColors.pasta.withOpacity(0.2)
                : AppColors.primaria.withOpacity(0.2),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onLongPress: () => setState(() => selecionados.add(item)),
              onTap: () {
                if (selecionando) {
                  _toggleSelecionado(item);
                } else if (item.tipo == 'pasta') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PastaPage(pasta: item.pasta!, userBox: userBox),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Icon(
                      item.tipo == 'pasta' ? Icons.folder : Icons.vpn_key,
                      color: item.tipo == 'pasta' ? AppColors.pasta : AppColors.primaria,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.nome,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: cs.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (item.tipo == 'senha') ...[
                            const SizedBox(height: 4),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isVisible
                                    ? Colors.grey.withOpacity(0.15)
                                    : Colors.grey.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                isVisible ? item.senha!.senha : '••••••••',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: cs.onPrimary?.withOpacity(0.85),
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.star,
                        color: item.favorito ? Colors.amber : Colors.grey,
                      ),
                      tooltip: item.favorito ? 'Favorito' : 'Marcar favorito',
                      onPressed: toggleFavorito,
                    ),
                    if (item.tipo == 'senha')
                      IconButton(
                        icon: const Icon(Icons.copy, color: Colors.grey),
                        tooltip: 'Copiar senha',
                        onPressed: () =>
                            Clipboard.setData(ClipboardData(text: item.senha!.senha)),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // filtros
          Positioned(
            bottom: 16,
            left: 30,
            child: Row(
              children: [
                FilterButton(
                  label: 'Pastas',
                  active: filtro == 'pastas',
                  onPressed: () => setState(
                          () => filtro = filtro == 'pastas' ? 'todos' : 'pastas'),
                ),
                const SizedBox(width: 10),
                FilterButton(
                  label: 'Senhas',
                  active: filtro == 'senhas',
                  onPressed: () => setState(() =>
                  filtro == 'senhas' ? filtro = 'todos' : filtro = 'senhas'),
                ),
              ],
            ),
          ),

          // FAB
          Positioned(
            bottom: 16,
            right: 0,
            child: FloatingActionButton(
              backgroundColor:
              selecionando ? AppColors.terciaria : cs.secondary,
              foregroundColor: cs.onSecondary,
              tooltip: selecionando ? 'Excluir itens selecionados' : 'Adicionar novo item',
              child: Icon(selecionando ? Icons.delete : Icons.add, size: 32),
              onPressed: () async {
                if (selecionando) {
                  await deletarSelecionadosGenerico(
                    context: context,
                    target: usuario,
                    userBox: userBox,
                    selecionados: selecionados,
                  );
                  setState(() => selecionados.clear());
                } else {
                  await showAddOptionDialog(
                    context: context,
                    target: usuario,
                    userBox: userBox,
                    onUpdate: () => setState(() {}),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}