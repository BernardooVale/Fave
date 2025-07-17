import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../cores.dart';
import '../ed.dart';
import 'fotoCriptografia.dart';

void mostrarFotoAmpliada(BuildContext context, Uint8List foto) {
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
                    icon: const Icon(Icons.close_rounded, color: AppColors.fundo, size: 36),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Fechar',
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
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.fundo,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título (maior, negrito)
            Text(
              documento.nome,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Número
            info('Número', documento.numero),

            // Órgão Expedidor
            if (documento.orgaoExpedidor != null && documento.orgaoExpedidor!.isNotEmpty) ...[
              const SizedBox(height: 12),
              info('Órgão', documento.orgaoExpedidor!),
            ],

            // Data de emissão
            if (documento.dataEmissao != null) ...[
              const SizedBox(height: 12),
              info('Data de emissão', _formatarData(documento.dataEmissao!)),
            ],

            // Data de vencimento
            if (documento.dataVencimento != null) ...[
              const SizedBox(height: 12),
              info('Data de vencimento', _formatarData(documento.dataVencimento!)),
            ],

            const SizedBox(height: 24),

            // Fotos
            if (documento.fotosCriptografadas.isNotEmpty) ...[
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: documento.fotosCriptografadas.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final fotoCriptografada = documento.fotosCriptografadas[index];
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
                            child: const CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaria),
                          );
                        } else if (snapshot.hasError || !snapshot.hasData) {
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
            ],

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
                child: const Text(
                  'Fechar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
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

String _formatarData(DateTime data) {
  return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
}