import 'package:autenticacao/notificacao/notificacao.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import '../generated/l10n.dart';
import '../ed.dart';
import '../cores.dart';
import '../cofre.dart';
import 'senhaAleatoria.dart';
import 'fotoCriptografia.dart';

/// Exibe um diálogo para o usuário escolher o que deseja criar: pasta, senha ou documento.
Future<void> showAddOptionDialog({
  required BuildContext context,
  required String? parentPastaId,
  required UserCofre cofre,
  required VoidCallback onUpdate,
}) async {
  final option = await showDialog<String>(
      context: context,
      builder: (context) {
        final s = S.of(context);

        return Dialog(
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
                  s.whatDoYouWantToCreateTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),

                ListTile(
                  leading: const Icon(Icons.folder_rounded, color: AppColors.pasta),
                  title: Text(s.createFolderOption, style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context, 'pasta'),
                ),

                ListTile(
                  leading: const Icon(Icons.vpn_key_rounded, color: AppColors.azulejo),
                  title: Text(s.createPasswordOption, style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context, 'senha'),
                ),

                ListTile(
                  leading: const Icon(Icons.description_rounded, color: AppColors.botanical),
                  title: Text(s.createDocumentOption, style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context, 'documento'),
                ),

                const Divider(color: Colors.white24),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context, null),
                    icon: const Icon(Icons.close_rounded, color: AppColors.terciaria),
                    label: Text(s.cancelButtonText, style: const TextStyle(color: AppColors.terciaria)),
                  ),
                ),
              ],
            ),
          ),
        );
      }
  );

  if (option == 'pasta') {
    await showCreateFolderSheet(
      context: context,
      parentPastaId: parentPastaId,
      cofre: cofre,
      onUpdate: onUpdate,
    );
  } else if (option == 'senha') {
    await showCreatePasswordSheet(
      context: context,
      parentPastaId: parentPastaId,
      cofre: cofre,
      onUpdate: onUpdate,
    );
  } else if (option == 'documento') {
    await showCreateDocumentSheet(
      context: context,
      parentPastaId: parentPastaId,
      cofre: cofre,
      onUpdate: onUpdate,
    );
  }
}

Future<void> addFolder({
  required UserCofre cofre,
  required String? parentPastaId,
  required String nome,
  required VoidCallback onUpdate,
}) async {
  final novaPasta = Pasta(
    nome: nome,
    parentPastaId: parentPastaId,
  );

  await cofre.pastas.put(novaPasta.id, novaPasta);
  onUpdate();
}

Future<void> addPassword({
  required UserCofre cofre,
  required String? parentPastaId,
  required String nome,
  required String senha,
  required VoidCallback onUpdate,
}) async {
  final novaSenha = Senha(
    nome: nome,
    senha: senha,
    parentPastaId: parentPastaId,
  );

  await cofre.senhas.put(novaSenha.id, novaSenha);
  onUpdate();
}

Future<void> addDocument({
  required UserCofre cofre,
  required String? parentPastaId,
  required String nome,
  required String numero,
  required DateTime? dataEmissao,
  required DateTime? dataVencimento,
  required String? orgaoExpedidor,
  required List<Uint8List> fotosCriptografadas,
  required VoidCallback onUpdate,
}) async {
  final novoDocumento = Documento(
    nome: nome,
    numero: numero,
    dataEmissao: dataEmissao,
    dataVencimento: dataVencimento,
    orgaoExpedidor: orgaoExpedidor,
    parentPastaId: parentPastaId,
  );

  // Salva fotos na box separada
  if (fotosCriptografadas.isNotEmpty) {
    await cofre.fotos.put(novoDocumento.id, fotosCriptografadas);
  }

  await cofre.documentos.put(novoDocumento.id, novoDocumento);
  onUpdate();
}

