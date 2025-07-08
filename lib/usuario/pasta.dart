import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../cores.dart';
import '../ed.dart';
import '../itens/item.dart';
import 'novoItemDialog.dart'; // para showAddOptionDialog
import 'filtro.dart';
import 'deletarItens.dart';

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

  String filtro = 'todos';  // filtro ativo

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

    // Filtra os itens conforme filtro selecionado
    List<Item> itensFiltrados;
    if (filtro == 'pastas') {
      itensFiltrados = todosItens.where((i) => i.tipo == 'pasta').toList();
    } else if (filtro == 'senhas') {
      itensFiltrados = todosItens.where((i) => i.tipo == 'senha').toList();
    } else {
      itensFiltrados = todosItens;
    }

    // Ordena itens por favorito e ultima modificação
    itensFiltrados.sort((a, b) {
      if (a.favorito && !b.favorito) return -1;
      if (!a.favorito && b.favorito) return 1;
      return b.ultimaModificacao.compareTo(a.ultimaModificacao);
    });

    return Scaffold(
      appBar: AppBar(
        title: selecionando
            ? Text('${selecionados.length} selecionado(s)')
            : Text(pasta.nome),
        leading: selecionando
            ? IconButton(
          icon: const Icon(Icons.close),
          onPressed: _cancelarSelecao,
        )
            : null,
        actions: [
          if (selecionando)
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Excluir itens selecionados',
              onPressed: () async {
                await deletarSelecionadosGenerico(
                  context: context,
                  target: widget.pasta,
                  userBox: widget.userBox,
                  selecionados: selecionados,
                );
                setState(() {
                  selecionando = false;
                  selecionados.clear();
                });
              },
            )
          else ...[
            IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              tooltip: isVisible ? 'Ocultar senhas' : 'Mostrar senhas',
              onPressed: () => setState(() => isVisible = !isVisible),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Editar usuário',
              onPressed: () {
              },
            ),
          ]
        ],
      ),
      body: ListView.builder(
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

          return GestureDetector(
            onLongPress: () {
              setState(() {
                selecionando = true;
                selecionados.add(item);
              });
            },
            onTap: selecionando
                ? () => _toggleSelecionado(item)
                : () {
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
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: item.tipo == 'pasta'
                    ? AppColors.pasta.withOpacity(0.2)
                    : AppColors.primaria.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: selecionado
                    ? Border.all(color: cs.secondary, width: 2)
                    : null,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    item.tipo == 'pasta' ? Icons.folder : Icons.lock,
                    color: item.tipo == 'pasta'
                        ? AppColors.pasta
                        : AppColors.primaria,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nome,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                            color: cs.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (item.tipo == 'senha') ...[
                          const SizedBox(height: 4),
                          Text(
                            isVisible ? item.senha!.senha : '*******',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: cs.onPrimary),
                          ),
                        ]
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star,
                      color: item.favorito ? Colors.amber : Colors.grey,
                    ),
                    onPressed: toggleFavorito,
                  ),
                  if (item.tipo == 'senha')
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.grey),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: item.senha!.senha),
                        );
                      },
                      tooltip: 'Copiar senha',
                    ),
                ],
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: FilterButton(
                    label: 'Senhas',
                    active: filtro == 'senhas',
                    onPressed: () {
                      setState(() => filtro = filtro == 'senhas' ? 'todos' : 'senhas');
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 0,
            child: FloatingActionButton(
              onPressed: () => showAddOptionDialog(
                context: context,
                target: widget.pasta,      // Passa a pasta atual como pai para adicionar item nela
                userBox: widget.userBox,   // Passa a box para salvar o usuário
                onUpdate: () => setState(() {}), // Atualiza a UI depois
              ),
              backgroundColor: cs.secondary,
              foregroundColor: cs.onSecondary,
              child: const Icon(Icons.add, size: 36),
            ),
          ),
        ],
      ),
    );
  }
}