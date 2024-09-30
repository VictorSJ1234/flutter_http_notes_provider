import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventi_flutter_exam/login/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPageUi extends StatefulWidget {
  const LoginPageUi({super.key});

  @override
  _LoginPageUiState createState() => _LoginPageUiState();
}

class _LoginPageUiState extends State<LoginPageUi> {
  // Key to validate the login form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Controllers for capturing user input.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Method to validate form and attempt login.
  void _validateAndSubmit() {
    // Check if the form is valid.
    if (_formKey.currentState?.validate() == true) {
      // Access the AuthProvider to manage authentication.

      //the listen is false in order to get the value only one
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // Call the login method with the provided credentials.
      authProvider.login(_emailController.text, _passwordController.text);

      // If login is successful, navigate to the home page.
      if (authProvider.isAuthenticated) {
        context.pushNamed('home');
      } else {
        // If login fails, show an error dialog.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
              shadowColor: Colors.black,
              content: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/alert.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Invalid email or password. Please try again.',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              actions: [
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog.
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          'BACK',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  // Variable to manage password visibility.
  bool _obscureText = true;

  // Method to toggle the visibility of the password.
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Switch between showing and hiding the password.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image for the login screen.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark overlay to improve text visibility.
          Container(
            color: Colors.black.withOpacity(0.7),
          ),

          // Centering the login form in the screen.
          Center(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey, // Attach the form key for validation.
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Email input field with validation.
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.blueGrey),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          // Validator checks for empty and valid email format.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email'; // Error for empty input.
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Please enter a valid email address'; // Error for invalid email format.
                            }
                            return null; // No error.
                          },
                        ),

                        const SizedBox(height: 30),

                        // Password input field with visibility toggle.
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText, // Use toggle for password visibility.
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.blueGrey),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: _togglePasswordVisibility, // Toggle visibility on button press.
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.red, // Change error message color here
                              fontWeight: FontWeight.bold, // Make error text bold
                              fontSize: 14, // Adjust font size
                            ),
                          ),
                          // Validator checks for empty input.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required.'; // Custom error message
                            }
                            // Additional validation can go here, e.g., minimum length
                            return null; // No error.
                          },
                        ),


                        const SizedBox(height: 20),

                        // Link for "Forgot Password?" (not functional).
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Not functional yet.
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Login button that triggers validation and submission.
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _validateAndSubmit, // Call the validation and login method.
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Link for signing up (not functional).
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                // Not functional yet.
                              },
                              child: const Text(
                                'Sign Up here',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Logo displayed at the bottom of the form.
                        Image.asset(
                          'assets/inventi_logos/inventi_logo_1.png',
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
