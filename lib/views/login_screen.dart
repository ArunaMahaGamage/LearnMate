import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/routes.dart';
import '../viewmodels/auth_provider.dart';
import '../components/custom_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: authState.when(
          data: (user) {
            if (user != null) {
              Future.microtask(() => Navigator.pushReplacementNamed(context, Routes.onboarding));
              return const SizedBox.shrink();
            }
            return CustomButton(
              label: 'Continue (Anonymous)',
              onPressed: () => ref.read(authControllerProvider).signInAnonymously(),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Error: $e'),
        ),
      ),
    );
  }
}
