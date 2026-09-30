/// Sealed hierarchy of portal-defined ticket field types.
///
/// Widgets render via a [DynamicFieldWidget] registry that switches on this
/// hierarchy. [UnknownField] renders read-only and never crashes.
sealed class DynamicField {
  const DynamicField({
    required this.key,
    required this.label,
    this.isRequired = false,
    this.isReadOnly = false,
  });

  final String key;
  final String label;
  final bool isRequired;
  final bool isReadOnly;
}

final class TextDynamicField extends DynamicField {
  const TextDynamicField({
    required super.key,
    required super.label,
    super.isRequired,
    super.isReadOnly,
    this.maxLength,
    this.placeholder,
  });

  final int? maxLength;
  final String? placeholder;
}

final class LongTextDynamicField extends DynamicField {
  const LongTextDynamicField({
    required super.key,
    required super.label,
    super.isRequired,
    super.isReadOnly,
    this.maxLength,
  });

  final int? maxLength;
}

final class NumberDynamicField extends DynamicField {
  const NumberDynamicField({
    required super.key,
    required super.label,
    super.isRequired,
    super.isReadOnly,
    this.minValue,
    this.maxValue,
    this.decimalPlaces = 0,
  });

  final double? minValue;
  final double? maxValue;
  final int decimalPlaces;
}

final class DateDynamicField extends DynamicField {
  const DateDynamicField({
    required super.key,
    required super.label,
    super.isRequired,
    super.isReadOnly,
  });
}

final class DateTimeDynamicField extends DynamicField {
  const DateTimeDynamicField({
    required super.key,
    required super.label,
    super.isRequired,
    super.isReadOnly,
  });
}

final class SingleSelectDynamicField extends DynamicField {
  const SingleSelectDynamicField({
    required super.key,
    required super.label,
    required this.choices,
    super.isRequired,
    super.isReadOnly,
  });

  final List<String> choices;
}

final class MultiSelectDynamicField extends DynamicField {
  const MultiSelectDynamicField({
    required super.key,
    required super.label,
    required this.choices,
    super.isRequired,
    super.isReadOnly,
  });

  final List<String> choices;
}

final class BooleanDynamicField extends DynamicField {
  const BooleanDynamicField({
    required super.key,
    required super.label,
    super.isRequired,
    super.isReadOnly,
  });
}

final class LookupDynamicField extends DynamicField {
  const LookupDynamicField({
    required super.key,
    required super.label,
    required this.lookupModule,
    super.isRequired,
    super.isReadOnly,
  });

  final String lookupModule;
}

final class AttachmentDynamicField extends DynamicField {
  const AttachmentDynamicField({
    required super.key,
    required super.label,
    super.isRequired,
    super.isReadOnly,
    this.allowedExtensions = const [],
    this.maxFileSizeBytes,
    this.maxFiles,
  });

  /// Empty list means all extensions are allowed.
  final List<String> allowedExtensions;
  final int? maxFileSizeBytes;
  final int? maxFiles;
}

/// Fallback for field types not recognised by this app version.
///
/// Always renders read-only and never throws — forwards compatibility.
final class UnknownDynamicField extends DynamicField {
  const UnknownDynamicField({
    required super.key,
    required super.label,
    this.rawType,
  }) : super(isReadOnly: true);

  final String? rawType;
}
