import 'package:flutter/material.dart';
import '../cores.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onPressed;

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
        style: ElevatedButton.styleFrom(
          backgroundColor: active ? AppColors.mel : Colors.grey,
          foregroundColor: AppColors.fundo,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: active ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
          children: [
            active
                ? Icon(Icons.filter_list_rounded, size: 20)  // Altere o ícone conforme necessário
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
