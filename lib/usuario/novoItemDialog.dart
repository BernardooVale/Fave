import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../usuario/usuario.dart';
import '../ed.dart'; // Pasta e Senha
import '../cores.dart';
import 'senhaAleatoria.dart';

Future<void> showAddOptionDialog({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target, // Usuario ou Pasta
  required VoidCallback onUpdate,
}) async {
  final option = await showDialog<String>(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.fundo,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'O que deseja criar?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.folder, color: AppColors.pasta),
              title: const Text(
                'Criar Pasta',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(context, 'pasta'),
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: AppColors.primaria),
              title: const Text(
                'Criar Senha',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(context, 'senha'),
            ),
            const Divider(color: Colors.white24),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => Navigator.pop(context, null),
                icon: const Icon(Icons.close, color: AppColors.terciaria),
                label: const Text(
                  'Cancelar',
                  style: TextStyle(color: AppColors.terciaria),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  if (option == 'pasta') {
    await showCreateFolderSheet(
      context: context,
      userBox: userBox,
      target: target,
      onUpdate: onUpdate,
    );
  } else if (option == 'senha') {
    await showCreatePasswordSheet(
      context: context,
      userBox: userBox,
      target: target,
      onUpdate: onUpdate,
    );
  }
}

Future<void> addFolder({
  required Box<Usuario> userBox,
  required dynamic target, // Usuario ou Pasta
  required String nome,
  required VoidCallback onUpdate,
}) async {
  final novaPasta = Pasta(
    nome: nome,
    senhas: [],
    subpastas: [],
    ultimaModificacao: DateTime.now(),
  );

  if (target is Usuario) {
    target.pastas ??= [];
    target.pastas!.add(novaPasta);
  } else if (target is Pasta) {
    target.subpastas ??= [];
    target.subpastas!.add(novaPasta);
  } else {
    throw Exception('target deve ser Usuario ou Pasta');
  }

  // Atualiza no Hive
  await userBox.putAt(0, userBox.values.first);
  onUpdate();
}

Future<void> addPassword({
  required Box<Usuario> userBox,
  required dynamic target, // Usuario ou Pasta
  required String nome,
  required String senha,
  required VoidCallback onUpdate,
}) async {
  final novaSenha = Senha(
    nome: nome,
    senha: senha,
    ultimaModificacao: DateTime.now(),
  );

  if (target is Usuario) {
    target.senhas ??= [];
    target.senhas!.add(novaSenha);
  } else if (target is Pasta) {
    target.senhas ??= [];
    target.senhas!.add(novaSenha);
  } else {
    throw Exception('target deve ser Usuario ou Pasta');
  }

  // Atualiza no Hive
  await userBox.putAt(0, userBox.values.first);
  onUpdate();
}

Future<void> showCreateFolderSheet({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.fundo,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nova Pasta',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nomeController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Nome da pasta',
              labelStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: AppColors.pasta.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.pasta, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundaria,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                elevation: 4,
                shadowColor: AppColors.secundaria.withOpacity(0.6),
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              onPressed: () async {
                final nome = nomeController.text.trim();
                if (nome.isEmpty) return;

                await addFolder(
                  userBox: userBox,
                  target: target,
                  nome: nome,
                  onUpdate: onUpdate,
                );
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

Future<void> showCreatePasswordSheet({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();

  double calcularForcaSenha(String senha) {
    double forca = 0;

    final lengthOk = senha.length >= 8;
    final hasLower = senha.contains(RegExp(r'[a-z]'));
    final hasUpper = senha.contains(RegExp(r'[A-Z]'));
    final hasNumber = senha.contains(RegExp(r'[0-9]'));
    final hasSpecial = senha.contains(RegExp(r'[^A-Za-z0-9]'));

    if (lengthOk) forca += 0.2;
    if (hasLower) forca += 0.2;
    if (hasUpper) forca += 0.2;
    if (hasNumber) forca += 0.2;
    if (hasSpecial) forca += 0.2;

    return forca.clamp(0, 1);
  }

  Widget barraForcaSenha(double forca) {
    // Cores do gradiente: vermelho (fraco) para verde (forte)
    final List<Color> cores = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.green,
    ];

    // Índice do gradiente conforme força (0 a 4)
    int idx = (forca * (cores.length - 1)).floor();
    int idxNext = (idx + 1).clamp(0, cores.length - 1);

    // Cor interpolada
    final color = Color.lerp(cores[idx], cores[idxNext], forca * (cores.length - 1) - idx);

    return Container(
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[800],
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: forca, // de 0 a 1
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
          ),
        ),
      ),
    );
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.fundo,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      double forcaSenha = 0;

      return StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nova Senha',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nomeController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nome da senha',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: AppColors.primaria.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primaria, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: AppColors.primaria.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primaria, width: 2),
                  ),
                ),
                onChanged: (senha) {
                  setState(() {
                    forcaSenha = calcularForcaSenha(senha);
                  });
                },
              ),
              const SizedBox(height: 8),
              barraForcaSenha(forcaSenha),
              const SizedBox(height: 28),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.fundo,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) => SenhaAleatoriaPopup(
                          onSenhaGerada: (senha) {
                            // Aqui você recebe a senha gerada e preenche o campo
                            senhaController.text = senha;
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Senha aleatória',
                      style: TextStyle(
                        color: AppColors.terciaria,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secundaria,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      elevation: 4,
                      shadowColor: AppColors.secundaria.withOpacity(0.6),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    onPressed: () async {
                      final nome = nomeController.text.trim();
                      final senha = senhaController.text.trim();
                      if (nome.isEmpty || senha.isEmpty) return;

                      await addPassword(
                        userBox: userBox,
                        target: target,
                        nome: nome,
                        senha: senha,
                        onUpdate: onUpdate,
                      );

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}