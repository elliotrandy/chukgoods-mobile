import 'package:flutter/material.dart';
import 'package:chukgoods_mobile/models/product.dart';
import 'package:chukgoods_mobile/widgets/product_card.dart';
import 'package:chukgoods_mobile/menu.dart';
import 'package:chukgoods_mobile/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  List<Product> myProducts = [];
  bool isLoading = true;
  String? errorMessage;

  Future<List<Product>> fetchMyProducts(CookieRequest request) async {
    try {
      // Check if user is logged in first
      if (!request.loggedIn) {
        setState(() {
          errorMessage = 'Please login to view your products';
          isLoading = false;
        });
        return [];
      }

      // Try to request user's own products from dedicated endpoint
      final response = await request.get('http://localhost:8000/my-products/');

      List<Product> myProducts = [];
      for (var d in response) {
        if (d != null) {
          myProducts.add(Product.fromJson(d));
        }
      }

      setState(() {
        isLoading = false;
        errorMessage = null;
      });

      return myProducts;
    } catch (e) {
      // Fallback: If endpoint doesn't exist, fetch all and filter (temporary)
      try {
        final response = await request.get('http://localhost:8000/json/');

        List<Product> allProducts = [];
        for (var d in response) {
          if (d != null) {
            allProducts.add(Product.fromJson(d));
          }
        }

        // Temporary client-side filtering - shows all products for logged-in users
        // In production, this should be filtered on the server
        setState(() {
          isLoading = false;
          errorMessage = null;
        });
        
        return allProducts;
      } catch (fallbackError) {
        setState(() {
          isLoading = false;
          errorMessage = 'Error fetching products: $e';
        });
        return [];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMyProducts();
  }

  Future<void> _loadMyProducts() async {
    final request = context.read<CookieRequest>();
    final productList = await fetchMyProducts(request);
    setState(() {
      myProducts = productList;
    });
  }

  Future<void> _refreshMyProducts() async {
    final request = context.read<CookieRequest>();
    final productList = await fetchMyProducts(request);
    setState(() {
      myProducts = productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    // Check if user is logged in
    if (!request.loggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Products'),
          backgroundColor: const Color(0xFF2563eb),
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const AppDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.login_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Please login to view your products',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563eb),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        backgroundColor: const Color(0xFF2563eb),
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshMyProducts,
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
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadMyProducts,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563eb),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                )
              : myProducts.isEmpty
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
                            'You haven\'t created any products yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Create your first product to get started',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _refreshMyProducts,
                      color: const Color(0xFF2563eb),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: myProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: myProducts[index],
                          );
                        },
                      ),
                    ),
      floatingActionButton: request.loggedIn
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/product-form');
              },
              backgroundColor: const Color(0xFF2563eb),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}