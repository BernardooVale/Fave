import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../ed.dart';
import '../cofre.dart';
import '../usuario/usuario.dart';
import 'novoUsuarioDialog.dart';

class Selecao extends StatefulWidget {
  const Selecao({super.key});
  @override
  State<Selecao> createState() => _SelecaoState();
}

class _SelecaoState extends State<Selecao> {
  late Box<Usuario> usuariosBox;
  bool loading = true;

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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Usuários"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : usuariosBox.isEmpty
          ? const Center(child: Text('Nenhum usuário criado.'))
          : Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: ListView.builder(
                    reverse: true,
                    itemCount: usuariosBox.length,
                    itemBuilder: (context, i) {
            final u = usuariosBox.getAt(i)!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GestureDetector(
                onTap: () async {
                  await openEncryptedUserBox(u.nome);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UsuarioPage(userId: u.nome),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    u.nome,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
                    },
                  ),
          ),
      floatingActionButton: SizedBox(
        width: 63,
        height: 63,
        child: FloatingActionButton(
          onPressed: () => showAddUserDialog(
            context: context,
            usuariosBox: usuariosBox,
            onUsuarioCriado: () => setState(() {}),
          ),
          backgroundColor: cs.secondary,
          foregroundColor: cs.onSecondary,
          child: const Icon(Icons.add, size: 36),
        ),
      ),
    );
  }
}