import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../cores.dart';
import '../ed.dart';
import '../cofre.dart';
import '../itens/item.dart';
import '../notificacao/notificacao.dart';
import 'documentoDialog.dart';
import 'filtroDialog.dart';
import 'novoItemDialog.dart';
import 'filtro.dart';
import 'deletarItens.dart';
import 'editSenha.dart';
import '../generated/l10n.dart';
import '../widgets/motifs.dart';
import '../widgets/arched_container.dart';

class PastaPage extends StatefulWidget {
  final Pasta pasta;
  final UserCofre cofre;
  final bool isVisibleIni;

  const PastaPage({
    Key? key,
    required this.pasta,
    required this.cofre,
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
      ...widget.cofre.pastas.values.where((p) => p.parentPastaId == pasta.id).map((p) => Item.pasta(p)),
      ...widget.cofre.senhas.values.where((s) => s.parentPastaId == pasta.id).map((s) => Item.senha(s)),
      ...widget.cofre.documentos.values.where((d) => d.parentPastaId == pasta.id).map((d) => Item.documento(d))
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: selecionando
            ? Text(s.selectedItemsCount(selecionados.length))
            : Text(pasta.nome, style: const TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold)),
        leading: selecionando
            ? IconButton(icon: const Icon(Icons.close_rounded), onPressed: _cancelarSelecao)
            : null,
        actions: [
          if (!selecionando)
            IconButton(
              icon: Icon(isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.brass),
              tooltip: isVisible ? s.hidePasswordsTooltip : s.showPasswordsTooltip,
              onPressed: () => setState(() => isVisible = !isVisible),
            ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: AzulejoPatternPainter(opacity: 0.02)),
          ),
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 40),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: mostrandoBusca
                    ? Padding(
                  key: const ValueKey('buscaCampo'),
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocus,
                    onChanged: _onFiltroChanged,
                    style: const TextStyle(color: AppColors.ivory),
                    decoration: InputDecoration(
                      hintText: s.searchHintText,
                      hintStyle: const TextStyle(color: Colors.white38),
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.brass),
                      filled: true,
                      fillColor: AppColors.wood.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.brass),
                      ),
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: itensFiltrados.isEmpty
                    ? Center(
                      child: Text(
                        s.noItemsToShow,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.brass.withOpacity(0.5)),
                      ),
                    )
                    : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                    reverse: true,
                    itemCount: itensFiltrados.length,
                    itemBuilder: (context, index) {
                      final item = itensFiltrados[index];
                      final selecionado = selecionados.contains(item);

                      Color itemColor;
                      IconData itemIcon;
                      switch (item.tipo) {
                        case 'pasta':
                          itemColor = AppColors.terracotta;
                          itemIcon = Icons.folder_open_rounded;
                          break;
                        case 'documento':
                          itemColor = AppColors.botanical;
                          itemIcon = Icons.description_outlined;
                          break;
                        default:
                          itemColor = AppColors.azulejo;
                          itemIcon = Icons.key_outlined;
                      }

                      Future<void> toggleFavorito() async {
                        if (item.tipo == 'pasta') {
                          item.pasta!.favorito = !item.pasta!.favorito;
                          await widget.cofre.pastas.put(item.pasta!.id, item.pasta!);
                        } else if (item.tipo == 'senha') {
                          item.senha!.favorito = !item.senha!.favorito;
                          await widget.cofre.senhas.put(item.senha!.id, item.senha!);
                        } else if (item.tipo == 'documento') {
                          item.documento!.favorito = !item.documento!.favorito;
                          await widget.cofre.documentos.put(item.documento!.id, item.documento!);
                        }
                        setState(() {});
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ArchedContainer(
                          archRadius: 24,
                          decoration: BoxDecoration(
                            color: selecionado ? AppColors.brass.withOpacity(0.15) : itemColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: selecionado ? AppColors.brass : itemColor.withOpacity(0.3),
                              width: selecionado ? 2 : 1,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
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
                                        cofre: widget.cofre,
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
                                      item.senha!.ultimaModificacao = DateTime.now();
                                      await widget.cofre.senhas.put(item.senha!.id, item.senha!);
                                      setState(() {});
                                    },
                                  );
                                } else if (item.tipo == 'documento') {
                                  documentoDialog(context, item.documento!, widget.cofre);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: itemColor.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(itemIcon, color: itemColor, size: 24),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.nome,
                                            style: const TextStyle(
                                              color: AppColors.ivory,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          if (item.tipo == 'senha' || item.tipo == 'documento')
                                            Text(
                                              isVisible 
                                                ? (item.tipo == 'senha' ? item.senha!.senha : item.documento!.numero)
                                                : '••••••••',
                                              style: TextStyle(
                                                color: AppColors.ivory.withOpacity(0.5),
                                                letterSpacing: isVisible ? 1 : 3,
                                                fontSize: 12,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        item.favorito ? Icons.star_rounded : Icons.star_outline_rounded,
                                        color: item.favorito ? AppColors.brass : Colors.grey,
                                      ),
                                      onPressed: toggleFavorito,
                                    ),
                                    if (item.tipo != 'pasta')
                                      IconButton(
                                        icon: const Icon(Icons.copy_rounded, color: Colors.grey, size: 20),
                                        onPressed: () {
                                          final val = item.tipo == 'senha' ? item.senha!.senha : item.documento!.numero;
                                          Clipboard.setData(ClipboardData(text: val));
                                          mostrarNotificacao(
                                              context: context,
                                              mensagem: item.tipo == 'senha' ? s.passwordCopiedNotification : s.documentNumberCopiedNotification,
                                              background: AppColors.brass.withOpacity(0.8)
                                          );
                                        }
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              heroTag: 'filter',
              backgroundColor: AppColors.wood,
              foregroundColor: AppColors.brass,
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
                    filtro = tiposSelecionados.length == 3 ? 'todos' : tiposSelecionados.join(',');
                  });
                }
              },
              child: const Icon(Icons.filter_list_rounded),
            ),
            const SizedBox(width: 12),
            FloatingActionButton.small(
              heroTag: 'search_vault',
              backgroundColor: mostrandoBusca ? AppColors.terciaria : AppColors.wood,
              foregroundColor: AppColors.brass,
              onPressed: _toggleBusca,
              child: Icon(mostrandoBusca ? Icons.close_rounded : Icons.search_rounded),
            ),
            const SizedBox(width: 12),
            FloatingActionButton.extended(
              heroTag: 'add_vault',
              backgroundColor: selecionando ? AppColors.terciaria : AppColors.mel,
              foregroundColor: selecionando ? Colors.white : Colors.black,
              onPressed: () async {
                if (selecionando) {
                  await deletarSelecionadosGenerico(context: context, cofre: widget.cofre, selecionados: selecionados);
                  _cancelarSelecao();
                } else {
                  await showAddOptionDialog(context: context, parentPastaId: widget.pasta.id, cofre: widget.cofre, onUpdate: () => setState(() {}));
                }
              },
              icon: Icon(selecionando ? Icons.delete_outline_rounded : Icons.add_rounded),
              label: Text(selecionando ? s.apagar : s.confirmButtonText.split(' ')[0]),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ],
        ),
      ),
    );
  }
}
