import 'package:flutter/material.dart';

class TraitDetailPage extends StatefulWidget {
  const TraitDetailPage({super.key});

  @override
  State<TraitDetailPage> createState() => _TraitDetailPageState();
}

class _TraitDetailPageState extends State<TraitDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trait Detail'),
        leading: const SizedBox(),
      ),
    );
  }
}
