import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileEntity profile;
  final bool isOwnProfile;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: profile.avatarUrl != null
                ? CachedNetworkImageProvider(profile.avatarUrl!)
                : null,
            child: profile.avatarUrl == null
                ? Text(
                    profile.username.substring(0, 1).toUpperCase(),
                    style: const TextStyle(fontSize: 32),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            '@${profile.username}',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          if (profile.fullName != null)
            Text(
              profile.fullName!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 8),
          if (profile.bio != null)
            Text(
              profile.bio!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          const SizedBox(height: 16),
          if (isOwnProfile)
            OutlinedButton.icon(
              onPressed: () => context.push('/profile/edit'),
              icon: const Icon(Icons.edit),
              label: const Text('Profili Düzenle'),
            ),
        ],
      ),
    );
  }
}
