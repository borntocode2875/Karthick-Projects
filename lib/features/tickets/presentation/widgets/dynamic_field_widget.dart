import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/tickets/domain/dynamic_field.dart';

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/// Renders any [DynamicField] as an interactive form element.
///
/// [value] is the current value (type depends on the field subtype).
/// [onChanged] fires with the new typed value whenever the user edits.
/// [enabled] = false renders every variant in a read-only state.
class DynamicFieldWidget extends StatelessWidget {
  const DynamicFieldWidget({
    required this.field,
    this.value,
    required this.onChanged,
    this.enabled = true,
    super.key,
  });

  final DynamicField field;
  final Object? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  bool get _editable => enabled && !field.isReadOnly;

  @override
  Widget build(BuildContext context) {
    return switch (field) {
      TextDynamicField() => _TextField(
          field: field as TextDynamicField,
          value: value as String?,
          onChanged: onChanged,
          enabled: _editable,
        ),
      LongTextDynamicField() => _LongTextField(
          field: field as LongTextDynamicField,
          value: value as String?,
          onChanged: onChanged,
          enabled: _editable,
        ),
      NumberDynamicField() => _NumberField(
          field: field as NumberDynamicField,
          value: value,
          onChanged: onChanged,
          enabled: _editable,
        ),
      DateDynamicField() => _DateField(
          field: field as DateDynamicField,
          value: value as DateTime?,
          onChanged: onChanged,
          enabled: _editable,
        ),
      DateTimeDynamicField() => _DateTimeField(
          field: field as DateTimeDynamicField,
          value: value as DateTime?,
          onChanged: onChanged,
          enabled: _editable,
        ),
      SingleSelectDynamicField() => _SingleSelectField(
          field: field as SingleSelectDynamicField,
          value: value as String?,
          onChanged: onChanged,
          enabled: _editable,
        ),
      MultiSelectDynamicField() => _MultiSelectField(
          field: field as MultiSelectDynamicField,
          value: value is List<String> ? value as List<String> : const [],
          onChanged: onChanged,
          enabled: _editable,
        ),
      BooleanDynamicField() => _BooleanField(
          field: field as BooleanDynamicField,
          value: value as bool?,
          onChanged: onChanged,
          enabled: _editable,
        ),
      LookupDynamicField() => _LookupField(
          field: field as LookupDynamicField,
          value: value as String?,
          onChanged: onChanged,
          enabled: _editable,
        ),
      AttachmentDynamicField() => _AttachmentField(
          field: field as AttachmentDynamicField,
          enabled: _editable,
        ),
      UnknownDynamicField() => _UnknownField(field: field),
    };
  }
}

// ---------------------------------------------------------------------------
// Helper — required label suffix
// ---------------------------------------------------------------------------

Widget _label(BuildContext context, String text, {bool required = false}) {
  final colors = AppColors.of(context);
  final style = Theme.of(context).textTheme.labelMedium?.copyWith(
        color: colors.textSecondary,
      );
  if (!required) return Text(text, style: style);
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(text, style: style),
      Text(
        ' *',
        style: style?.copyWith(color: colors.danger),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Helper — tappable field shell (date / lookup / single-select fallback)
// ---------------------------------------------------------------------------

class _TapField extends StatelessWidget {
  const _TapField({
    required this.label,
    required this.displayText,
    required this.icon,
    required this.onTap,
    required this.isRequired,
    required this.enabled,
  });

  final String label;
  final String? displayText;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isRequired;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, label, required: isRequired),
        const SizedBox(height: AppSpacing.xs),
        GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm + 2,
            ),
            decoration: BoxDecoration(
              color: enabled ? colors.surface : colors.background,
              border: Border.all(color: colors.line),
              borderRadius: BorderRadius.circular(AppRadii.chip),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayText ?? (isRequired ? 'Select…' : 'None'),
                    style: textTheme.bodyMedium?.copyWith(
                      color: displayText != null
                          ? colors.textPrimary
                          : colors.textTertiary,
                    ),
                  ),
                ),
                Icon(icon, size: 18, color: colors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Text
// ---------------------------------------------------------------------------

class _TextField extends StatefulWidget {
  const _TextField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final TextDynamicField field;
  final String? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(_TextField old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value && widget.value != _ctrl.text) {
      _ctrl.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.field;
    return TextFormField(
      controller: _ctrl,
      enabled: widget.enabled,
      maxLength: f.maxLength,
      decoration: InputDecoration(
        labelText: f.label + (f.isRequired ? ' *' : ''),
        hintText: f.placeholder,
        counterText: f.maxLength != null ? null : '',
      ),
      onChanged: (v) => widget.onChanged(v.isEmpty ? null : v),
      validator: f.isRequired
          ? (v) => (v == null || v.trim().isEmpty) ? '${f.label} is required.' : null
          : null,
    );
  }
}

// ---------------------------------------------------------------------------
// Long text
// ---------------------------------------------------------------------------

class _LongTextField extends StatefulWidget {
  const _LongTextField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final LongTextDynamicField field;
  final String? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  @override
  State<_LongTextField> createState() => _LongTextFieldState();
}

class _LongTextFieldState extends State<_LongTextField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(_LongTextField old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value && widget.value != _ctrl.text) {
      _ctrl.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.field;
    return TextFormField(
      controller: _ctrl,
      enabled: widget.enabled,
      maxLength: f.maxLength,
      maxLines: 4,
      minLines: 3,
      decoration: InputDecoration(
        labelText: f.label + (f.isRequired ? ' *' : ''),
        alignLabelWithHint: true,
      ),
      onChanged: (v) => widget.onChanged(v.isEmpty ? null : v),
      validator: f.isRequired
          ? (v) => (v == null || v.trim().isEmpty) ? '${f.label} is required.' : null
          : null,
    );
  }
}

