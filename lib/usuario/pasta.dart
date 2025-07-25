import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../cores.dart';
import '../ed.dart';
import '../itens/item.dart';
import '../notificacao/notificacao.dart';
import 'documentoDialog.dart';
import 'filtroDialog.dart';
import 'novoItemDialog.dart'; // para showAddOptionDialog
import 'filtro.dart';
import 'deletarItens.dart';
import 'editSenha.dart';
import '../generated/l10n.dart';

class PastaPage extends StatefulWidget {
  final Pasta pasta;
  final Box<Usuario> userBox;
  final bool isVisibleIni;

  const PastaPage({
    Key? key,
    required this.pasta,
    required this.userBox,
    this.isVisibleIni = false,
  }) : super(key: key);

  @override
  State<PastaPage> createState() => _PastaPageState();
}

class _PastaPageState extends State<PastaPage> with SingleTickerProviderStateMixin {
  late bool isVisible;
  bool selecionando = false;
  Set<Item> selecionados = {};
  final ScrollController _scrollController = ScrollController();

  String filtro = 'todos';
  bool mostrandoBusca = false;
  String termoPesquisa = '';

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    isVisible = widget.isVisibleIni;

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    _scrollController.dispose();
    _fadeController.dispose();
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

  void _toggleBusca() {
    setState(() {
      mostrandoBusca = !mostrandoBusca;
      if (!mostrandoBusca) {
        termoPesquisa = '';
        _searchController.clear();
        _searchFocus.unfocus();
        _fadeController.forward();
      } else {
        Future.delayed(const Duration(milliseconds: 100),
                () => FocusScope.of(context).requestFocus(_searchFocus));
      }
    });
  }

