import 'package:flutter/material.dart';
import '../cores.dart';

/// Botão customizado para filtros, com visual diferente quando ativo.
///
/// Recebe o [label] para exibir o texto, [active] para definir o estado visual,
/// e [onPressed] para ação ao clicar.
class FilterButton extends StatelessWidget {
  final String label;        // Texto exibido no botão
  final bool active;         // Indica se o filtro está ativo (destacado)
  final VoidCallback onPressed; // Callback executado ao clicar no botão

  const FilterButton({
    super.key,
    required this.label,
    required this.active,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 55,
      width: 100,
      child: ElevatedButton(
        // Estilo do botão: cor de fundo depende se está ativo ou não
        style: ElevatedButton.styleFrom(
          backgroundColor: active ? AppColors.mel : Colors.grey, // cor principal se ativo, cinza se inativo
          foregroundColor: AppColors.fundo,                       // cor do texto e ícone
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // cantos arredondados
          padding: EdgeInsets.zero,                               // padding interno zero para controle preciso
        ),
        onPressed: onPressed,
        child: Row(
          // Alinhamento do conteúdo depende do estado ativo:
          // se ativo, espaço igual para ícone e texto; senão centraliza texto
          mainAxisAlignment: active ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
          children: [
            // Exibe o ícone do filtro só se estiver ativo, senão espaço vazio para alinhamento
            active
                ? Icon(Icons.filter_list_rounded, size: 20)
                : SizedBox(),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}