// lib/pages/halaman_keranjang.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keranjang_model.dart';

/// Halaman keranjang belanja kantin kampus
/// Menggunakan `Consumer<KeranjangModel>` agar antarmuka hanya me-rebuild
/// bagian di dalam builder ketika state KeranjangModel diperbarui (via notifyListeners).
class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  String rupiah(int nilai) {
    return 'Rp${nilai.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KeranjangModel>(
      builder: (context, keranjang, child) {
        // Tampilan status kosong (Empty State)
        if (keranjang.items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text(
                  'Keranjang masih kosong',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        // Tampilan daftar pesanan jika keranjang terisi
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: keranjang.items.length,
                separatorBuilder: (context, indeks) => const Divider(),
                itemBuilder: (context, indeks) {
                  final item = keranjang.items[indeks];
                  return ListTile(
                    leading: Text(
                      item.produk.ikon,
                      style: const TextStyle(fontSize: 28),
                    ),
                    title: Text(
                      item.produk.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${item.jumlah} x ${rupiah(item.produk.harga)}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => keranjang.kurangi(item.produk),
                          icon: const Icon(Icons.remove_circle_outline),
                          tooltip: 'Kurangi item',
                        ),
                        Text(
                          '${item.jumlah}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        IconButton(
                          onPressed: () => keranjang.tambah(item.produk),
                          icon: const Icon(Icons.add_circle_outline),
                          tooltip: 'Tambah item',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Pembayaran:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          rupiah(keranjang.totalHarga),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade800,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: keranjang.kosongkan,
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      label: const Text(
                        'Kosongkan Keranjang',
                        style: TextStyle(color: Colors.red),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
