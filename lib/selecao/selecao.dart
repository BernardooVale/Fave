import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../ed.dart';
import '../cofre.dart';
import '../usuario/usuario.dart';
import 'novoUsuarioDialog.dart';
import '../cores.dart';
import '../config.dart';
import '../generated/l10n.dart';

/// Tela de seleção de perfis de usuário.
/// Permite buscar, criar, selecionar e excluir perfis.
class Selecao extends StatefulWidget {
  const Selecao({super.key});

  @override
  State<Selecao> createState() => _SelecaoState();
}

class _SelecaoState extends State<Selecao> with SingleTickerProviderStateMixin {
  late Box<Usuario> usuariosBox; // Caixa Hive com os perfis
  bool loading = true; // Se ainda está carregando os dados
  String filtro = ''; // Texto do campo de busca
  bool mostrandoBusca = false; // Controla visibilidade do campo de busca

  final TextEditingController _buscaCtrl = TextEditingController();
  final FocusNode _buscaFocus = FocusNode();

  final Set<int> selecionados = {}; // Índices dos perfis selecionados
  bool get selecionando => selecionados.isNotEmpty;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Controlador de animação de fade
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);

    _init(); // Inicializa Hive
    _fadeController.forward();
  }

  /// Inicializa o Hive e abre/adapta as caixas necessárias
  Future<void> _init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UsuarioAdapter());
    Hive.registerAdapter(PastaAdapter());
    Hive.registerAdapter(SenhaAdapter());
    Hive.registerAdapter(DocumentoAdapter());

    usuariosBox = await Hive.openBox<Usuario>('usuarios');
    setState(() => loading = false);
  }

  /// Mostra confirmação de exclusão de perfis selecionados
  Future<void> _confirmarExcluir() async {
    final s = S.of(context);
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(s.excluirPerfil),
        content: Text(s.deleteProfilesConfirm(selecionados.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(s.cancelButtonText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(s.excluir, style: TextStyle(color: AppColors.terciaria)),
          ),
        ],
      ),
    );

    // Remove os perfis em ordem reversa
    if (confirmar == true) {
      final idsOrdenados = selecionados.toList()..sort((a, b) => b.compareTo(a));
      for (final idx in idsOrdenados) {
        await usuariosBox.deleteAt(idx);
      }
      setState(() => selecionados.clear());
    }
  }

  /// Alterna entre mostrar ou ocultar o campo de busca
  void _toggleBusca() {
    setState(() {
      mostrandoBusca = !mostrandoBusca;
      if (!mostrandoBusca) {
        filtro = '';
        _buscaCtrl.clear();
        _buscaFocus.unfocus();
        _fadeController.forward();
      } else {
        // Foca no campo de texto após pequeno atraso
        Future.delayed(
          const Duration(milliseconds: 100),
              () => FocusScope.of(context).requestFocus(_buscaFocus),
        );
      }
    });
  }

  /// Atualiza o texto de filtro e reinicia a animação
  void _onFiltroChanged(String value) {
    setState(() {
      filtro = value.trim();
      _fadeController.reset();
      _fadeController.forward();
    });
  }

  /// Abre a página de configurações
  Future<void> _abrirConfiguracoes() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const ConfigPage(),
    ));
    setState(() {}); // Atualiza a tela ao voltar
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // Traduções
    final cs = Theme.of(context).colorScheme; // Cores do tema

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Lista de perfis filtrados pelo nome
    final usuariosFiltrados = List.generate(
      usuariosBox.length,
          (i) => MapEntry(i, usuariosBox.getAt(i)!),
    ).where((entry) {
      return filtro.isEmpty || entry.value.nome.toLowerCase().contains(filtro.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mel,
        elevation: 2,
        centerTitle: true,
        title: selecionando
            ? Text(s.selectedItemsCount(selecionados.length)) // Quantidade de selecionados
            : Text(s.perfis, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: selecionando
            ? IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => setState(() => selecionados.clear()),
        )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: s.config,
            onPressed: _abrirConfiguracoes,
          ),
        ],
      ),

      body: usuariosBox.isEmpty
          ? Center(child: Text(s.semPerfis, style: const TextStyle(fontSize: 16)))
          : Column(
        children: [
          // Campo de busca (com transição fade)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: mostrandoBusca
                ? Padding(
              key: const ValueKey('buscaCampo'),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: _buscaCtrl,
                focusNode: _buscaFocus,
                onChanged: _onFiltroChanged,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: s.buscarPerfil,
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primaria),
                  suffixIcon: filtro.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white70),
                    onPressed: () {
                      _buscaCtrl.clear();
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

          // Lista de perfis
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.only(bottom: 90),
                itemCount: usuariosFiltrados.length,
                itemBuilder: (context, i) {
                  final idx = usuariosFiltrados[i].key;
                  final u = usuariosFiltrados[i].value;
                  final estaSelecionado = selecionados.contains(idx);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Card(
                      elevation: estaSelecionado ? 6 : 2,
                      color: AppColors.mel.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: estaSelecionado
                            ? BorderSide(color: AppColors.terciaria, width: 2)
                            : BorderSide.none,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onLongPress: () => setState(() => selecionados.add(idx)),
                        onTap: () async {
                          if (selecionando) {
                            setState(() {
                              if (estaSelecionado) {
                                selecionados.remove(idx);
                              } else {
                                selecionados.add(idx);
                              }
                            });
                          } else {
                            await openEncryptedUserBox(u.nome);
                            if (context.mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => UsuarioPage(userId: u.nome),
                                ),
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              Icon(Icons.person_rounded, color: cs.onPrimary),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  u.nome,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                    color: cs.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
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

      // Botões flutuantes: busca e ação principal (adicionar ou excluir)
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 4, right: 4, left: 36),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Botão de busca
            FloatingActionButton.extended(
              heroTag: 'buscar',
              onPressed: _toggleBusca,
              icon: Icon(mostrandoBusca ? Icons.close_rounded : Icons.search_rounded),
              label: Text(
                mostrandoBusca ? s.closeButtonTooltip : s.searchButtonText,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: mostrandoBusca ? AppColors.terciaria : AppColors.primaria,
              foregroundColor: AppColors.fundo,
            ),
            const SizedBox(width: 12),
            // Botão de adicionar/excluir
            FloatingActionButton.extended(
              heroTag: 'principal',
              onPressed: selecionando
                  ? _confirmarExcluir
                  : () => showAddUserDialog(
                context: context,
                usuariosBox: usuariosBox,
                onUsuarioCriado: () => setState(() {}),
              ),
              backgroundColor: selecionando ? AppColors.terciaria : cs.secondary,
              foregroundColor: cs.onSecondary,
              icon: Icon(
                selecionando ? Icons.delete_rounded : Icons.add_rounded,
                size: 28,
              ),
              label: Text(
                selecionando ? s.apagar : s.novoPerfil,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.fundo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _buscaCtrl.dispose();
    _buscaFocus.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}