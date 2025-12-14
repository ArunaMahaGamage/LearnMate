import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Provider to access current Firebase user
final firebaseUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(firebaseUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: userAsync.when(
          data: (user) {
            if (user == null) {
              return const Center(child: Text('No user logged in'));
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile photo
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : const AssetImage('assets/default_avatar.png')
                    as ImageProvider,
                  ),
                  const SizedBox(height: 20),

                  // User name
                  Text(
                    user.displayName ?? 'Unknown User',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),

                  // Email address
                  Text(
                    user.email ?? 'No email available',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
          ),
        ),
      ),
    );
  }
}

