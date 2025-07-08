import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';

import '../ed.dart';
import '../cores.dart';

import '../itens/item.dart';
import 'novoItemDialog.dart';
import 'filtro.dart';
import 'deletarItens.dart';

// Importe a página PastaPage
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

  bool selecionando = false;
  Set<Item> selecionados = {};

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
    if (Hive.isBoxOpen(name)) {
      return Hive.box<Usuario>(name);
    }
    return Hive.openBox<Usuario>(name);
  }

  @override
  void dispose() {
    if (userBox.isOpen) {
      userBox.close();
    }
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
    final cs = Theme.of(context).colorScheme;

    if (loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Carregando usuário...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final usuario = userBox.values.isNotEmpty ? userBox.values.first : null;
    if (usuario == null) {
      return const Scaffold(
        body: Center(child: Text('Usuário não encontrado')),
      );
    }

    final List<Item> itens = [
      if (usuario.pastas != null) ...usuario.pastas!.map((p) => Item.pasta(p)),
      if (usuario.senhas != null) ...usuario.senhas!.map((s) => Item.senha(s)),
    ];

    itens.sort((a, b) {
      if (a.favorito && !b.favorito) return -1;
      if (!a.favorito && b.favorito) return 1;
      return b.ultimaModificacao.compareTo(a.ultimaModificacao);
    });

    List<Item> itensFiltrados;
    if (filtro == 'pastas') {
      itensFiltrados = itens.where((i) => i.tipo == 'pasta').toList();
    } else if (filtro == 'senhas') {
      itensFiltrados = itens.where((i) => i.tipo == 'senha').toList();
    } else {
      itensFiltrados = itens;
    }

    return Scaffold(
      appBar: AppBar(
        title: selecionando
            ? Text('${selecionados.length} selecionado(s)')
            : Text(usuario.nome),
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
                  target: usuario,
                  userBox: userBox,
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
            if (usuario != null) {
              await userBox.putAt(0, usuario);
              setState(() {});
            }
          }

          return GestureDetector(
            onLongPress: () {
              setState(() {
                selecionando = true;
                selecionados.add(item);
              });
            },
            onTap: () {
              if (selecionando) {
                _toggleSelecionado(item);
              } else if (item.tipo == 'pasta') {
                // Navega para a página da pasta, passando o objeto Pasta e userBox
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PastaPage(
                      pasta: item.pasta!,
                      userBox: userBox,
                    ),
                  ),
                );
              }
              // Se quiser, pode adicionar comportamento para senhas no tap
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
                    color:
                    item.tipo == 'pasta' ? AppColors.pasta : AppColors.primaria,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nome,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                        Clipboard.setData(ClipboardData(text: item.senha!.senha));
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
                target: usuario,       // Passa o usuário como pai
                userBox: userBox,       // Passa a box para salvar
                onUpdate: () => setState(() {}),
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