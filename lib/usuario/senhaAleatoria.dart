import 'package:flutter/material.dart';
import '../cores.dart';
import 'dart:math';

class SenhaAleatoriaPopup extends StatefulWidget {
  final void Function(String senha) onSenhaGerada;

  const SenhaAleatoriaPopup({Key? key, required this.onSenhaGerada}) : super(key: key);

  @override
  State<SenhaAleatoriaPopup> createState() => _SenhaAleatoriaPopupState();
}

class _SenhaAleatoriaPopupState extends State<SenhaAleatoriaPopup> {
  String senha = '';
  int tamanho = 12;

  bool usarMinusculas = true;
  bool usarMaiusculas = true;
  bool usarNumeros = true;
  bool usarEspeciais = true;

  final especiais = '!@#\$%';

  @override
  void initState() {
    super.initState();
    gerarSenha();
  }

  void gerarSenha() {
    const letrasMinusculas = 'abcdefghijklmnopqrstuvwxyz';
    const letrasMaiusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numeros = '0123456789';

    String chars = '';
    if (usarMinusculas) chars += letrasMinusculas;
    if (usarMaiusculas) chars += letrasMaiusculas;
    if (usarNumeros) chars += numeros;
    if (usarEspeciais) chars += especiais;

    if (chars.isEmpty) {
      // Se nada selecionado, limpa a senha
      setState(() => senha = '');
      return;
    }

    final rnd = Random.secure();
    final novaSenha = List.generate(tamanho, (_) => chars[rnd.nextInt(chars.length)]).join();

    setState(() {
      senha = novaSenha;
    });
  }

  double calcularForcaSenha(String senha) {
    double forca = 0;

    final lengthOk = senha.length >= 8;
    final hasLower = senha.contains(RegExp(r'[a-z]'));
    final hasUpper = senha.contains(RegExp(r'[A-Z]'));
    final hasNumber = senha.contains(RegExp(r'[0-9]'));
    final hasSpecial = senha.contains(RegExp(r'[!@#$%]')); // só esses caracteres especiais

    if (lengthOk) forca += 0.2;
    if (hasLower) forca += 0.2;
    if (hasUpper) forca += 0.2;
    if (hasNumber) forca += 0.2;
    if (hasSpecial) forca += 0.2;

    return forca.clamp(0, 1);
  }

  Color corForcaSenha(double forca) {
    // Gradiente verde (fraco) -> amarelo (médio) -> vermelho (forte)
    if (forca <= 0.4) return Colors.red;
    if (forca <= 0.7) return Colors.amber;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final forca = calcularForcaSenha(senha);
    final corBarra = corForcaSenha(forca);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Senha Aleatória',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Campo com a senha gerada (só leitura)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primaria.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                senha,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Barra de força da senha
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                minHeight: 14,
                value: forca,
                backgroundColor: Colors.white.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation<Color>(corBarra),
              ),
            ),

            const SizedBox(height: 24),

            // Linha do texto "Tamanho" + slider + campo numérico
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tamanho',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Slider(
                    min: 1,
                    max: 50,
                    divisions: 49,
                    value: tamanho.toDouble(),
                    activeColor: AppColors.secundaria,
                    inactiveColor: Colors.white24,
                    label: tamanho.toString(),
                    onChanged: (v) {
                      setState(() {
                        tamanho = v.round();
                        gerarSenha();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: TextEditingController(text: tamanho.toString()),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      filled: true,
                      fillColor: AppColors.primaria.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (val) {
                      final novoTamanho = int.tryParse(val);
                      if (novoTamanho != null && novoTamanho >= 1 && novoTamanho <= 50) {
                        setState(() {
                          tamanho = novoTamanho;
                          gerarSenha();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Checkboxes
            CheckboxListTile(
              title: const Text('Letras minúsculas', style: TextStyle(color: Colors.white)),
              value: usarMinusculas,
              activeColor: AppColors.secundaria,
              onChanged: (v) {
                setState(() {
                  usarMinusculas = v ?? false;
                  gerarSenha();
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Letras maiúsculas', style: TextStyle(color: Colors.white)),
              value: usarMaiusculas,
              activeColor: AppColors.secundaria,
              onChanged: (v) {
                setState(() {
                  usarMaiusculas = v ?? false;
                  gerarSenha();
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Números', style: TextStyle(color: Colors.white)),
              value: usarNumeros,
              activeColor: AppColors.secundaria,
              onChanged: (v) {
                setState(() {
                  usarNumeros = v ?? false;
                  gerarSenha();
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Caracteres especiais (!@#\$%)', style: TextStyle(color: Colors.white)),
              value: usarEspeciais,
              activeColor: AppColors.secundaria,
              onChanged: (v) {
                setState(() {
                  usarEspeciais = v ?? false;
                  gerarSenha();
                });
              },
            ),

            const SizedBox(height: 24),

            // Botões Cancelar e Confirmar
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.terciaria),
                      foregroundColor: AppColors.terciaria,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secundaria,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: AppColors.secundaria.withOpacity(0.6),
                    ),
                    onPressed: () {
                      if (senha.isNotEmpty) {
                        widget.onSenhaGerada(senha);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}