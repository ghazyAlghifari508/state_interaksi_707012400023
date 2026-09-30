// lib/main.dart - Implementasi Modul 3 Bagian E: Materi Praktikum
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // paket Provider
import 'models/keranjang_model.dart'; // model keranjang (ChangeNotifier)
import 'pages/halaman_keranjang.dart';
import 'pages/halaman_produk.dart';
import 'pages/halaman_set_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => KeranjangModel(), // KeranjangModel dibuat sekali di root aplikasi
      child: const AplikasiKantin(),
    ),
  );
}

class AplikasiKantin extends StatelessWidget {
  const AplikasiKantin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const KerangkaUtama(),
    );
  }
}

class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});

  @override
  State<KerangkaUtama> createState() => _KerangkaUtamaState();
}

class _KerangkaUtamaState extends State<KerangkaUtama> {
  int _indeks = 0; // state lokal: tetap pakai setState(), bukan Provider
  static const _halaman = [
    HalamanProduk(),
    HalamanKeranjang(),
  ];

  @override
  Widget build(BuildContext context) {
    // Membaca totalItem dari Provider dengan context.select
    // Rebuild AppBar hanya dipicu saat nilai totalItem berubah
    final totalItem = context.select<KeranjangModel, int>(
      (model) => model.totalItem,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _indeks == 0 ? 'Menu Kantin Kampus' : 'Keranjang Belanja ($totalItem)',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz_rounded),
            tooltip: 'Latihan setState() Babak 1',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HalamanSetState()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        // Menjaga status/state halaman tetap hidup di latar belakang saat berpindah tab
        index: _indeks,
        children: _halaman,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: (nilaiBaru) {
          setState(() {
            // Hanya _indeks yang diperbarui dengan setState lokal
            _indeks = nilaiBaru;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Produk',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: totalItem > 0,
              label: Text('$totalItem'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: totalItem > 0,
              label: Text('$totalItem'),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}
