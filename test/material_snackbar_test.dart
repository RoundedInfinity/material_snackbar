import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_snackbar/material_snackbar.dart';

void main() {
  const MethodChannel channel = MethodChannel('material_snackbar');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MaterialSnackbar.platformVersion, '42');
  });
}
