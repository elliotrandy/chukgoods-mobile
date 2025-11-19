import 'package:flutter/material.dart';
import 'package:chukgoods_mobile/menu.dart';
import 'package:chukgoods_mobile/screens/login.dart';
import 'package:chukgoods_mobile/screens/register.dart';
import 'package:chukgoods_mobile/screens/product_list.dart';
import 'package:chukgoods_mobile/screens/product_form.dart';
import 'package:chukgoods_mobile/screens/product_detail.dart';
import 'package:chukgoods_mobile/screens/my_products.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'CHUKGOODS',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF2563eb),
            secondary: Color(0xFF2563eb),
          ),
          // Update button theme colors
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563eb),
              foregroundColor: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF2563eb),
            ),
          ),
        ),
        // Start with login page for proper authentication flow
        home: const LoginPage(),
        
        // Define named routes for better navigation
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/menu': (context) => MyHomePage(),
          '/product-list': (context) => const ProductListPage(),
          '/product-form': (context) => const ProductFormPage(),
          '/my-products': (context) => const MyProductsPage(),
        },
      ),
    );
  }
}
