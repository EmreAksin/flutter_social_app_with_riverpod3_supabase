import 'package:flutter/material.dart';

class AuthFullNameField extends StatelessWidget {
  final TextEditingController controller;
  const AuthFullNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'İsim Soyisim (Opsiyonel)',
        prefixIcon: Icon(Icons.badge),
        border: OutlineInputBorder(),
      ),
    );
  }
}
