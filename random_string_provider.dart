import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import HTTP package for making network requests
import 'dart:convert'; // Import JSON package to decode JSON data

class RandomStringProvider with ChangeNotifier {
  String _randomString = "Quick Button"; // Default text shown before fetching
  String? _errorMessage; // This will hold any error messages if something goes wrong
  bool _isLoading = false; // A flag to indicate if a request is in progress
  String? _fetchedStringById; // For storing fetched string by ID

  // Public getter to access the current random string
  String get randomString => _randomString;

  // Public getter to access any error messages
  String? get errorMessage => _errorMessage;

  // Getter for the fetched string by ID
  String? get fetchedStringById => _fetchedStringById;

  // Public getter to check if data is currently loading
  bool get isLoading => _isLoading;

  // Function to fetch a new random string from the server
  Future<void> fetchRandomString() async {
    // This method returns a Future<void>, indicating it will complete at some point without returning a value.
    // It allows for asynchronous operations, making it suitable for tasks like network requests.

    _isLoading = true; // Set loading to true to indicate the fetch has started
    _errorMessage = null; // Clear any previous error messages
    notifyListeners(); // Notify listeners to update the UI

    try {
      // Make an HTTP GET request to the specified URL.
      // The 'await' keyword pauses execution until the HTTP request completes.
      // This allows us to handle the response directly after the request.
      final response = await http.get(Uri.parse(
        'https://o7q6ka26qs232rmbtpbrxghy6u0vyrup.lambda-url.ap-southeast-1.on.aws/',
      ));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body); // Decode the JSON response
        _randomString = jsonResponse['randomString']; // Update the random string with the fetched value
      } else {
        // If the response was not successful, set an error message
        _errorMessage = 'Failed to load random string';
        print(_errorMessage); // Print the error message for debugging
      }
    } catch (e) {
      // If there's an exception (like network error), set an error message
      _errorMessage = 'An error occurred: $e';
      print(_errorMessage); // Print the error message for debugging
    } finally {
      // After trying to fetch, set loading to false and notify listeners
      _isLoading = false; // Reset loading state
      notifyListeners(); // Notify listeners to update the UI with new data or error
    }
  }


  //for posting
  Future<void> postName(String name) async {
    // This method will handle posting the name to the server.
    final String url = 'YOUR_SERVER_URL_HERE'; // Replace with your server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success if needed
        print('Name posted successfully');
      } else {
        print('Failed to post name: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while posting name: $e');
    }
  }

  //for updating
  Future<void> updateName(String name) async {
    final String url = 'YOUR_SERVER_URL_HERE'; // Replace with your server update URL

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success if needed
        print('Name updated successfully');
      } else {
        print('Failed to update name: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while updating name: $e');
    }
  }

  // Method to fetch a string by ID
  Future<void> fetchStringById(String id) async {
    final String url = 'YOUR_SERVER_URL_HERE/$id'; // Adjust this URL based on your API

    _isLoading = true; // Set loading to true
    _errorMessage = null; // Clear previous errors
    notifyListeners(); // Notify listeners to update the UI

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        _fetchedStringById = jsonResponse['randomString']; // Assuming your API returns the randomString
      } else {
        _errorMessage = 'Failed to fetch string by ID';
        print(_errorMessage);
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      print(_errorMessage);
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners(); // Notify listeners to update the UI
    }
  }

  //for deletion by id
  Future<void> deleteName(String id) async {
    final String url = 'YOUR_SERVER_URL_HERE/$id'; // Adjust this URL based on your API

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Handle success if needed
        print('Name deleted successfully');
      } else {
        print('Failed to delete name: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting name: $e');
    }
  }
}
