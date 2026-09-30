import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';

class ZiaScreen extends StatelessWidget {
  const ZiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return TabScaffold(
      title: 'Zia',
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.ziaGradientStart.withValues(alpha: 0.06),
              colors.background,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    colors.ziaGradientStart,
                    colors.ziaGradientEnd,
                  ],
                ).createShader(bounds),
                child: const Icon(
                  PhosphorIconsFill.sparkle,
                  size: 56,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Ask Zia',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.textPrimary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Check ticket status, report issues, and more.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
