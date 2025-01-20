import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Memanggil fungsi untuk mengambil data produk
  }

  Future<void> fetchProducts() async {
    try {
      final response = await Supabase.instance.client.from('produk').select();

      setState(() {
        products = List<Map<String, dynamic>>.from(response);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching products: $error')),
      );
    }
  }

  Future<void> createProduct(String name, double price, int stock) async {
    try {
      await Supabase.instance.client.from('produk').insert({
        'nama_produk': name,
        'harga': price,
        'stok': stock,
      });
      fetchProducts(); // Refresh data setelah menambahkan produk
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product created successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating product: $error')),
      );
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await Supabase.instance.client.from('produk').delete().eq('produk_id', productId);
      fetchProducts(); // Refresh data setelah penghapusan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting product: $error')),
      );
    }
  }

  void _showCreateProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: _stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Stock'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final String name = _productNameController.text;
                final double price = double.tryParse(_priceController.text) ?? 0;
                final int stock = int.tryParse(_stockController.text) ?? 0;
                if (name.isNotEmpty && price > 0 && stock >= 0) {
                  createProduct(name, price, stock);
                  Navigator.of(context).pop();
                  _productNameController.clear();
                  _priceController.clear();
                  _stockController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid input')), 
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: fetchProducts,
          )
        ],
      ),
      body: 
      
      
      products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    // leading: CircleAvatar(
                    //   backgroundColor: Colors.green[400],
                    //   child: Text(
                    //     product['produk_id'].toString(),
                    //     style: const TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    title: Text(
                      product['nama_produk'] ?? 'No Name',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF00934E)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Harga: ${product['harga'] ?? 'N/A'}',
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: const Color(0xFF00934E)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Stok: ${product['stok'] ?? 'N/A'}',
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue[400]),
                          onPressed: () {
                            // Tambahkan logika edit produk di sini
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[400]),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Product'),
                                  content: const Text(
                                      'Are you sure you want to delete this product?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        deleteProduct(product['produk_id']);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateProductDialog,
        backgroundColor:const Color(0xFF00934E),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
