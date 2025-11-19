import 'package:flutter/material.dart';
import 'package:chukgoods_mobile/screens/product_list.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _thumbnailController = TextEditingController();
  final _categoryController = TextEditingController();
  bool _isFeatured = false;

  // Category options matching Django backend
  final List<String> categories = [
    'apparel',
    'footwear', 
    'accessories',
    'equipment',
    'fan gear',
  ];

  // URL validation regex
  final RegExp _urlRegex = RegExp(
    r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final request = context.read<CookieRequest>();

    if (!request.loggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to create products'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      // Prepare the product data for Django API
      final productData = {
        'name': _nameController.text.trim(),
        'price': double.parse(_priceController.text),
        'description': _descriptionController.text.trim(),
        'thumbnail': _thumbnailController.text.trim(),
        'category': _categoryController.text,
        'is_featured': _isFeatured,
      };

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF2563eb),
          ),
        ),
      );

      // Send POST request to Django create-flutter endpoint
      final response = await request.postJson(
        'http://localhost:8000/create-flutter/',
        jsonEncode(productData),
      );

      // Close loading dialog
      Navigator.of(context).pop();

      if (response['status'] == 'success') {
        // Show success message and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate back to product list
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProductListPage()),
        );
      } else {
        // Handle API error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response['message'] ?? 'Unknown error'}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if still showing
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Produk Baru',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2563eb),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  hintText: 'Masukkan nama produk',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag, color: Color(0xFF2563eb)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk tidak boleh kosong';
                  }
                  if (value.length < 3) {
                    return 'Nama produk minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Price Field
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga (Rp)',
                  hintText: 'Masukkan harga produk',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money, color: Color(0xFF2563eb)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  final price = double.tryParse(value);
                  if (price == null) {
                    return 'Harga harus berupa angka';
                  }
                  if (price <= 0) {
                    return 'Harga harus lebih dari 0';
                  }
                  if (price > 10000000) {
                    return 'Harga terlalu tinggi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi produk',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description, color: Color(0xFF2563eb)),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  if (value.length < 10) {
                    return 'Deskripsi minimal 10 karakter';
                  }
                  if (value.length > 500) {
                    return 'Deskripsi maksimal 500 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Thumbnail Field
              TextFormField(
                controller: _thumbnailController,
                decoration: const InputDecoration(
                  labelText: 'URL Thumbnail',
                  hintText: 'https://example.com/image.jpg',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image, color: Color(0xFF2563eb)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'URL thumbnail tidak boleh kosong';
                  }
                  if (!_urlRegex.hasMatch(value)) {
                    return 'Masukkan URL yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  hintText: 'Pilih kategori produk',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category, color: Color(0xFF2563eb)),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori harus dipilih';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _categoryController.text = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),

              // Featured Checkbox
              CheckboxListTile(
                title: const Text('Produk Unggulan'),
                subtitle: const Text('Centang jika produk ini unggulan'),
                value: _isFeatured,
                onChanged: (value) {
                  setState(() {
                    _isFeatured = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color(0xFF2563eb);
                  }
                  return Colors.grey;
                }),
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(const Color(0xFF2563eb)),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  onPressed: request.loggedIn ? _saveProduct : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please login to create products'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  child: Text(
                    request.loggedIn ? 'Save Product' : 'Login Required',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
