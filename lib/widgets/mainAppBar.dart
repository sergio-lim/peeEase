import 'package:flutter/material.dart';
import '../src/settings/settings_view.dart';

PreferredSizeWidget mainAppBar(BuildContext context) {
  return AppBar(
    title: const Text(
      'PeeEase',
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.settings_rounded,
        ),
        onPressed: () {
          Navigator.restorablePushNamed(context, SettingsView.routeName);
        },
      ),
    ],
  );
}
