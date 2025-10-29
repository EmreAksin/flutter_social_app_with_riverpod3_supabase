import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  const PasswordStrengthIndicator({super.key, required this.password});

  double _score(String p) {
    if (p.isEmpty) return 0;
    double s = 0;
    if (p.length >= 6) s += 0.25;
    if (p.length >= 10) s += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(p)) s += 0.2;
    if (RegExp(r'[0-9]').hasMatch(p)) s += 0.15;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(p)) s += 0.15;
    return s.clamp(0, 1);
  }

  String _label(double s) {
    if (s < 0.3) return 'Zayıf';
    if (s < 0.6) return 'Orta';
    if (s < 0.85) return 'İyi';
    return 'Güçlü';
  }

  Color _color(double s) {
    if (s < 0.3) return Colors.red;
    if (s < 0.6) return Colors.orange;
    if (s < 0.85) return Colors.amber;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final s = _score(password);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: s,
          backgroundColor: Colors.grey.shade200,
          color: _color(s),
        ),
        const SizedBox(height: 6),
        Text(
          'Şifre Gücü: ${_label(s)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
