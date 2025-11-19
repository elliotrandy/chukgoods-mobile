import 'package:flutter/material.dart';
import 'package:chukgoods_mobile/models/product.dart';
import 'package:chukgoods_mobile/widgets/product_card.dart';
import 'package:chukgoods_mobile/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products = [];
  bool isLoading = true;

  Future<List<Product>> fetchProducts(CookieRequest request) async {
    try {
      // Django JSON endpoint for fetching all products
      final response = await request.get('http://localhost:8000/json/');
      
      // Convert response to Product objects
      List<Product> listProducts = [];
      for (var d in response) {
        if (d != null) {
          try {
            Product product = Product.fromJson(d);
            listProducts.add(product);
          } catch (e) {
            // Handle parsing error silently
          }
        }
      }
      
      return listProducts;
    } catch (e) {
      // Handle error - return empty list or show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching products: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
    });
  }

  Future<void> _loadProducts() async {
    final request = context.read<CookieRequest>();
    
    setState(() {
      isLoading = true;
    });

    try {
      final productList = await fetchProducts(request);
      setState(() {
        products = productList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Error already handled in fetchProducts
    }
  }

  Future<void> _refreshProducts() async {
    final request = context.read<CookieRequest>();
    final productList = await fetchProducts(request);
    setState(() {
      products = productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        backgroundColor: const Color(0xFF2563eb),
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshProducts,
            tooltip: 'Refresh products',
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2563eb),
              ),
            )
          : products.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No products available',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _refreshProducts,
                  color: const Color(0xFF2563eb),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      
                      return ProductCard(
                        product: product,
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/product-form');
        },
        backgroundColor: const Color(0xFF2563eb),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
