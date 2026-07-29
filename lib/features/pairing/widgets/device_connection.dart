import 'package:flutter/material.dart';

class DeviceConnection extends StatelessWidget {
  const DeviceConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _DeviceCard(
            icon: Icons.phone_android_rounded,
            label: 'Mobile',
          ),
        ),

        SizedBox(width: 20),

        _ConnectionIndicator(),

        SizedBox(width: 20),

        Expanded(
          child: _DeviceCard(
            icon: Icons.desktop_windows_rounded,
            label: 'Desktop',
          ),
        ),
      ],
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 40),
        const SizedBox(height: 8),

        Text(label),
      ],
    );
  }
}

class _ConnectionIndicator extends StatelessWidget {
  const _ConnectionIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.circle, size: 8),
        SizedBox(width: 6),

        Icon(Icons.circle, size: 8),
        SizedBox(width: 6),

        Icon(Icons.circle, size: 8),
        SizedBox(width: 6),
      ],
    );
  }
}
