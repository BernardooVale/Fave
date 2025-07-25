import 'package:autenticacao/notificacao/notificacao.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import '../generated/l10n.dart';
import '../ed.dart';
import '../cores.dart';
import 'senhaAleatoria.dart';
import 'fotoCriptografia.dart';

/// Exibe um diálogo para o usuário escolher o que deseja criar: pasta, senha ou documento.
/// Após a escolha, abre o respectivo formulário/modal para criar o item.
///
/// Parâmetros:
/// - [context]: contexto do widget para exibir diálogos e modais.
/// - [userBox]: caixa Hive que armazena os usuários e seus dados.
/// - [target]: alvo onde o novo item será adicionado — pode ser um Usuario ou uma Pasta.
/// - [onUpdate]: callback para atualizar a interface após criação.
Future<void> showAddOptionDialog({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target, // Usuario ou Pasta
  required VoidCallback onUpdate,
}) async {
  final option = await showDialog<String>(
      context: context,
      builder: (context) {
        final s = S.of(context); // Strings internacionalizadas

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

                // Opção de criar pasta
                ListTile(
                  leading: const Icon(Icons.folder_rounded, color: AppColors.pasta),
                  title: Text(s.createFolderOption, style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context, 'pasta'),
                ),

                // Opção de criar senha
                ListTile(
                  leading: const Icon(Icons.vpn_key_rounded, color: AppColors.primaria),
                  title: Text(s.createPasswordOption, style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context, 'senha'),
                ),

                // Opção de criar documento
                ListTile(
                  leading: const Icon(Icons.description_rounded, color: AppColors.secundaria),
                  title: Text(s.createDocumentOption, style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context, 'documento'),
                ),

                const Divider(color: Colors.white24),

                // Botão cancelar
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

  // Após a escolha, chama o respectivo formulário/modal de criação
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
  } else if (option == 'documento') {
    await showCreateDocumentSheet(
      context: context,
      userBox: userBox,
      target: target,
      onUpdate: onUpdate,
    );
  }
}

/// Função que cria uma nova pasta e adiciona na lista correta do [target].
/// Atualiza o armazenamento Hive e chama [onUpdate] para refletir mudanças na UI.
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

  // Salva alteração no Hive (atualiza primeiro usuário)
  await userBox.putAt(0, userBox.values.first);
  onUpdate();
}

/// Função que cria uma nova senha e adiciona na lista correta do [target].
/// Atualiza o armazenamento Hive e chama [onUpdate] para refletir mudanças na UI.
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

  await userBox.putAt(0, userBox.values.first);
  onUpdate();
}

/// Função que cria um novo documento e adiciona na lista correta do [target].
/// Atualiza o armazenamento Hive e chama [onUpdate] para refletir mudanças na UI.
Future<void> addDocument({
  required Box<Usuario> userBox,
  required dynamic target,
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
    ultimaModificacao: DateTime.now(),
    fotosCriptografadas: fotosCriptografadas,
  );

  if (target is Usuario) {
    target.documentos ??= [];
    target.documentos!.add(novoDocumento);
  } else if (target is Pasta) {
    target.documentos ??= [];
    target.documentos!.add(novoDocumento);
  }

  await userBox.putAt(0, userBox.values.first);
  onUpdate();
}

