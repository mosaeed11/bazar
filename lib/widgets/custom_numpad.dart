import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:flutter/material.dart';

class CustomNumpad extends StatelessWidget {
  const CustomNumpad({required this.onKeyTap, this.showDot = false, super.key});

  final ValueChanged<String> onKeyTap;
  final bool showDot;

  static const String backspaceKey = 'backspace';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final row in _rows) ...[
            Row(
              children: [
                for (final key in row) ...[
                  Expanded(
                    child: _NumpadKey(
                      label: key,
                      onTap: () => onKeyTap(key),
                    ),
                  ),
                  if (key != row.last) const SizedBox(width: 10),
                ],
              ],
            ),
            if (row != _rows.last) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  List<List<String>> get _rows => [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    [if (showDot) '.', '0', backspaceKey],
  ];
}

class _NumpadKey extends StatelessWidget {
  const _NumpadKey({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox(height: 60);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 60,
        child: Center(
          child: label == CustomNumpad.backspaceKey
              ? const Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                  size: 26,
                )
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}