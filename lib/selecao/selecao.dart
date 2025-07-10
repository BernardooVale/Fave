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

class _SelecaoState extends State<Selecao> {
  late Box<Usuario> usuariosBox;
  bool loading = true;

  final Set<int> selecionados = {};
  bool get selecionando => selecionados.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _init();
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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
          : Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ListView.builder(
          reverse: true,
          itemCount: usuariosBox.length,
          itemBuilder: (context, i) {
            final u = usuariosBox.getAt(i)!;
            final estaSelecionado = selecionados.contains(i);

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
                  onLongPress: () => setState(() => selecionados.add(i)),
                  onTap: () async {
                    if (selecionando) {
                      setState(() {
                        if (estaSelecionado) {
                          selecionados.remove(i);
                        } else {
                          selecionados.add(i);
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
                        Icon(Icons.person, color: cs.onPrimary),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            u.nome,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
      floatingActionButton: FloatingActionButton.extended(
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
          selecionando ? Icons.delete : Icons.add,
          size: 28,
        ),
        label: Text(
          selecionando ? 'Apagar' : 'Novo perfil',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}