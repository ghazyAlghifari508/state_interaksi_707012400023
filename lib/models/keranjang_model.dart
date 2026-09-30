// lib/models/keranjang_model.dart
import 'package:flutter/foundation.dart';

/// Data class untuk produk kantin kampus
@immutable
class Produk {
  const Produk({
    required this.nama,
    required this.harga,
    required this.ikon,
  });

  final String nama;
  final int harga;
  final String ikon;
}

/// Representasi item yang ada di dalam keranjang belanja
class ItemKeranjang {
  ItemKeranjang({required this.produk, this.jumlah = 1});

  final Produk produk;
  int jumlah;
}

/// Model state aplikasi untuk keranjang belanja kantin kampus
/// Meng-extend ChangeNotifier agar widget yang berlangganan dapat
/// membangun ulang tampilan saat data keranjang berubah.
class KeranjangModel extends ChangeNotifier {
  final Map<String, ItemKeranjang> _items = {};

  /// Daftar item keranjang yang tidak dapat diubah langsung dari luar
  List<ItemKeranjang> get items => List.unmodifiable(_items.values);

  /// Getter untuk menghitung total kuantitas barang di keranjang
  int get totalItem {
    return _items.values.fold(0, (total, item) => total + item.jumlah);
  }

  /// Getter untuk menghitung total akumulasi harga pesanan
  int get totalHarga {
    return _items.values.fold(
      0,
      (total, item) => total + (item.produk.harga * item.jumlah),
    );
  }

  /// Menambahkan produk ke keranjang
  void tambah(Produk produk) {
    final itemLama = _items[produk.nama];
    if (itemLama == null) {
      _items[produk.nama] = ItemKeranjang(produk: produk);
    } else {
      itemLama.jumlah++;
    }
    notifyListeners();
  }

  /// Mengurangi produk dari keranjang atau menghapusnya jika jumlah = 1
  void kurangi(Produk produk) {
    final itemLama = _items[produk.nama];
    if (itemLama == null) return;
    if (itemLama.jumlah == 1) {
      _items.remove(produk.nama);
    } else {
      itemLama.jumlah--;
    }
    notifyListeners();
  }

  /// Mengosongkan seluruh keranjang belanja
  void kosongkan() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}
