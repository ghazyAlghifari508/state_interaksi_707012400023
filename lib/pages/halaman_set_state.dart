// lib/pages/halaman_set_state.dart
import 'package:flutter/material.dart';

/// Halaman latihan state lokal (ephemeral state) menggunakan setState()
/// Sesuai Bagian E.b dan E.c Modul 3 Praktikum PPBL.
class HalamanSetState extends StatefulWidget {
  const HalamanSetState({super.key});

  @override
  State<HalamanSetState> createState() => _HalamanSetStateState();
}

class _HalamanSetStateState extends State<HalamanSetState> {
  // Variabel state lokal (bersifat privat untuk halaman ini)
  int _jumlahPesanan = 0;
  bool _kantinBuka = true;

  void _tambahPesanan() {
    setState(() {
      _jumlahPesanan++;
    });
  }

  void _kurangiPesanan() {
    if (_jumlahPesanan == 0) return;
    setState(() {
      _jumlahPesanan--;
    });
  }

  void _ubahStatusKantin(bool nilaiBaru) {
    setState(() {
      _kantinBuka = nilaiBaru;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan setState'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Identitas Mahasiswa Telkom University
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.person_pin, color: Colors.teal),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Praktikan: Ghazy Nabil Alghfari (707012400023 - D4SIKC)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Jumlah pesanan hari ini'),
                    const SizedBox(height: 8),
                    Text(
                      '$_jumlahPesanan',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _kurangiPesanan,
                          icon: const Icon(Icons.remove_circle_outline),
                          tooltip: 'Kurangi pesanan',
                        ),
                        const SizedBox(width: 12),
                        FilledButton.icon(
                          onPressed: _tambahPesanan,
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: SwitchListTile(
                title: const Text('Kantin buka'),
                subtitle: Text(
                  _kantinBuka ? 'Menerima pesanan' : 'Sedang tutup',
                ),
                value: _kantinBuka,
                onChanged: _ubahStatusKantin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
