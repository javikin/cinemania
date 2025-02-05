import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class CineSearchBar extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;

  const CineSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NeuSearchBar(
      searchController: controller,
      keyboardType: TextInputType.text,
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.black,
      ),
      leadingIcon: const Icon(Icons.search, color: Colors.black),
      searchBarColor: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
