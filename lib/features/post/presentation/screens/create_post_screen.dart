import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/error_utils.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../providers/post_providers.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final contentController = TextEditingController();
  final imagePicker = ImagePicker();
  File? selectedImage;
  bool isLoading = false;

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> createPost() async {
    final content = contentController.text.trim();

    if (content.isEmpty) {
      ErrorUtils.showErrorSnackBar(context, 'Gönderi içeriği boş olamaz');
      return;
    }

    setState(() => isLoading = true);

    try {
      await ref
          .read(postControllerProvider.notifier)
          .createPost(content: content, imageFile: selectedImage);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Gönderi'),
        actions: [
          TextButton(
            onPressed: isLoading ? null : createPost,
            child: const Text('Paylaş'),
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: contentController,
                maxLines: 8,
                maxLength: AppConstants.maxPostLength,
                decoration: const InputDecoration(
                  hintText: 'Ne düşünüyorsun?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              if (selectedImage != null) ...[
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        selectedImage!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              selectedImage = null;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              OutlinedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Fotoğraf Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
