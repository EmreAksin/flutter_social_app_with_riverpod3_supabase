import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class AuthUsernameField extends StatelessWidget {
  final TextEditingController controller;
  const AuthUsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Kullanıcı Adı',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
        helperText: '3-30 karakter arası',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Kullanıcı adı gerekli';
        if (value.length < AppConstants.minUsernameLength) {
          return 'En az ${AppConstants.minUsernameLength} karakter olmalı';
        }
        if (value.length > AppConstants.maxUsernameLength) {
          return 'En fazla ${AppConstants.maxUsernameLength} karakter olmalı';
        }
        if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
          return 'Sadece harf, rakam ve _ kullanılabilir';
        }
        return null;
      },
    );
  }
}
