import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProductPage extends StatefulWidget {
  final int productId;
  final String initialName;
  final double initialPrice;
  final int initialStock;

  const EditProductPage({
    super.key,
    required this.productId,
    required this.initialName,
    required this.initialPrice,
    required this.initialStock,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  late TextEditingController _productNameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController(text: widget.initialName);
    _priceController = TextEditingController(text: widget.initialPrice.toString());
    _stockController = TextEditingController(text: widget.initialStock.toString());
  }

  Future<void> _updateProduct() async {
    final String name = _productNameController.text.trim();
    final double? price = double.tryParse(_priceController.text.trim());
    final int? stock = int.tryParse(_stockController.text.trim());

    if (name.isEmpty || price == null || stock == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required and must be valid')),
      );
      return;
    }

    try {
      await supabase.from('produk').update({
        'nama_produk': name,
        'harga': price,
        'stok': stock,
      }).eq('produk_id', widget.productId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')),
      );
      Navigator.of(context).pop(true); // Return success status to previous page
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating product: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: const Color(0xFF00934E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Stock'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00934E),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              child: Text('Update Product', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),),
            ),
          ],
        ),
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
