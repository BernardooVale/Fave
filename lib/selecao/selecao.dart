import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../ed.dart';
import '../cofre.dart';
import '../services/migration_service.dart';
import '../usuario/usuario.dart';
import 'novoUsuarioDialog.dart';
import '../cores.dart';
import '../config.dart';
import '../generated/l10n.dart';
import '../widgets/motifs.dart';
import '../widgets/arched_container.dart';

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
    final theme = Theme.of(context);
    final cs = theme.colorScheme; // Cores do tema

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: selecionando
            ? Text(s.selectedItemsCount(selecionados.length))
            : Text(s.perfis, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: selecionando
            ? IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => setState(() => selecionados.clear()),
        )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.brass),
            tooltip: s.config,
            onPressed: _abrirConfiguracoes,
          ),
        ],
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: AzulejoPatternPainter(opacity: 0.02)),
          ),
          usuariosBox.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person_outline_rounded, size: 64, color: AppColors.brass),
                      const SizedBox(height: 16),
                      Text(s.semPerfis, style: const TextStyle(fontSize: 16, color: AppColors.ivory)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: kToolbarHeight + 40),
                    // Campo de busca com estilo Belle Époque
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: mostrandoBusca
                          ? Padding(
                        key: const ValueKey('buscaCampo'),
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                        child: TextField(
                          controller: _buscaCtrl,
                          focusNode: _buscaFocus,
                          onChanged: _onFiltroChanged,
                          style: const TextStyle(color: AppColors.ivory),
                          decoration: InputDecoration(
                            hintText: s.buscarPerfil,
                            hintStyle: const TextStyle(color: Colors.white38),
                            prefixIcon: const Icon(Icons.search_rounded, color: AppColors.brass),
                            filled: true,
                            fillColor: AppColors.wood.withOpacity(0.3),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: AppColors.brass),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: AppColors.brass.withOpacity(0.3)),
                            ),
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),

                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                          itemCount: usuariosFiltrados.length,
                          itemBuilder: (context, i) {
                            final idx = usuariosFiltrados[i].key;
                            final u = usuariosFiltrados[i].value;
                            final estaSelecionado = selecionados.contains(idx);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TweenAnimationBuilder<double>(
                                duration: Duration(milliseconds: 400 + (i * 100)),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value,
                                    child: Transform.translate(
                                      offset: Offset(0, 20 * (1 - value)),
                                      child: child,
                                    ),
                                  );
                                },
                                child: ArchedContainer(
                                  archRadius: 30,
                                  decoration: BoxDecoration(
                                    color: estaSelecionado ? AppColors.brass.withOpacity(0.15) : AppColors.wood.withOpacity(0.4),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: estaSelecionado ? AppColors.brass : AppColors.brass.withOpacity(0.1),
                                      width: estaSelecionado ? 2 : 1,
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
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
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => const Center(child: CircularProgressIndicator(color: AppColors.brass)),
                                          );
                                          
                                          try {
                                            await MigrationService.migrateUser(u.nome);
                                            await openUserCofre(u.nome);
                                          } finally {
                                            if (context.mounted) Navigator.pop(context);
                                          }

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
                                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.brass.withOpacity(0.1),
                                                border: Border.all(color: AppColors.brass.withOpacity(0.2)),
                                              ),
                                              child: const Icon(Icons.person_rounded, color: AppColors.brass, size: 28),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    u.nome,
                                                    style: theme.textTheme.titleMedium?.copyWith(
                                                      color: AppColors.ivory,
                                                      fontSize: 18,
                                                      fontFamily: 'serif',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Perfil Vault',
                                                    style: TextStyle(
                                                      color: AppColors.brass.withOpacity(0.6),
                                                      fontSize: 12,
                                                      letterSpacing: 1.1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (estaSelecionado)
                                              const Icon(Icons.check_circle_rounded, color: AppColors.brass)
                                            else
                                              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.brass.withOpacity(0.3)),
                                          ],
                                        ),
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
        padding: const EdgeInsets.only(bottom: 12, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              heroTag: 'buscar',
              onPressed: _toggleBusca,
              backgroundColor: mostrandoBusca ? AppColors.terciaria : AppColors.wood,
              foregroundColor: AppColors.brass,
              child: Icon(mostrandoBusca ? Icons.close_rounded : Icons.search_rounded),
            ),
            const SizedBox(height: 12),
            FloatingActionButton.extended(
              heroTag: 'principal',
              onPressed: selecionando
                  ? _confirmarExcluir
                  : () => showAddUserDialog(
                context: context,
                usuariosBox: usuariosBox,
                onUsuarioCriado: () => setState(() {}),
              ),
              backgroundColor: selecionando ? AppColors.terciaria : AppColors.mel,
              foregroundColor: selecionando ? Colors.white : Colors.black,
              icon: Icon(selecionando ? Icons.delete_outline_rounded : Icons.add_rounded),
              label: Text(
                selecionando ? s.apagar : s.novoPerfil,
                style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(20),
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