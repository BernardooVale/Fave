import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../cores.dart';
import '../ed.dart';
import 'fotoCriptografia.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../generated/l10n.dart';

void mostrarFotoAmpliada(BuildContext context, Uint8List foto) {
  final s = S.of(context);

  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.memory(
                foto,
                fit: BoxFit.contain,
              ),
            ),

            // Botão de fechar
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

            // Botão de compartilhar
            Positioned(
              bottom: 40,
              left: 24,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.mel,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.share_rounded, color: AppColors.fundo, size: 32),
                    onPressed: () async {
                      final tempDir = await getTemporaryDirectory();
                      final file = await File('${tempDir.path}/imagem.jpg').create();
                      await file.writeAsBytes(foto);
                      await Share.shareXFiles([XFile(file.path)]);
                    },
                    tooltip: s.compartilhar,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> documentoDialog(BuildContext context, Documento documento) async {
  // 1. Testa descriptografia logo ao abrir
  if (documento.fotosCriptografadas.isNotEmpty) {
    final primeiraFoto = documento.fotosCriptografadas.first;
    try {
      debugPrint('🧪 Teste no init: Tentando descriptografar primeira foto...');
      final descriptografada = await descriptografar(primeiraFoto);
      debugPrint('✅ Sucesso ao descriptografar primeira foto! Tamanho: ${descriptografada.length}');
    } catch (e, stack) {
      debugPrint('❌ Erro ao descriptografar primeira foto no init: $e');
      debugPrint('🔍 Stack: $stack');
    }
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.fundo,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      final s = S.of(context);

      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                documento.nome,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              info(s.numero, documento.numero),

              if (documento.orgaoExpedidor?.isNotEmpty == true)
                ...[const SizedBox(height: 12), info(s.orgao, documento.orgaoExpedidor!)],

              if (documento.dataEmissao != null)
                ...[const SizedBox(height: 12), info(s.dataEmissao, s.dateDisplay(documento.dataEmissao!))],

              if (documento.dataVencimento != null)
                ...[const SizedBox(height: 12), info(s.dataVencimento, s.dateDisplay(documento.dataVencimento!))],

              const SizedBox(height: 24),

              if (documento.fotosCriptografadas.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: documento.fotosCriptografadas.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final fotoCriptografada = documento.fotosCriptografadas[index];
                      debugPrint("📸 fotoCriptografada[$index] hash: ${fotoCriptografada.hashCode}");

                      return FutureBuilder<Uint8List>(
                        future: descriptografar(fotoCriptografada),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primaria,
                              ),
                            );
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            debugPrint('❌ Erro ao descriptografar imagem[$index]: ${snapshot.error}');
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.error_rounded, color: Colors.redAccent, size: 36),
                            );
                          }

                          final foto = snapshot.data!;
                          return GestureDetector(
                            onTap: () => mostrarFotoAmpliada(context, foto),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              clipBehavior: Clip.antiAlias,
                              child: Image.memory(
                                foto,
                                width: 150,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.terciaria,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    s.closeButtonTooltip,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget info(String label, String valor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.secundaria.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          valor,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}