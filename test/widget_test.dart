// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:state_interaksi_707012400023/models/keranjang_model.dart';
import 'package:state_interaksi_707012400023/pages/halaman_set_state.dart';
import 'package:state_interaksi_707012400023/main.dart';

void main() {
  testWidgets('Pengujian Babak 1: State Lokal setState() pada HalamanSetState',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HalamanSetState(),
      ),
    );

    // Verifikasi counter awal = 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Menerima pesanan'), findsOneWidget);

    // Tekan tombol Tambah
    await tester.tap(find.widgetWithText(FilledButton, 'Tambah'));
    await tester.pump();

    // Verifikasi nilai bertambah menjadi 1
    expect(find.text('1'), findsOneWidget);

    // Tekan tombol Tambah lagi
    await tester.tap(find.widgetWithText(FilledButton, 'Tambah'));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    // Tekan tombol Kurang
    await tester.tap(find.byIcon(Icons.remove_circle_outline));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    // Ubah Switch status kantin
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.text('Sedang tutup'), findsOneWidget);
  });

  testWidgets(
      'Pengujian Babak 2: State Aplikasi ChangeNotifier & Provider pada AplikasiKantin',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => KeranjangModel(),
        child: const AplikasiKantin(),
      ),
    );

    // Verifikasi berada di halaman produk
    expect(find.text('Menu Kantin Kampus'), findsOneWidget);
    expect(find.text('Nasi Goreng'), findsOneWidget);

    // Tambahkan Nasi Goreng ke keranjang
    final tombolTambah = find.widgetWithText(FilledButton, 'Tambah').first;
    await tester.tap(tombolTambah);
    await tester.pumpAndSettle();

    // Verifikasi snackbar dan judul keranjang di bottom nav / app bar
    expect(find.text('Nasi Goreng ditambahkan ke keranjang!'), findsOneWidget);

    // Pindah ke tab Keranjang
    await tester.tap(find.text('Keranjang'));
    await tester.pumpAndSettle();

    // Verifikasi item tampil di keranjang
    expect(find.text('Keranjang Belanja (1)'), findsOneWidget);
    expect(find.text('1 x Rp15000'), findsOneWidget);
    expect(find.text('Total Pembayaran:'), findsOneWidget);

    // Kosongkan keranjang
    await tester.tap(find.text('Kosongkan Keranjang'));
    await tester.pumpAndSettle();

    // Verifikasi empty state
    expect(find.text('Keranjang masih kosong'), findsOneWidget);
  });
}
