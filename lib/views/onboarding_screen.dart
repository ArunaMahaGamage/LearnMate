import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../components/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          _Slide(title: 'Offline Learning', desc: 'Download lessons and access them anytime'),
          _Slide(title: 'Study Planner', desc: 'Organize your study schedule easily'),
          _Slide(title: 'Community Q&A', desc: 'Ask questions and get answers'),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(label: 'Get Started', onPressed: () => Navigator.pushReplacementNamed(context, Routes.home)),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String desc;
  const _Slide({required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8), Text(desc)]));
  }
}
