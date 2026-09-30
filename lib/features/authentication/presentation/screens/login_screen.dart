import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/accounts/presentation/providers/account_provider.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  DeskAccount? _selectedAccount;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final account = _selectedAccount;
    if (account == null) return;

    await ref.read(sessionProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          account: account,
        );
  }

  String _errorMessage(Object error) {
    if (error is UnauthenticatedError) return 'Incorrect email or password.';
    if (error is NetworkError) return 'No connection. Check your network and try again.';
    if (error is ServerError) return 'Something went wrong on our end. Try again shortly.';
    return 'Sign in failed. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final session = ref.watch(sessionProvider);
    final accounts = ref.watch(accountListProvider);
    final isLoading = session is AsyncLoading;

    final errorMsg = session is AsyncError ? _errorMessage(session.error!) : null;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenMargin,
            vertical: AppSpacing.xxxl,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxxl),
                // Logo / wordmark
                _Logo(colors: colors),
                const SizedBox(height: AppSpacing.xxxxl),

                // Portal selector
                Text(
                  'Select portal',
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                accounts.when(
                  data: (list) => _PortalSelector(
                    accounts: list,
                    selected: _selectedAccount ?? (list.isNotEmpty ? list.first : null),
                    onSelected: (a) => setState(() => _selectedAccount = a),
                  ),
                  loading: () => const _SelectorSkeleton(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      PhosphorIconsRegular.envelope,
                      color: colors.textSecondary,
                      size: 20,
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required.';
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      PhosphorIconsRegular.lock,
                      color: colors.textSecondary,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? PhosphorIconsRegular.eye
                            : PhosphorIconsRegular.eyeSlash,
                        color: colors.textSecondary,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required.';
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                // Error banner
                if (errorMsg != null) ...[
                  _ErrorBanner(message: errorMsg, colors: colors),
                  const SizedBox(height: AppSpacing.base),
                ],

                // Sign in button
                FilledButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Sign in'),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Hint for demo/mock mode
                Text(
                  'Demo mode — any credentials work.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _Logo extends StatelessWidget {
  const _Logo({required this.colors});
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
          alignment: Alignment.center,
          child: const Icon(PhosphorIconsFill.headset, color: Colors.white, size: 28),
        ),
        const SizedBox(height: AppSpacing.base),
        Text(
          'Zoho Support Hub',
          style: textTheme.titleLarge?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Sign in to manage your support tickets',
          style: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PortalSelector extends StatelessWidget {
  const _PortalSelector({
    required this.accounts,
    required this.selected,
    required this.onSelected,
  });

  final List<DeskAccount> accounts;
  final DeskAccount? selected;
  final void Function(DeskAccount) onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: accounts.map((a) {
        final isSelected = a.id == selected?.id;
        return ChoiceChip(
          label: Text(a.portalName),
          selected: isSelected,
          onSelected: (_) => onSelected(a),
          avatar: _AvatarChip(
            initial: a.avatarInitial,
            colorHex: a.avatarColor,
            size: 18,
          ),
          backgroundColor: colors.surface,
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
        );
      }).toList(),
    );
  }
}

class _SelectorSkeleton extends StatelessWidget {
  const _SelectorSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.only(right: AppSpacing.sm),
          child: Container(
            width: 100,
            height: 32,
            decoration: BoxDecoration(
              color: colors.line,
              borderRadius: BorderRadius.circular(AppRadii.chip),
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarChip extends StatelessWidget {
  const _AvatarChip({
    required this.initial,
    required this.colorHex,
    required this.size,
  });

  final String initial;
  final String colorHex;
  final double size;

  Color _parseColor() {
    try {
      final hex = colorHex.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: _parseColor(), shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: size * 0.5,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1,
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.colors});
  final String message;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.danger.withAlpha(20),
        border: Border.all(color: colors.danger.withAlpha(80)),
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: Row(
        children: [
          Icon(PhosphorIconsRegular.warningCircle, color: colors.danger, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.danger,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
