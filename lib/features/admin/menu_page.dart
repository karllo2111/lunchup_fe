import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../core/services/product_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<List<Product>> future;

  @override
  void initState() {
    super.initState();
    future = ProductService.getProducts();
  }

  void refresh() {
    setState(() {
      future = ProductService.getProducts();
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void openForm({Product? product}) {
    final name = TextEditingController(text: product?.name);
    final desc = TextEditingController(text: product?.description);
    final price = TextEditingController(text: product?.price);
    final stock = TextEditingController(text: product?.stock.toString());
    final category = TextEditingController(text: product?.category);

    String? nameErr, priceErr, stockErr, catErr;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(product == null ? "Tambah Menu" : "Edit Menu"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Nama",
                    errorText: nameErr,
                  ),
                  onChanged: (v) => setDialogState(() => nameErr = null),
                ),
                TextField(
                  controller: desc,
                  decoration: const InputDecoration(labelText: "Deskripsi"),
                ),
                TextField(
                  controller: price,
                  decoration: InputDecoration(
                    labelText: "Harga",
                    errorText: priceErr,
                    hintText: "Contoh: 15000",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => setDialogState(() => priceErr = null),
                ),
                TextField(
                  controller: stock,
                  decoration: InputDecoration(
                    labelText: "Stock",
                    errorText: stockErr,
                    hintText: "Contoh: 10",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => setDialogState(() => stockErr = null),
                ),
                TextField(
                  controller: category,
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    errorText: catErr,
                  ),
                  onChanged: (v) => setDialogState(() => catErr = null),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                // Custom Validation Logic
                bool isValid = true;
                setDialogState(() {
                  if (name.text.trim().isEmpty) {
                    nameErr = "Nama tidak boleh kosong";
                    isValid = false;
                  }
                  if (category.text.trim().isEmpty) {
                    catErr = "Kategori tidak boleh kosong";
                    isValid = false;
                  }

                  // Numeric check for price
                  if (price.text.trim().isEmpty) {
                    priceErr = "Harga tidak boleh kosong";
                    isValid = false;
                  } else if (double.tryParse(price.text) == null) {
                    priceErr = "Harga harus berupa angka (contoh: 15000)";
                    isValid = false;
                  }

                  // Numeric check for stock
                  if (stock.text.trim().isEmpty) {
                    stockErr = "Stock tidak boleh kosong";
                    isValid = false;
                  } else if (int.tryParse(stock.text) == null) {
                    stockErr = "Stock harus berupa angka bulat (contoh: 10)";
                    isValid = false;
                  }
                });

                if (!isValid) return;

                try {
                  if (product == null) {
                    await ProductService.addProduct(
                      name: name.text,
                      description: desc.text,
                      price: price.text,
                      stock: stock.text,
                      category: category.text,
                    );
                  } else {
                    await ProductService.updateProduct(product.id, {
                      "name": name.text,
                      "description": desc.text,
                      "price": price.text,
                      "stock": stock.text,
                      "category": category.text,
                    });
                  }
                  if (!mounted) return;
                  Navigator.pop(context);
                  _showSnackBar(
                    product == null
                        ? "Produk berhasil ditambahkan"
                        : "Produk berhasil diupdate",
                  );
                  refresh();
                } catch (e) {
                  _showSnackBar("Gagal menyimpan: $e", isError: true);
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(Product product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Menu"),
        content: Text("Yakin ingin menghapus \"${product.name}\"?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await ProductService.deleteProduct(product.id);
      _showSnackBar("Produk \"${product.name}\" berhasil dihapus");
      refresh();
    } catch (e) {
      _showSnackBar("Gagal menghapus: $e", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Admin")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => openForm(),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Product>>(
        future: future,
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    "Gagal memuat data",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      snap.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: refresh,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Coba Lagi"),
                  ),
                ],
              ),
            );
          }

          final data = snap.data!;

          if (data.isEmpty) {
            return const Center(
              child: Text("Belum ada menu. Tap + untuk menambah."),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              final p = data[i];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(p.name),
                  subtitle: Text("Rp ${p.price} | Stock ${p.stock}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => openForm(product: p),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(p),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
