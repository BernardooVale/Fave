import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../ed.dart';
import '../cofre.dart';
import '../usuario/usuario.dart';
import 'novoUsuarioDialog.dart';
import '../cores.dart';

class Selecao extends StatefulWidget {
  const Selecao({super.key});
  @override
  State<Selecao> createState() => _SelecaoState();
}

class _SelecaoState extends State<Selecao> with SingleTickerProviderStateMixin {
  late Box<Usuario> usuariosBox;
  bool loading = true;
  String filtro = '';
  bool mostrandoBusca = false;

  final TextEditingController _buscaCtrl = TextEditingController();
  final FocusNode _buscaFocus = FocusNode();

  final Set<int> selecionados = {};
  bool get selecionando => selecionados.isNotEmpty;

  // Para animar opacidade da lista
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);

    _init();
    _fadeController.forward();
  }

  Future<void> _init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UsuarioAdapter());
    Hive.registerAdapter(PastaAdapter());
    Hive.registerAdapter(SenhaAdapter());

    usuariosBox = await Hive.openBox<Usuario>('usuarios');
    setState(() => loading = false);
  }

  Future<void> _confirmarExcluir() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir usuário(s)'),
        content: Text(
          'Deseja realmente excluir ${selecionados.length} usuário(s)? '
              'Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: AppColors.terciaria)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      final idsOrdenados = selecionados.toList()..sort((a, b) => b.compareTo(a));
      for (final idx in idsOrdenados) {
        await usuariosBox.deleteAt(idx);
      }
      setState(() => selecionados.clear());
    }
  }

  void _toggleBusca() {
    setState(() {
      mostrandoBusca = !mostrandoBusca;
      if (!mostrandoBusca) {
        filtro = '';
        _buscaCtrl.clear();
        _buscaFocus.unfocus();
        _fadeController.forward();
      } else {
        // Abre teclado e foca campo após pequeno delay
        Future.delayed(const Duration(milliseconds: 100),
                () => FocusScope.of(context).requestFocus(_buscaFocus));
      }
    });
  }

  void _onFiltroChanged(String value) {
    setState(() {
      filtro = value.trim();
      // Reinicia animação para fade suave
      _fadeController.reset();
      _fadeController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final usuariosFiltrados = List.generate(
      usuariosBox.length,
          (i) => MapEntry(i, usuariosBox.getAt(i)!),
    ).where((entry) {
      return filtro.isEmpty || entry.value.nome.toLowerCase().contains(filtro.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mel.withOpacity(0.85),
        elevation: 2,
        centerTitle: true,
        title: selecionando
            ? Text('${selecionados.length} selecionado(s)')
            : const Text('Perfis', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: selecionando
            ? IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => setState(() => selecionados.clear()),
        )
            : null,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : usuariosBox.isEmpty
          ? const Center(
        child: Text(
          'Nenhum usuário criado.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : Column(
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
                controller: _buscaCtrl,
                focusNode: _buscaFocus,
                onChanged: _onFiltroChanged,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar perfil...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon:
                  const Icon(Icons.search, color: AppColors.primaria),
                  suffixIcon: filtro.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
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
                : const SizedBox.shrink(
              key: ValueKey('empty'),
            ),
          ),
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 4, right: 4, left: 36),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              heroTag: 'buscar',
              onPressed: _toggleBusca,
              icon: Icon(mostrandoBusca ? Icons.close_rounded : Icons.search_rounded),
              label: Text(
                mostrandoBusca ? 'Fechar' : 'Buscar',
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: mostrandoBusca ? AppColors.terciaria : AppColors.primaria,
              foregroundColor: AppColors.fundo,
            ),
            const SizedBox(width: 12),
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
              icon: Icon(selecionando ? Icons.delete_rounded : Icons.add_rounded, size: 28),
              label: Text(
                selecionando ? 'Apagar' : 'Novo perfil',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.fundo),
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