// ---------------------------------------------------------------------------
// Number
// ---------------------------------------------------------------------------

class _NumberField extends StatefulWidget {
  const _NumberField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final NumberDynamicField field;
  final Object? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  @override
  State<_NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<_NumberField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.value != null ? widget.value.toString() : '',
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String? _validate(String? v) {
    final f = widget.field;
    if (v == null || v.isEmpty) {
      return f.isRequired ? '${f.label} is required.' : null;
    }
    final n = double.tryParse(v);
    if (n == null) return 'Enter a valid number.';
    if (f.minValue != null && n < f.minValue!) {
      return 'Minimum value is ${f.minValue!.toInt()}.';
    }
    if (f.maxValue != null && n > f.maxValue!) {
      return 'Maximum value is ${f.maxValue!.toInt()}.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.field;
    final isDecimal = f.decimalPlaces > 0;
    return TextFormField(
      controller: _ctrl,
      enabled: widget.enabled,
      keyboardType: TextInputType.numberWithOptions(decimal: isDecimal),
      inputFormatters: [
        isDecimal
            ? FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            : FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: f.label + (f.isRequired ? ' *' : ''),
        hintText: _buildHint(f),
      ),
      onChanged: (v) {
        final n = double.tryParse(v);
        widget.onChanged(n);
      },
      validator: _validate,
    );
  }

  String? _buildHint(NumberDynamicField f) {
    if (f.minValue != null && f.maxValue != null) {
      return '${f.minValue!.toInt()} – ${f.maxValue!.toInt()}';
    }
    return null;
  }
}

// ---------------------------------------------------------------------------
// Date
// ---------------------------------------------------------------------------

class _DateField extends StatelessWidget {
  const _DateField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final DateDynamicField field;
  final DateTime? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return _TapField(
      label: field.label,
      displayText: value != null ? _formatDate(value!) : null,
      icon: Icons.calendar_today,
      onTap: () => _pick(context),
      isRequired: field.isRequired,
      enabled: enabled,
    );
  }

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')} ${_monthName(dt.month)} ${dt.year}';

  String _monthName(int m) => const [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ][m];
}

// ---------------------------------------------------------------------------
// DateTime
// ---------------------------------------------------------------------------

class _DateTimeField extends StatelessWidget {
  const _DateTimeField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final DateTimeDynamicField field;
  final DateTime? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: value != null
          ? TimeOfDay.fromDateTime(value!)
          : TimeOfDay.fromDateTime(now),
    );
    if (time == null) return;
    onChanged(DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  @override
  Widget build(BuildContext context) {
    return _TapField(
      label: field.label,
      displayText: value != null ? _formatDt(value!) : null,
      icon: Icons.calendar_today,
      onTap: () => _pick(context),
      isRequired: field.isRequired,
      enabled: enabled,
    );
  }

  String _formatDt(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '$day ${months[dt.month]} ${dt.year}, $h:$min';
  }
}

// ---------------------------------------------------------------------------
// Single select
// ---------------------------------------------------------------------------

class _SingleSelectField extends StatelessWidget {
  const _SingleSelectField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final SingleSelectDynamicField field;
  final String? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  // Use inline chips for ≤4 choices; dropdown sheet otherwise.
  static const _chipThreshold = 4;

  @override
  Widget build(BuildContext context) {
    if (field.choices.length <= _chipThreshold) {
      return _ChipSelect(
        label: field.label,
        choices: field.choices,
        selected: value != null ? {value!} : const {},
        multiSelect: false,
        isRequired: field.isRequired,
        enabled: enabled,
        onChanged: (set) => onChanged(set.isEmpty ? null : set.first),
      );
    }
    return _DropdownSheetField(
      label: field.label,
      choices: field.choices,
      value: value,
      isRequired: field.isRequired,
      enabled: enabled,
      onChanged: (v) => onChanged(v),
    );
  }
}

