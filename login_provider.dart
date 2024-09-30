import 'package:flutter/material.dart';

// This class manages the authentication state of the app.
class AuthProvider with ChangeNotifier {
  // A map that holds login credentials (email and password).
  final Map<String, String> _credentials = {
    'rjsanjuan@gmail.com': 'password123',
    'inventi@gmail.com': 'pass456',
  };

  // This variable tracks whether a user is authenticated (logged in).
  bool _isAuthenticated = false;
  // This variable holds any error messages that occur during login.
  String? _errorMessage;

  // Public getter to check if the user is authenticated.
  //isAuthenticated can be passed outside(public) while the _isAuthenticated is private
  bool get isAuthenticated => _isAuthenticated;
  // Public getter to retrieve the error message if there's one.
  String? get errorMessage => _errorMessage;

  // This method attempts to log in a user with the provided email and password.
  void login(String email, String password) {
    // Reset the error message to null at the start of login.
    _errorMessage = null;

    // Check if the provided email exists in our credentials map.
    if (_credentials.containsKey(email)) {
      // If the email exists, check if the provided password matches.
      if (_credentials[email] == password) {
        // If the password matches, set the authentication state to true.
        _isAuthenticated = true;
      } else {
        // If the password doesn't match, set an error message.
        _errorMessage = 'Incorrect password';
        print(_errorMessage); // Log the error message for debugging.
        _isAuthenticated = false; // Keep the user not authenticated.
      }
    } else {
      // If the email isn't found, set an error message.
      _errorMessage = 'Email not found';
      print(_errorMessage); // Log the error message for debugging.
      _isAuthenticated = false; // Keep the user not authenticated.
    }

    // Notify any listeners (like UI) that the state has changed.
    notifyListeners();
  }

  // This method logs out the user by resetting the authentication state.
  void logout() {
    _isAuthenticated = false; // Set authentication state to false.
    _errorMessage = null; // Clear any error messages.
    notifyListeners(); // Notify listeners about the state change.
  }
}
