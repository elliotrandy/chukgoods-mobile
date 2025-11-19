import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chukgoods_mobile/menu.dart';
import 'package:chukgoods_mobile/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color(0xFF2563eb),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2563eb),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Choose a username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      prefixIcon: Icon(Icons.person, color: Color(0xFF2563eb)),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      prefixIcon: Icon(Icons.email, color: Color(0xFF2563eb)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Choose a password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF2563eb)),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      prefixIcon: Icon(Icons.lock_person, color: Color(0xFF2563eb)),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      String confirmPassword = _confirmPasswordController.text;
                      
                      // Validation
                      if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      if (password.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password must be at least 6 characters'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2563eb),
                          ),
                        ),
                      );

                      try {
                        // Django registration endpoint
                        final response = await request.postJson(
                          "http://localhost:8000/auth/register/",
                          jsonEncode({
                            "username": username,
                            "password1": password,
                            "password2": confirmPassword,
                            "email": email,
                          }),
                        );

                        // Close loading dialog
                        Navigator.of(context).pop();

                        if (response.containsKey('success') && response['success'] == true) {
                          String message = response['message'] ?? 'Registration successful';
                          
                          if (context.mounted) {
                            Navigator.pop(context); // Close register page
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text("$message. Please login to continue."),
                                  backgroundColor: const Color(0xFF2563eb),
                                ),
                              );
                            
                            // Navigate to login page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          }
                        } else {
                          String errorMessage = response['message'] ?? 'Registration failed';

                          // Improved error handling for Django validation errors
                          if (response.containsKey('errors')) {
                            try {
                              Map<String, dynamic> errors = response['errors'];

                              if (errors.containsKey('username')) {
                                var usernameErrors = errors['username'];
                                if (usernameErrors is List && usernameErrors.isNotEmpty) {
                                  errorMessage = 'Username: ${usernameErrors[0]}';
                                } else if (usernameErrors is String) {
                                  errorMessage = 'Username: $usernameErrors';
                                }
                              } else if (errors.containsKey('email')) {
                                var emailErrors = errors['email'];
                                if (emailErrors is List && emailErrors.isNotEmpty) {
                                  errorMessage = 'Email: ${emailErrors[0]}';
                                } else if (emailErrors is String) {
                                  errorMessage = 'Email: $emailErrors';
                                }
                              } else if (errors.containsKey('password')) {
                                var passwordErrors = errors['password'];
                                if (passwordErrors is List && passwordErrors.isNotEmpty) {
                                  errorMessage = 'Password: ${passwordErrors[0]}';
                                } else if (passwordErrors is String) {
                                  errorMessage = 'Password: $passwordErrors';
                                }
                              } else if (errors.containsKey('password2')) {
                                var password2Errors = errors['password2'];
                                if (password2Errors is List && password2Errors.isNotEmpty) {
                                  errorMessage = 'Confirm Password: ${password2Errors[0]}';
                                } else if (password2Errors is String) {
                                  errorMessage = 'Confirm Password: $password2Errors';
                                }
                              }
                            } catch (e) {
                              errorMessage = 'Registration failed: Invalid error response format';
                            }
                          }
                          
                          // Handle registration failure
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        
                        // Close loading dialog if still showing
                        if (Navigator.canPop(context)) {
                          Navigator.of(context).pop();
                        }
                        
                        // Handle network or other errors
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registration error: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color(0xFF2563eb),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 24.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: Color(0xFF2563eb),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}