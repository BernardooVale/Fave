import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../cores.dart';
import '../ed.dart';
import '../itens/item.dart';
import 'novoItemDialog.dart'; // para showAddOptionDialog
import 'filtro.dart';
import 'deletarItens.dart';
import 'editSenha.dart';

class PastaPage extends StatefulWidget {
  final Pasta pasta;
  final Box<Usuario> userBox;

  const PastaPage({
    Key? key,
    required this.pasta,
    required this.userBox,
  }) : super(key: key);

  @override
  State<PastaPage> createState() => _PastaPageState();
}

class _PastaPageState extends State<PastaPage> {
  bool isVisible = false;
  bool selecionando = false;
  Set<Item> selecionados = {};
  final ScrollController _scrollController = ScrollController();

  String filtro = 'todos';

  void _toggleSelecionado(Item item) {
    setState(() {
      if (selecionados.contains(item)) {
        selecionados.remove(item);
      } else {
        selecionados.add(item);
      }
      if (selecionados.isEmpty) {
        selecionando = false;
      }
    });
  }

  void _cancelarSelecao() {
    setState(() {
      selecionando = false;
      selecionados.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pasta = widget.pasta;
    final cs = Theme.of(context).colorScheme;

    final List<Item> todosItens = [
      if (pasta.subpastas != null) ...pasta.subpastas!.map((p) => Item.pasta(p)),
      if (pasta.senhas != null) ...pasta.senhas!.map((s) => Item.senha(s)),
    ];

    List<Item> itensFiltrados;
    if (filtro == 'pastas') {
      itensFiltrados = todosItens.where((i) => i.tipo == 'pasta').toList();
    } else if (filtro == 'senhas') {
      itensFiltrados = todosItens.where((i) => i.tipo == 'senha').toList();
    } else {
      itensFiltrados = todosItens;
    }

    itensFiltrados.sort((a, b) {
      if (a.favorito && !b.favorito) return -1;
      if (!a.favorito && b.favorito) return 1;
      return b.ultimaModificacao.compareTo(a.ultimaModificacao);
    });

    return Scaffold(
      appBar: AppBar(
        title: selecionando
            ? Text('${selecionados.length} selecionado(s)')
            : Text(pasta.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: selecionando
            ? IconButton(icon: const Icon(Icons.close_rounded), onPressed: _cancelarSelecao)
            : null,
        actions: [
          if (!selecionando)
            IconButton(
              icon: Icon(isVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded),
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
            await widget.userBox.putAt(0, widget.userBox.values.first);
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
              onLongPress: () {
                setState(() {
                  selecionando = true;
                  selecionados.add(item);
                });
              },
              onTap: selecionando
                  ? () => _toggleSelecionado(item)
                  : () async {
                if (item.tipo == 'pasta') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PastaPage(
                        pasta: item.pasta!,
                        userBox: widget.userBox,
                      ),
                    ),
                  );
                } else if (item.tipo == 'senha') {
                  await showEditarSenhaDialog(
                    context: context,
                    nomeInicial: item.nome,
                    senhaInicial: item.senha!.senha,
                    onConfirmar: (novoNome, novaSenha) async {
                      item.senha!.nome = novoNome;
                      item.senha!.senha = novaSenha;

                      final usuario = widget.userBox.values.first;
                      await widget.userBox.putAt(0, usuario);

                      setState(() {});
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      item.tipo == 'pasta' ? Icons.folder_rounded : Icons.vpn_key_rounded,
                      color: item.tipo == 'pasta'
                          ? AppColors.pasta
                          : AppColors.primaria,
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
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isVisible
                                    ? Colors.grey.withOpacity(0.15)
                                    : Colors.grey.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                isVisible ? item.senha!.senha : '••••••••',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
                        Icons.star_rounded,
                        color: item.favorito ? Colors.amber : Colors.grey,
                      ),
                      tooltip: item.favorito ? 'Favorito' : 'Marcar favorito',
                      onPressed: toggleFavorito,
                    ),
                    if (item.tipo == 'senha')
                      IconButton(
                        icon: const Icon(Icons.copy_rounded, color: Colors.grey),
                        tooltip: 'Copiar senha',
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: item.senha!.senha),
                          );
                        },
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
          Positioned(
            bottom: 16,
            left: 30,
            child: Row(
              children: [
                FilterButton(
                  label: 'Pastas',
                  active: filtro == 'pastas',
                  onPressed: () {
                    setState(() => filtro = filtro == 'pastas' ? 'todos' : 'pastas');
                  },
                ),
                const SizedBox(width: 10),
                FilterButton(
                  label: 'Senhas',
                  active: filtro == 'senhas',
                  onPressed: () {
                    setState(() => filtro = filtro == 'senhas' ? 'todos' : 'senhas');
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 0,
            child: FloatingActionButton(
              onPressed: () async {
                if (selecionando) {
                  await deletarSelecionadosGenerico(
                    context: context,
                    target: widget.pasta,
                    userBox: widget.userBox,
                    selecionados: selecionados,
                  );
                  _cancelarSelecao();
                } else {
                  await showAddOptionDialog(
                    context: context,
                    target: widget.pasta,
                    userBox: widget.userBox,
                    onUpdate: () => setState(() {}),
                  );
                }
              },
              backgroundColor: selecionando ? AppColors.terciaria : cs.secondary,
              foregroundColor: cs.onSecondary,
              tooltip:
              selecionando ? 'Excluir itens selecionados' : 'Adicionar novo item',
              child: Icon(selecionando ? Icons.delete_rounded : Icons.add_rounded, size: 32),
            ),
          ),
        ],
      ),
    );
  }
}