// ---------------------------------------------------------------------------
// Multi select
// ---------------------------------------------------------------------------

class _MultiSelectField extends StatelessWidget {
  const _MultiSelectField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final MultiSelectDynamicField field;
  final List<String> value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return _ChipSelect(
      label: field.label,
      choices: field.choices,
      selected: Set.of(value),
      multiSelect: true,
      isRequired: field.isRequired,
      enabled: enabled,
      onChanged: (set) => onChanged(set.toList()),
    );
  }
}

// ---------------------------------------------------------------------------
// Chip-based select (shared by single + multi with ≤4 choices)
// ---------------------------------------------------------------------------

class _ChipSelect extends StatelessWidget {
  const _ChipSelect({
    required this.label,
    required this.choices,
    required this.selected,
    required this.multiSelect,
    required this.isRequired,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final List<String> choices;
  final Set<String> selected;
  final bool multiSelect;
  final bool isRequired;
  final bool enabled;
  final ValueChanged<Set<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, label, required: isRequired),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xs,
          children: choices.map((choice) {
            final isSelected = selected.contains(choice);
            return FilterChip(
              label: Text(choice),
              selected: isSelected,
              onSelected: enabled
                  ? (on) {
                      final next = Set.of(selected);
                      if (!multiSelect) next.clear();
                      if (on) {
                        next.add(choice);
                      } else {
                        next.remove(choice);
                      }
                      onChanged(next);
                    }
                  : null,
              showCheckmark: multiSelect,
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Dropdown-sheet (single-select with many choices)
// ---------------------------------------------------------------------------

class _DropdownSheetField extends StatelessWidget {
  const _DropdownSheetField({
    required this.label,
    required this.choices,
    required this.value,
    required this.isRequired,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final List<String> choices;
  final String? value;
  final bool isRequired;
  final bool enabled;
  final ValueChanged<String?> onChanged;

  Future<void> _open(BuildContext context) async {
    final colors = AppColors.of(context);
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _ChoiceSheet(
        title: label,
        choices: choices,
        selected: value,
        colors: colors,
      ),
    );
    onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    return _TapField(
      label: label,
      displayText: value,
      icon: Icons.keyboard_arrow_down,
      onTap: () => _open(context),
      isRequired: isRequired,
      enabled: enabled,
    );
  }
}

class _ChoiceSheet extends StatelessWidget {
  const _ChoiceSheet({
    required this.title,
    required this.choices,
    required this.selected,
    required this.colors,
  });

  final String title;
  final List<String> choices;
  final String? selected;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.base,
              AppSpacing.screenMargin, AppSpacing.sm,
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: choices.length,
              itemBuilder: (_, i) {
                final c = choices[i];
                final isSelected = c == selected;
                return ListTile(
                  title: Text(c),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        )
                      : null,
                  onTap: () => Navigator.of(context).pop(c),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Boolean
// ---------------------------------------------------------------------------

class _BooleanField extends StatelessWidget {
  const _BooleanField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final BooleanDynamicField field;
  final bool? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: SwitchListTile(
        title: Text(
          field.label + (field.isRequired ? ' *' : ''),
          style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
        ),
        value: value ?? false,
        onChanged: enabled ? (v) => onChanged(v) : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Lookup (stub — Phase 1 shows the module name, read-only search field)
// ---------------------------------------------------------------------------

class _LookupField extends StatelessWidget {
  const _LookupField({
    required this.field,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final LookupDynamicField field;
  final String? value;
  final ValueChanged<Object?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return _TapField(
      label: '${field.label} (${field.lookupModule})',
      displayText: value,
      icon: Icons.search,
      onTap: null, // lookup not implemented in Phase 1
      isRequired: field.isRequired,
      enabled: false, // always disabled in Phase 1
    );
  }
}

// ---------------------------------------------------------------------------
// Attachment (stub — full wiring in Milestone 9)
// ---------------------------------------------------------------------------

class _AttachmentField extends StatelessWidget {
  const _AttachmentField({
    required this.field,
    required this.enabled,
  });

  final AttachmentDynamicField field;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, field.label, required: field.isRequired),
        const SizedBox(height: AppSpacing.xs),
        OutlinedButton.icon(
          onPressed: null, // wired in Milestone 9
          icon: Icon(Icons.attach_file, size: 16,
              color: colors.textSecondary),
          label: Text(
            'Attach file',
            style: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Unknown — forwards-compatible read-only stub
// ---------------------------------------------------------------------------

class _UnknownField extends StatelessWidget {
  const _UnknownField({required this.field});

  final DynamicField field;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        labelText: field.label,
        hintText: 'Unsupported field type',
        hintStyle: TextStyle(color: colors.textTertiary),
      ),
    );
  }
}