Future<void> showCreateFolderSheet({
  required BuildContext context,
  required String? parentPastaId,
  required UserCofre cofre,
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
      builder: (context) {
        final s = S.of(context);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
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
                  s.newFolderTitle,
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
                    labelText: s.folderNameLabel,
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.pasta.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.pasta, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pasta,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      elevation: 4,
                      shadowColor: AppColors.pasta.withOpacity(0.6),
                    ),
                    child: Text(
                      s.saveButtonText,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    onPressed: () async {
                      final nome = nomeController.text.trim();

                      if (nome.isEmpty) {
                        mostrarNotificacao(
                          context: context,
                          mensagem: s.writeANameNotification,
                          background: AppColors.terciaria,
                        );
                        return;
                      }

                      mostrarNotificacao(
                        context: context,
                        mensagem: s.folderCreatedNotification,
                        background: AppColors.pasta,
                      );

                      await addFolder(
                        cofre: cofre,
                        parentPastaId: parentPastaId,
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
  );
}

Future<void> showCreatePasswordSheet({
  required BuildContext context,
  required String? parentPastaId,
  required UserCofre cofre,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();

  double calcularForcaSenha(String senha) {
    double forca = 0;
    if (senha.length >= 8) forca += 0.2;
    if (senha.contains(RegExp(r'[a-z]'))) forca += 0.2;
    if (senha.contains(RegExp(r'[A-Z]'))) forca += 0.2;
    if (senha.contains(RegExp(r'[0-9]'))) forca += 0.2;
    if (senha.contains(RegExp(r'[^A-Za-z0-9]'))) forca += 0.2;
    return forca.clamp(0, 1);
  }

  Widget barraForcaSenha(double forca) {
    final List<Color> cores = [Colors.red, Colors.orange, Colors.yellow, Colors.lightGreen, Colors.green];
    int idx = (forca * (cores.length - 1)).floor();
    int idxNext = (idx + 1).clamp(0, cores.length - 1);
    final color = Color.lerp(cores[idx], cores[idxNext], forca * (cores.length - 1) - idx);

    return Container(
      height: 8,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey[800]),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: forca,
        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: color)),
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
      final s = S.of(context);

      return StatefulBuilder(
        builder: (context, setState) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
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
                  s.newPasswordTitle,
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
                    labelText: s.passwordNameLabel,
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.azulejo.withOpacity(0.15),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.azulejo, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: senhaController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: s.passwordLabel,
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.azulejo.withOpacity(0.15),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.azulejo, width: 2),
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
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                          builder: (context) => SenhaAleatoriaPopup(
                            onSenhaGerada: (senha) {
                              senhaController.text = senha;
                            },
                          ),
                        );
                      },
                      child: Text(
                        s.randomPasswordText,
                        style: TextStyle(color: AppColors.azulejo, fontWeight: FontWeight.w600),
                      ),
                    ),

                    const Spacer(),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.azulejo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      ),
                      child: Text(
                        s.saveButtonText,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      onPressed: () async {
                        final nome = nomeController.text.trim();
                        final senha = senhaController.text.trim();

                        if (nome.isEmpty) {
                          mostrarNotificacao(context: context, mensagem: s.writeANameNotification, background: AppColors.terciaria);
                          return;
                        }
                        if (senha.isEmpty) {
                          mostrarNotificacao(context: context, mensagem: s.writeAPasswordNotification, background: AppColors.terciaria);
                          return;
                        }

                        mostrarNotificacao(context: context, mensagem: s.passwordRegisteredNotification, background: AppColors.azulejo);

                        await addPassword(
                          cofre: cofre,
                          parentPastaId: parentPastaId,
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
        ),
      );
    },
  );
}

