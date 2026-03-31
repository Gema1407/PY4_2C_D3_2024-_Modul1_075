import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:logbook_app_075/counter_controller.dart';

void main() {
  group('Modul 1 - CounterController Test', () {
    late CounterController controller;

    setUp(() {
      // (1) setup (arrange, build) dijalankan sebelum setiap test
      controller = CounterController();
    });

    // TC01: Initial value should be 0
    test('TC01: initial value should be 0', () {
      // (2) exercise & (3) verify
      expect(controller.value, 0);
    });

    // TC02: setStep should change step value
    test('TC02: setStep should change step value', () {
      controller.setStep(5);
      expect(controller.step, 5);
    });

    // TC03: setStep should ignore negative value
    // (Note: Ini sengaja dibuat sesuai Test Case. Kemungkinan akan FAIL karena di kodemu belum ada validasi pencegah angka negatif)
    test('TC03: setStep should ignore negative value', () {
      controller.setStep(3); // Set awal
      controller.setStep(-1); // Set negatif
      expect(controller.step, 3, reason: 'Step tidak boleh negatif');
    });

    // TC04: increment should increase counter by step value
    test('TC04: increment should increase counter by step value', () {
      controller.setStep(2);
      controller.increment();
      expect(controller.value, 2);
    });

    // TC05: decrement should decrease counter when counter is greater than step
    test(
      'TC05: decrement should decrease counter when counter is greater than step',
      () {
        controller.setStep(3);
        controller.increment(); // value jadi 3
        controller.setStep(1);
        controller.decrement(); // 3 - 1 = 2
        expect(controller.value, 2);
      },
    );

    // TC06: decrement should not drop counter below zero
    test('TC06: decrement should not drop counter below zero', () {
      controller.setStep(2);
      controller.increment(); // value jadi 2
      controller.setStep(5);
      controller.decrement(); // 2 - 5 harusnya mentok di 0
      expect(controller.value, 0);
    });

    // TC08: activityLogs should record increment action correctly
    test('TC08: activityLogs should record increment action correctly', () {
      controller.setStep(4);
      controller.increment();
      expect(controller.activityLogs.isNotEmpty, true);
      expect(
        controller.activityLogs.last.contains('menambahkan nilai sebesar 4'),
        true,
      );
    });

    // TC09: activityLogs should record normal decrement action
    test('TC09: activityLogs should record normal decrement action', () {
      controller.setStep(5);
      controller.increment();
      controller.setStep(2);
      controller.decrement();
      expect(
        controller.activityLogs.last.contains('mengurangi nilai sebesar 2'),
        true,
      );
    });

    // TC10: activityLogs should record exact reduced value when decrement below zero
    test(
      'TC10: activityLogs should record exact reduced value when decrementing below zero',
      () {
        controller.setStep(3);
        controller.increment(); // value 3
        controller.setStep(5);
        controller
            .decrement(); // value 3 - step 5. Log harus nyatat "mengurangi 3", bukan "mengurangi 5".
        expect(
          controller.activityLogs.last.contains('mengurangi nilai sebesar 3'),
          true,
        );
      },
    );
  });

  // TC07: reset (Membutuhkan WidgetTester karena fungsi reset milikmu menggunakan BuildContext / AlertDialog)
  testWidgets('TC07: reset should set counter to zero and show dialog', (
    WidgetTester tester,
  ) async {
    final controller = CounterController();
    controller.setStep(5);
    controller.increment(); // counter jadi 5

    // Buat widget simulasi karena kita butuh BuildContext untuk showDialog
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () => controller.reset(context),
              child: const Text('Reset'),
            );
          },
        ),
      ),
    );

    // Tekan tombol pancingan untuk memanggil fungsi reset(context)
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle(); // Tunggu animasi pop-up dialog selesai

    // Tekan tombol 'Ya, Reset' di dalam pop-up AlertDialog
    await tester.tap(find.text('Ya, Reset'));
    await tester.pumpAndSettle();

    // Verifikasi ekspektasi akhir
    expect(controller.value, 0);
    expect(
      controller.activityLogs.last.contains('mereset nilai menjadi 0'),
      true,
    );
  });
}
