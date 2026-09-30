import 'package:flutter_test/flutter_test.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/ongoing_issues/presentation/providers/ongoing_issue_providers.dart';

void main() {
  group('OngoingIssueFilter', () {
    test('isEmpty is true for default filter', () {
      expect(const OngoingIssueFilter().isEmpty, isTrue);
    });

    test('isEmpty is false when dataCenter is set', () {
      expect(
        const OngoingIssueFilter(dataCenter: DataCenter.india).isEmpty,
        isFalse,
      );
    });

    test('isEmpty is false when product is set', () {
      expect(
        const OngoingIssueFilter(product: 'Zoho CRM').isEmpty,
        isFalse,
      );
    });

    test('copyWith preserves unset fields', () {
      const original = OngoingIssueFilter(
        dataCenter: DataCenter.us,
        product: 'Zoho Books',
      );
      final copy = original.copyWith(product: 'Zoho CRM');
      expect(copy.dataCenter, equals(DataCenter.us));
      expect(copy.product, equals('Zoho CRM'));
    });

    test('copyWith can null out nullable fields using sentinel', () {
      const original = OngoingIssueFilter(
        dataCenter: DataCenter.eu,
        product: 'Zoho Desk',
      );
      final cleared = original.copyWith(dataCenter: null, product: null);
      expect(cleared.dataCenter, isNull);
      expect(cleared.product, isNull);
      expect(cleared.isEmpty, isTrue);
    });

    test('copyWith with no arguments returns equivalent filter', () {
      const original = OngoingIssueFilter(
        dataCenter: DataCenter.au,
        product: 'Zoho Creator',
      );
      final copy = original.copyWith();
      expect(copy.dataCenter, equals(original.dataCenter));
      expect(copy.product, equals(original.product));
    });
  });

  group('OngoingIssueFilterNotifier', () {
    test('setDataCenter updates state', () {
      final notifier = OngoingIssueFilterNotifier();
      notifier.setDataCenter(DataCenter.india);
      expect(notifier.state.dataCenter, equals(DataCenter.india));
      expect(notifier.state.product, isNull);
    });

    test('setProduct updates state', () {
      final notifier = OngoingIssueFilterNotifier();
      notifier.setProduct('Zoho Analytics');
      expect(notifier.state.product, equals('Zoho Analytics'));
      expect(notifier.state.dataCenter, isNull);
    });

    test('reset clears all filters', () {
      final notifier = OngoingIssueFilterNotifier();
      notifier.setDataCenter(DataCenter.eu);
      notifier.setProduct('Zoho Books');
      notifier.reset();
      expect(notifier.state.isEmpty, isTrue);
    });
  });
}