  void _onFiltroChanged(String value) {
    setState(() {
      termoPesquisa = value.trim();
      _fadeController.reset();
      _fadeController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pasta = widget.pasta;
    final cs = Theme.of(context).colorScheme;
    final s = S.of(context);

    final List<Item> todosItens = [
      if (pasta.subpastas != null) ...pasta.subpastas!.map((p) => Item.pasta(p)),
      if (pasta.senhas != null) ...pasta.senhas!.map((s) => Item.senha(s)),
      if (pasta.documentos != null) ...pasta.documentos!.map((s) => Item.documento(s))
    ];

    final Map<String, String> pluralToSingular = {
      'pastas': 'pasta',
      'senhas': 'senha',
      'documentos': 'documento',
    };

    final Set<String> tiposSelecionados = filtro == 'todos'
        ? {'pasta', 'senha', 'documento'}
        : filtro
        .split(',')
        .map((t) => pluralToSingular[t.trim()] ?? t)
        .toSet();

    final List<Item> itensFiltrados = todosItens
        .where((i) =>
    tiposSelecionados.contains(i.tipo) &&
        (termoPesquisa.isEmpty ||
            i.nome.toLowerCase().contains(termoPesquisa.toLowerCase())))
        .toList();


    itensFiltrados.sort((a, b) {
      if (a.favorito && !b.favorito) return -1;
      if (!a.favorito && b.favorito) return 1;
      return b.ultimaModificacao.compareTo(a.ultimaModificacao);
    });

    return Scaffold(
      appBar: AppBar(
        title: selecionando
            ? Text(s.selectedItemsCount(selecionados.length))
            : Text(pasta.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: selecionando
            ? IconButton(icon: const Icon(Icons.close_rounded), onPressed: _cancelarSelecao)
            : null,
        actions: [
          if (!selecionando)
            IconButton(
              icon: Icon(isVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded),
              tooltip: isVisible ? s.hidePasswordsTooltip : s.showPasswordsTooltip,
              onPressed: () => setState(() => isVisible = !isVisible),
            ),
        ],
        backgroundColor: AppColors.mel,
        elevation: 2,
        bottom: null,
      ),

      body: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: mostrandoBusca
                ? Padding(
              key: const ValueKey('buscaCampo'),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocus,
                autofocus: true,
                onChanged: _onFiltroChanged,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: s.searchHintText,
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primaria),
                  suffixIcon: termoPesquisa.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white70),
                    onPressed: () {
                      _searchController.clear();
                      _onFiltroChanged('');
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: itensFiltrados.isEmpty
                ? Center(
                  child: Text(
                    s.noItemsToShow,
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
                    } else if (item.tipo == 'senha') {
                      item.senha!.favorito = !item.senha!.favorito;
                    } else if (item.tipo == 'documento') {
                      item.documento!.favorito = !item.documento!.favorito;
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
                        : item.tipo == 'documento'
                        ? AppColors.doc.withOpacity(0.2)
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
                                isVisibleIni: isVisible,
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
                        } else if (item.tipo == 'documento') {
                          documentoDialog(context, item.documento!);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              item.tipo == 'pasta'
                                  ? Icons.folder_rounded
                                  : item.tipo == 'documento'
                                  ? Icons.description_rounded
                                  : Icons.vpn_key_rounded,
                              color: item.tipo == 'pasta'
                                  ? AppColors.pasta
                                  : item.tipo == 'documento'
                                  ? AppColors.doc
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
                                        color: Colors.grey.withOpacity(0.15),
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
                                  if (item.tipo == 'documento') ...[
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        isVisible ? item.documento!.numero : '••••••••',
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
                                Icons.star_rounded,
                                color: item.favorito ? Colors.amber : Colors.grey,
                              ),
                              tooltip: item.favorito ? s.favoriteTooltip : s.markFavoriteTooltip,
                              onPressed: toggleFavorito,
                            ),
                            if (item.tipo == 'senha')
                              IconButton(
                                  icon: const Icon(Icons.copy_rounded, color: Colors.grey),
                                  tooltip: s.copyPasswordTooltip,
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: item.senha!.senha),
                                    );
                                    mostrarNotificacao(
                                        context: context,
                                        mensagem: s.passwordCopiedNotification,
                                        background: AppColors.primaria.withOpacity(0.8)
                                    );
                                  }
                              ),
                            if (item.tipo == 'documento')
                              IconButton(
                                  icon: const Icon(Icons.copy_rounded, color: Colors.grey),
                                  tooltip: s.copyDocumentNumberTooltip,
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: item.documento!.numero),
                                    );
                                    mostrarNotificacao(
                                        context: context,
                                        mensagem: s.documentNumberCopiedNotification,
                                        background: AppColors.doc.withOpacity(0.8)
                                    );
                                  }
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ]
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned(
            bottom: 16,
            left: 30,
            child: FilterButton(
              label: s.filtersButtonLabel,
              active: filtro != 'todos',
              onPressed: () async {
                final tiposSelecionados = await showDialog<Set<String>>(
                  context: context,
                  builder: (context) => filtroDialog(
                    tiposAtuais: filtro == 'todos'
                        ? {'pastas', 'senhas', 'documentos'}
                        : filtro.split(',').toSet(),
                  ),
                );

                if (tiposSelecionados != null) {
                  setState(() {
                    filtro = tiposSelecionados.length == 3
                        ? 'todos'
                        : tiposSelecionados.join(',');
                  });
                }
              },
            ),
          ),
          Positioned(
            bottom: 16,
            left: 140,
            child: FloatingActionButton.extended(
              heroTag: 'search',
              tooltip: mostrandoBusca ? s.closeButtonTooltip : s.searchHintText,
              onPressed: _toggleBusca,
              icon: Icon(mostrandoBusca ? Icons.close_rounded : Icons.search_rounded),
              label: Text(
                mostrandoBusca ? s.closeButtonTooltip : s.searchButtonText,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: mostrandoBusca ? AppColors.terciaria : AppColors.primaria,
              foregroundColor: AppColors.fundo,
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
              selecionando ? s.deleteSelectedItemsTooltip : s.addNewItemTooltip,
              child: Icon(selecionando ? Icons.delete_rounded : Icons.add_rounded, size: 32),
            ),
          ),
        ],
      ),
    );
  }
}