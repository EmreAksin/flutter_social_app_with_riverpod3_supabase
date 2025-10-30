import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/error_utils.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/profile_providers.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final bioController = TextEditingController();
  final imagePicker = ImagePicker();

  File? selectedAvatar;
  bool isLoading = false;
  bool isInitialized = false;

  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> pickAvatar() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        selectedAvatar = File(pickedFile.path);
      });
    }
  }

  Future<void> saveProfile() async {
    final username = usernameController.text.trim();
    final fullName = fullNameController.text.trim();
    final bio = bioController.text.trim();

    if (username.isEmpty) {
      ErrorUtils.showErrorSnackBar(context, 'Kullanıcı adı boş olamaz');
      return;
    }

    if (username.length < AppConstants.minUsernameLength ||
        username.length > AppConstants.maxUsernameLength) {
      ErrorUtils.showErrorSnackBar(
        context,
        'Kullanıcı adı ${AppConstants.minUsernameLength}-${AppConstants.maxUsernameLength} karakter arası olmalı',
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      if (selectedAvatar != null) {
        await ref
            .read(profileControllerProvider.notifier)
            .uploadAvatar(selectedAvatar!);
      }

      await ref
          .read(profileControllerProvider.notifier)
          .updateProfile(
            username: username,
            fullName: fullName.isEmpty ? null : fullName,
            bio: bio.isEmpty ? null : bio,
          );

      ref.invalidate(currentUserProfileProvider);
      final currentUser = ref.read(currentUserProvider).value;
      if (currentUser != null) {
        ref.invalidate(profileProvider(currentUser.id));
      }

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, e);
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(currentUserProfileProvider);

    if (!isInitialized && profileAsync.hasValue && profileAsync.value != null) {
      final profile = profileAsync.value!;
      usernameController.text = profile.username;
      fullNameController.text = profile.fullName ?? '';
      bioController.text = profile.bio ?? '';
      isInitialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profili Düzenle'),
        actions: [
          TextButton(
            onPressed: isLoading ? null : saveProfile,
            child: const Text('Kaydet'),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          return LoadingOverlay(
            isLoading: isLoading,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: selectedAvatar != null
                              ? FileImage(selectedAvatar!)
                              : (profile.avatarUrl != null
                                    ? NetworkImage(profile.avatarUrl!)
                                          as ImageProvider
                                    : null),
                          child:
                              (selectedAvatar == null &&
                                  profile.avatarUrl == null)
                              ? Text(
                                  profile.username
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(fontSize: 40),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              onPressed: pickAvatar,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      helperText: '3-30 karakter arası',
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'İsim Soyisim (Opsiyonel)',
                      prefixIcon: Icon(Icons.badge),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: bioController,
                    maxLines: 4,
                    maxLength: 160,
                    decoration: const InputDecoration(
                      labelText: 'Hakkında (Opsiyonel)',
                      prefixIcon: Icon(Icons.info_outline),
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) =>
            Center(child: Text('Profil yüklenemedi: $error')),
      ),
    );
  }
}
