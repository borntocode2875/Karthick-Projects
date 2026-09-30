import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabScaffold(
      title: 'Tickets',
      body: const _StubBody(
        icon: PhosphorIconsRegular.ticket,
        label: 'Tickets',
        description: 'Your support tickets will appear here.',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New ticket',
        child: const Icon(PhosphorIconsRegular.plus),
      ),
    );
  }
}

class _StubBody extends StatelessWidget {
  const _StubBody({
    required this.icon,
    required this.label,
    required this.description,
  });

  final IconData icon;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: colors.textTertiary),
          const SizedBox(height: 16),
          Text(
            label,
            style: textTheme.titleMedium?.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
