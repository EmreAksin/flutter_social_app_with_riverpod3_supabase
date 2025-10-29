import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/error_utils.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../providers/auth_providers.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_email_field.dart';
import '../widgets/auth_username_field.dart';
import '../widgets/auth_fullname_field.dart';
import '../widgets/auth_password_field.dart';
import '../widgets/auth_terms_checkbox.dart';
import '../widgets/password_strength_indicator.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool acceptedTerms = false;

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) => ErrorUtils.showErrorSnackBar(context, error),
      );
    });

    final canSubmit = acceptedTerms && !authState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: LoadingOverlay(
        isLoading: authState.isLoading,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AuthHeader(title: 'Kayıt Ol'),
                    const SizedBox(height: 32),
                    AuthEmailField(controller: emailController),
                    const SizedBox(height: 16),
                    AuthUsernameField(controller: usernameController),
                    const SizedBox(height: 16),
                    AuthFullNameField(controller: fullNameController),
                    const SizedBox(height: 16),
                    AuthPasswordField(
                      controller: passwordController,
                      label: 'Şifre',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Şifre gerekli';
                        }
                        if (value.length < AppConstants.minPasswordLength) {
                          return 'Şifre en az ${AppConstants.minPasswordLength} karakter olmalı';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    PasswordStrengthIndicator(
                      password: passwordController.text,
                    ),
                    const SizedBox(height: 16),
                    AuthPasswordField(
                      controller: confirmPasswordController,
                      label: 'Şifre Tekrar',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Şifre tekrarı gerekli';
                        }
                        if (value != passwordController.text) {
                          return 'Şifreler eşleşmiyor';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AuthTermsCheckbox(
                      value: acceptedTerms,
                      onChanged: (v) => setState(() => acceptedTerms = v),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: canSubmit
                          ? () async {
                              if (formKey.currentState!.validate()) {
                                await ref
                                    .read(authControllerProvider.notifier)
                                    .signUp(
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                      username: usernameController.text.trim(),
                                      fullName:
                                          fullNameController.text.trim().isEmpty
                                          ? null
                                          : fullNameController.text.trim(),
                                    );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Kayıt Ol',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Zaten hesabın var mı?'),
                        TextButton(
                          onPressed: () => context.go('/auth/login'),
                          child: const Text('Giriş Yap'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