/// Exibe um modal bottom sheet para o usuário criar uma nova pasta.
///
/// Parâmetros:
/// - [context]: contexto do widget para exibir o modal.
/// - [userBox]: caixa Hive para armazenar e atualizar o usuário.
/// - [target]: alvo onde a pasta será adicionada (pode ser Usuario ou Pasta).
/// - [onUpdate]: callback para atualizar a UI após criação.
///
/// Funcionalidade:
/// - Mostra um TextField para o nome da pasta.
/// - Valida se o nome não está vazio; caso contrário, mostra notificação.
/// - Ao salvar, chama a função addFolder para adicionar a pasta e atualiza a UI.
/// - Fecha o modal após salvar.
Future<void> showCreateFolderSheet({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();

  await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // para modal usar toda altura necessária
      backgroundColor: AppColors.fundo,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final s = S.of(context);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(), // fecha teclado ao clicar fora
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20, // evita teclado sobre texto
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

                // Campo para nome da pasta
                TextField(
                  controller: nomeController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: s.folderNameLabel,
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.pasta.withOpacity(0.1),
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

                // Botão salvar
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
                        return; // não prossegue se nome vazio
                      }

                      mostrarNotificacao(
                        context: context,
                        mensagem: s.folderCreatedNotification,
                        background: AppColors.secundaria,
                      );

                      // Adiciona a nova pasta e atualiza UI
                      await addFolder(
                        userBox: userBox,
                        target: target,
                        nome: nome,
                        onUpdate: onUpdate,
                      );
                      Navigator.pop(context); // fecha modal
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

/// Exibe um modal bottom sheet para criar uma nova senha com validação e força de senha.
///
/// Parâmetros:
/// - [context], [userBox], [target], [onUpdate]: como em showCreateFolderSheet.
///
/// Funcionalidades adicionais:
/// - Calcula a força da senha baseada em critérios (tamanho, caracteres especiais, etc).
/// - Exibe uma barra de força de senha com gradiente colorido.
/// - Permite gerar senha aleatória via popup.
/// - Valida nome e senha não vazios antes de salvar.
/// - Notifica o usuário ao salvar com sucesso.
///
/// Detalhes importantes:
/// - Usa StatefulBuilder para controlar estado interno (força da senha) dentro do modal.
/// - Atualiza a barra toda vez que o usuário altera a senha.
Future<void> showCreatePasswordSheet({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();

  // Função para calcular força da senha (0 a 1)
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

  // Widget que mostra barra de força da senha com gradiente de cores
  Widget barraForcaSenha(double forca) {
    final List<Color> cores = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.green,
    ];

    int idx = (forca * (cores.length - 1)).floor();
    int idxNext = (idx + 1).clamp(0, cores.length - 1);

    final color = Color.lerp(cores[idx], cores[idxNext], forca * (cores.length - 1) - idx);

    return Container(
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[800],
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: forca, // percentual da barra preenchida
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
      final s = S.of(context);

      return StatefulBuilder(
        builder: (context, setState) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(), // fecha teclado ao clicar fora
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

                // Campo nome da senha
                TextField(
                  controller: nomeController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: s.passwordNameLabel,
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

                // Campo senha com obscureText
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: s.passwordLabel,
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

                // Barra visual da força da senha
                barraForcaSenha(forcaSenha),
                const SizedBox(height: 28),

                Row(
                  children: [
                    // Botão para gerar senha aleatória
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
                              senhaController.text = senha;
                            },
                          ),
                        );
                      },
                      child: Text(
                        s.randomPasswordText,
                        style: TextStyle(
                          color: AppColors.mel,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Botão salvar
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
                      child: Text(
                        s.saveButtonText,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      onPressed: () async {
                        final nome = nomeController.text.trim();
                        final senha = senhaController.text.trim();

                        // Valida nome
                        if (nome.isEmpty) {
                          mostrarNotificacao(
                              context: context,
                              mensagem: s.writeANameNotification,
                              background: AppColors.terciaria
                          );
                          return;
                        }

                        // Valida senha
                        if (senha.isEmpty) {
                          mostrarNotificacao(
                              context: context,
                              mensagem: s.writeAPasswordNotification,
                              background: AppColors.terciaria
                          );
                          return;
                        }

                        mostrarNotificacao(
                            context: context,
                            mensagem: s.passwordRegisteredNotification,
                            background: AppColors.secundaria
                        );

                        // Adiciona senha e atualiza UI
                        await addPassword(
                          userBox: userBox,
                          target: target,
                          nome: nome,
                          senha: senha,
                          onUpdate: onUpdate,
                        );

                        Navigator.pop(context); // fecha modal
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

            // Botão Fechar - canto inferior direito
            Positioned(
              bottom: 40,
              right: 24,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.mel,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close_rounded, color: AppColors.fundo, size: 36),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: s.closeButtonTooltip,
                  ),
                ),
              ),
            ),

            // Botão Remover - canto inferior esquerdo
            Positioned(
              bottom: 40,
              left: 24,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.terciaria,
                    shape: BoxShape.circle,
                  ),
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
                    tooltip: s.removePhotoButtonTooltip,
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
  required Box<Usuario> userBox,
  required dynamic target,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  final orgaoController = TextEditingController();

  DateTime? dataEmissao;
  DateTime? dataVencimento;

  final fotosNotifier = ValueNotifier<List<Uint8List>>([]); // imagens sem criptografia
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
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
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
                    labelText: s.documentNameLabel,
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.secundaria.withOpacity(0.1),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
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
                    fillColor: AppColors.secundaria.withOpacity(0.1),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
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
                    fillColor: AppColors.secundaria.withOpacity(0.1),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => dataEmissao = picked);
                      },
                      child: Text(
                        dataEmissao != null
                            ? s.issueDateDisplay(
                          dataEmissao!.day,
                          dataEmissao!.month,
                          dataEmissao!.year,
                        )
                            : s.issueDateLabel,
                        style: TextStyle(color: dataEmissao != null ? Colors.white : AppColors.primaria),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    TextButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => dataVencimento = picked);
                      },
                      child: Text(
                        dataVencimento != null
                            ? s.expirationDateDisplay(
                          dataVencimento!.day,
                          dataVencimento!.month,
                          dataVencimento!.year,
                        )
                            : s.expirationDateLabel,
                        style: TextStyle(color: dataVencimento != null ? Colors.white : AppColors.primaria),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: ValueListenableBuilder<List<Uint8List>>(
                    valueListenable: fotosNotifier,
                    builder: (context, fotos, _) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: ValueListenableBuilder<Set<int>>(
                              valueListenable: selectedIndices,
                              builder: (context, selected, _) {
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: fotos.length + 1,
                                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return GestureDetector(
                                        onTap: () async {
                                          await adicionarFotos();
                                          setState(() {}); // Atualiza UI
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                color: Colors.white10,
                                              ),
                                              child: const Icon(Icons.camera_alt_rounded, color: Colors.white54),
                                            ),
                                            Text(s.addPhotosText, style: TextStyle(color: Colors.white54, fontSize: 12)),
                                          ],
                                        ),
                                      );
                                    } else {
                                      final foto = fotos[index - 1];
                                      final isSelected = selected.contains(index - 1);
                                      return GestureDetector(
                                        onTap: () {
                                          if (selected.isNotEmpty) {
                                            selectedIndices.value = Set.of(selected)..remove(index - 1);
                                          } else {
                                            mostrarFotoAmpliada(context, foto, index - 1, fotosNotifier, () => setState(() {}));
                                          }
                                        },
                                        onLongPress: () {
                                          selectedIndices.value = Set.of(selected)..add(index - 1);
                                        },
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: Image.memory(
                                                foto,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                                color: isSelected ? Colors.black.withOpacity(0.4) : null,
                                                colorBlendMode: isSelected ? BlendMode.darken : null,
                                              ),
                                            ),
                                            if (isSelected)
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: Icon(Icons.check_circle_rounded, color: AppColors.primaria, size: 20),
                                              ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secundaria,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: Text(
                      s.saveButtonText,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      final nome = nomeController.text.trim();
                      final numero = numeroController.text.trim();
                      final orgao = orgaoController.text.trim();

                      if (nome.isEmpty) {
                        mostrarNotificacao(
                            context: context,
                            mensagem: s.writeANameNotification,
                            background: AppColors.terciaria);
                        return;
                      }

                      if (numero.isEmpty) {
                        mostrarNotificacao(
                            context: context,
                            mensagem: s.escrevaNumeroNotificacao,
                            background: AppColors.terciaria);
                        return;
                      }

                      mostrarNotificacao(
                          context: context,
                          mensagem: s.documentoCadastrado,
                          background: AppColors.secundaria);

                      // Aqui criptografa todas as fotos antes de salvar:
                      final fotosCriptografadas = <Uint8List>[];
                      for (var foto in fotosNotifier.value) {
                        final criptografada = await criptografar(foto);
                        fotosCriptografadas.add(criptografada);
                      }

                      await addDocument(
                        userBox: userBox,
                        target: target,
                        nome: nome,
                        numero: numero,
                        dataEmissao: dataEmissao,
                        dataVencimento: dataVencimento,
                        orgaoExpedidor: orgao.isNotEmpty ? orgao : null,
                        onUpdate: onUpdate,
                        fotosCriptografadas: fotosCriptografadas,
                      );

                      await userBox.putAt(0, userBox.values.first);
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