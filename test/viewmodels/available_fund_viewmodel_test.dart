import 'package:flutter_test/flutter_test.dart';
import 'package:vsc_acc/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AvailableFundViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
