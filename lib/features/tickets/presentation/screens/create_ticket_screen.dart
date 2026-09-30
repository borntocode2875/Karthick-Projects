import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/tickets/domain/create_ticket_input.dart';
import 'package:zoho_support_hub/features/tickets/domain/dynamic_field.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/portal_config_provider.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/ticket_list_provider.dart';
import 'package:zoho_support_hub/features/tickets/presentation/widgets/dynamic_field_widget.dart';
import 'package:zoho_support_hub/features/tickets/presentation/widgets/ticket_status_badge.dart';

class CreateTicketScreen extends ConsumerStatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  ConsumerState<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends ConsumerState<CreateTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  var _priority = TicketPriority.medium;
  String? _product;
  String? _category;
  final _customValues = <String, Object?>{};
  final _attachments = <_SimAttachment>[];
  var _submitting = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final portalConfig = ref.watch(portalConfigProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'New Ticket',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: _submitting
                ? const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : FilledButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
                  ),
          ),
        ],
      ),
      body: portalConfig.when(
        data: (config) => _buildForm(context, config),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Could not load portal configuration.',
            style: TextStyle(color: AppColors.of(context).textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, dynamic config) {
    final products = (config?.products as List<String>?) ?? const <String>[];
    final categories =
        (config?.categories as Map<String, List<String>>?) ?? const {};
    final productCategories =
        _product != null ? (categories[_product] ?? const <String>[]) : const <String>[];
    final dynamicFields =
        (config?.createTicketFields as List<DynamicField>?) ?? const <DynamicField>[];

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenMargin),
        children: [
          // Subject
          const _SectionLabel('Subject'),
          TextFormField(
            controller: _subjectController,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Subject is required' : null,
            decoration: _inputDecoration('Enter a brief subject'),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: AppSpacing.base),

          // Description
          const _SectionLabel('Description'),
          TextFormField(
            controller: _descriptionController,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Description is required' : null,
            decoration: _inputDecoration('Describe your issue in detail…'),
            minLines: 4,
            maxLines: 10,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: AppSpacing.base),

          // Priority
          const _SectionLabel('Priority'),
          Wrap(
            spacing: AppSpacing.xs,
            children: TicketPriority.values.map((p) {
              final selected = _priority == p;
              return ChoiceChip(
                label: Text(p.displayLabel),
                selected: selected,
                onSelected: (_) => setState(() => _priority = p),
                avatar: selected
                    ? null
                    : PriorityIndicator(p.barCount, size: 12),
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.base),

          // Product
          if (products.isNotEmpty) ...[
            const _SectionLabel('Product'),
            DropdownButtonFormField<String?>(
              value: _product,
              decoration: _inputDecoration('Select product (optional)'),
              items: [
                const DropdownMenuItem<String?>(
                    value: null, child: Text('— None —')),
                ...products.map(
                  (p) => DropdownMenuItem<String?>(value: p, child: Text(p)),
                ),
              ],
              onChanged: (v) => setState(() {
                _product = v;
                _category = null;
              }),
            ),
            const SizedBox(height: AppSpacing.base),
          ],

          // Category
          if (_product != null && productCategories.isNotEmpty) ...[
            const _SectionLabel('Category'),
            DropdownButtonFormField<String?>(
              value: _category,
              decoration: _inputDecoration('Select category (optional)'),
              items: [
                const DropdownMenuItem<String?>(
                    value: null, child: Text('— None —')),
                ...productCategories.map(
                  (c) => DropdownMenuItem<String?>(value: c, child: Text(c)),
                ),
              ],
              onChanged: (v) => setState(() => _category = v),
            ),
            const SizedBox(height: AppSpacing.base),
          ],

          // Dynamic portal fields
          ...dynamicFields
              .where((f) => !f.isReadOnly)
              .map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.base),
                    child: DynamicFieldWidget(
                      field: f,
                      value: _customValues[f.key],
                      onChanged: (v) =>
                          setState(() => _customValues[f.key] = v),
                    ),
                  )),

          // Attachments
          const _SectionLabel('Attachments'),
          ..._attachments.map(
            (a) => _AttachmentRow(
              attachment: a,
              onRemove: () => setState(() => _attachments.remove(a)),
            ),
          ),
          OutlinedButton.icon(
            onPressed: _addAttachment,
            icon: const Icon(Icons.attach_file, size: 16),
            label: const Text('Add attachment (simulated)'),
          ),

          const SizedBox(height: AppSpacing.xxxxl),
        ],
      ),
    );
  }

  void _addAttachment() {
    const names = [
      'document.pdf',
      'screenshot.png',
      'report.xlsx',
      'logs.txt',
      'image.jpg',
    ];
    final name = names[_attachments.length % names.length];
    setState(() => _attachments.add(_SimAttachment(
          name: name,
          fakeId: 'att_${DateTime.now().millisecondsSinceEpoch}',
        )));
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final ctx = ref.read(currentContextProvider);
    if (ctx == null) return;

    setState(() => _submitting = true);
    try {
      final input = CreateTicketInput(
        subject: _subjectController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _priority,
        product: _product,
        category: _category,
        customFieldValues: Map.unmodifiable(_customValues),
        attachmentIds: _attachments.map((a) => a.fakeId).toList(),
      );
      await ref
          .read(ticketRepositoryProvider)
          .createTicket(context: ctx, input: input);
      ref.invalidate(ticketListProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ticket created successfully.')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not create ticket: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  static InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      );
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

class _SimAttachment {
  const _SimAttachment({required this.name, required this.fakeId});
  final String name;
  final String fakeId;
}

class _AttachmentRow extends StatelessWidget {
  const _AttachmentRow({required this.attachment, required this.onRemove});
  final _SimAttachment attachment;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ExcludeSemantics(
        child: Icon(Icons.attach_file,
            size: 18, color: colors.textSecondary),
      ),
      title: Text(
        attachment.name,
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textPrimary),
      ),
      trailing: IconButton(
        icon: Icon(Icons.close, size: 16, color: colors.textSecondary),
        onPressed: onRemove,
        tooltip: 'Remove ${attachment.name}',
      ),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.of(context).textSecondary,
            ),
      ),
    );
  }
}