void mostrarFotoAmpliada(
    BuildContext context,
    Uint8List foto,
    int fotoIndex,
    ValueNotifier<List<Uint8List>> fotosNotifier,
    VoidCallback atualizaUI,
    ) {
  showDialog(
    context: context,
    builder: (context) {
      final s = S.of(context);

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.memory(
                foto,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            Positioned(
              bottom: 40,
              right: 24,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(color: AppColors.mel, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.close_rounded, color: AppColors.fundo, size: 36),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 40,
              left: 24,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(color: AppColors.terciaria, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.delete_rounded, color: Colors.white, size: 36),
                    onPressed: () {
                      final novaLista = List<Uint8List>.from(fotosNotifier.value);
                      if (fotoIndex >= 0 && fotoIndex < novaLista.length) {
                        novaLista.removeAt(fotoIndex);
                        fotosNotifier.value = novaLista;
                        atualizaUI();
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> showCreateDocumentSheet({
  required BuildContext context,
  required String? parentPastaId,
  required UserCofre cofre,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  final orgaoController = TextEditingController();

  DateTime? dataEmissao;
  DateTime? dataVencimento;

  final fotosNotifier = ValueNotifier<List<Uint8List>>([]);
  final selectedIndices = ValueNotifier<Set<int>>({});
  final picker = ImagePicker();

  Future<void> adicionarFotos() async {
    final List<XFile>? imagens = await picker.pickMultiImage(imageQuality: 80);
    if (imagens == null || imagens.isEmpty) return;

    final novasFotos = <Uint8List>[];
    for (final img in imagens) {
      final bytes = await img.readAsBytes();
      novasFotos.add(bytes);
    }
    fotosNotifier.value = [...fotosNotifier.value, ...novasFotos];
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.fundo,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        final s = S.of(context);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
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
                  s.newDocumentTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nomeController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: s.documentNameLabel,
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.botanical.withOpacity(0.15),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.botanical, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: numeroController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: s.documentNumberLabel,
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.botanical.withOpacity(0.15),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.botanical, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: orgaoController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: s.issuingBodyLabel,
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.botanical.withOpacity(0.15),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.botanical, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                        if (picked != null) setState(() => dataEmissao = picked);
                      },
                      child: Text(dataEmissao != null ? s.dateDisplay(dataEmissao!) : s.issueDateLabel, style: TextStyle(color: dataEmissao != null ? Colors.white : AppColors.botanical)),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                        if (picked != null) setState(() => dataVencimento = picked);
                      },
                      child: Text(dataVencimento != null ? s.dateDisplay(dataVencimento!) : s.expirationDateLabel, style: TextStyle(color: dataVencimento != null ? Colors.white : AppColors.botanical)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: ValueListenableBuilder<List<Uint8List>>(
                    valueListenable: fotosNotifier,
                    builder: (context, fotos, _) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: fotos.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () async {
                                await adicionarFotos();
                                setState(() {});
                              },
                              child: Container(width: 80, height: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white10), child: const Icon(Icons.camera_alt_rounded, color: Colors.white54)),
                            );
                          } else {
                            final foto = fotos[index - 1];
                            return GestureDetector(
                              onTap: () => mostrarFotoAmpliada(context, foto, index - 1, fotosNotifier, () => setState(() {})),
                              child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.memory(foto, width: 80, height: 80, fit: BoxFit.cover)),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.botanical, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                    child: Text(s.saveButtonText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final nome = nomeController.text.trim();
                      final numero = numeroController.text.trim();
                      final orgao = orgaoController.text.trim();

                      if (nome.isEmpty || numero.isEmpty) {
                        mostrarNotificacao(context: context, mensagem: s.writeANameNotification, background: AppColors.terciaria);
                        return;
                      }

                      final fotosCriptografadas = <Uint8List>[];
                      for (var foto in fotosNotifier.value) {
                        final criptografada = await criptografar(foto);
                        fotosCriptografadas.add(criptografada);
                      }

                      await addDocument(
                        cofre: cofre,
                        parentPastaId: parentPastaId,
                        nome: nome,
                        numero: numero,
                        dataEmissao: dataEmissao,
                        dataVencimento: dataVencimento,
                        orgaoExpedidor: orgao.isNotEmpty ? orgao : null,
                        fotosCriptografadas: fotosCriptografadas,
                        onUpdate: onUpdate,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    ),
  );
}
