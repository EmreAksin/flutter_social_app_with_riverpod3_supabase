import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorUtils {
  ErrorUtils._();

  static String parseError(dynamic error) {
    if (error is AuthException) {
      return _parseAuthException(error);
    }

    if (error is PostgrestException) {
      return _parsePostgrestException(error);
    }

    if (error is StorageException) {
      return _parseStorageException(error);
    }

    return error.toString();
  }

  static String _parseAuthException(AuthException error) {
    switch (error.message) {
      case 'Invalid login credentials':
        return 'Email veya şifre hatalı';
      case 'Email not confirmed':
        return 'Email adresinizi doğrulayın';
      case 'User already registered':
        return 'Bu email zaten kayıtlı';
      case 'Password should be at least 6 characters':
        return 'Şifre en az 6 karakter olmalı';
      default:
        return error.message;
    }
  }

  static String _parsePostgrestException(PostgrestException error) {
    if (error.code == '23505') {
      if (error.message.contains('username')) {
        return 'Bu kullanıcı adı zaten kullanılıyor';
      }
      return 'Bu kayıt zaten mevcut';
    }

    if (error.code == '23503') {
      return 'İlişkili kayıt bulunamadı';
    }

    return error.message;
  }

  static String _parseStorageException(StorageException error) {
    return 'Dosya yükleme hatası: ${error.message}';
  }

  static void showErrorSnackBar(BuildContext context, dynamic error) {
    final message = parseError(error);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Tamam',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
