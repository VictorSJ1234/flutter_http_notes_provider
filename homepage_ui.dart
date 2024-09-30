import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider for state management
import 'random_string_provider.dart'; // Import the provider to access random strings

class HomepageUi extends StatelessWidget {
  const HomepageUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the RandomStringProvider to get data and methods
    final randomStringProvider = Provider.of<RandomStringProvider>(context);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController idController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10), // Padding around the logo
          child: Image.asset(
            'assets/inventi_logos/inventi_logo_2.png', // Display the logo
            height: 40, // Set height of the logo
          ),
        ),
        backgroundColor: const Color(0xFFF1F7FF), // Set background color of the AppBar
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/menu_button.png', // Menu button icon
            height: 50, // Set height of the menu icon
          ),
          onPressed: () {
            // Menu button press action (currently not functional)
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFF1F7FF), // Background color for the body
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20), // Padding inside the main container
            margin: const EdgeInsets.all(20), // Margin outside the main container
            decoration: BoxDecoration(
              color: Colors.white, // White background for the card
              borderRadius: BorderRadius.circular(10), // Rounded corners
              boxShadow: [ // Shadow effect for depth
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 3, // How far the shadow spreads
                  blurRadius: 3, // How blurry the shadow is
                  offset: const Offset(0, 3), // Shadow offset (position)
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Column size based on content
              children: [
                Container(
                  width: double.infinity, // Full width of the container
                  height: 50, // Fixed height for the text container
                  color: const Color(0xFFf1f7ff), // Background color for the text area
                  padding: const EdgeInsets.all(10), // Padding inside the text area
                  child: randomStringProvider.isLoading // Check if loading
                      ? Container(
                      width: double.infinity,
                      color: Colors.white, // Loading state is white
                      child: const SizedBox.shrink() // Empty container while loading
                  )
                      : Text(
                    randomStringProvider.errorMessage != null // Check for error
                        ? "Can't Fetch String" // Show error message if exists
                        : randomStringProvider.randomString, // Display fetched string
                    style: const TextStyle(
                      fontSize: 18, // Font size for the text
                      fontWeight: FontWeight.bold, // Make text bold
                      color: Colors.deepPurple, // Text color
                    ),
                    textAlign: TextAlign.center, // Center the text
                  ),
                ),

                const SizedBox(height: 20), // Space between elements

                SizedBox(
                  width: double.infinity, // Full width for the button
                  height: 50, // Fixed height for the button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                    onPressed: () async {
                      // When button is pressed, fetch a new random string
                      await randomStringProvider.fetchRandomString();
                    },
                    child: randomStringProvider.isLoading // Check if loading
                        ? const CircularProgressIndicator(
                      color: Colors.black, // Show loading spinner
                    )
                        : const Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center content in the button
                      children: [
                        Icon(Icons.build, color: Colors.white), // Icon in button
                        SizedBox(height: 4), // Space between icon and text
                        Text(
                          'Click the button to generate a random string', // Button text
                          textAlign: TextAlign.center, // Center the text
                          style: TextStyle(fontSize: 12, color: Colors.white), // Text style
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                // Text field for input
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty) {
                      // Post the name to the server
                      await randomStringProvider.postName(nameController.text);
                      nameController.clear(); // Clear the text field
                    }
                  },
                  child: const Text('Post Name'),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty) {
                      // Update the name on the server
                      await randomStringProvider.updateName(nameController.text);
                      nameController.clear(); // Clear the text field
                    }
                  },
                  child: const Text('Update Name'),
                ),

                const SizedBox(height: 20),
                // Text field for inputting ID
                TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'Enter ID to fetch',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (idController.text.isNotEmpty) {
                      await randomStringProvider.fetchStringById(idController.text);
                      idController.clear(); // Clear the text field
                    }
                  },
                  child: const Text('Fetch String by ID'),
                ),
                const SizedBox(height: 20),
                // Text field for inputting ID to delete
                TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'Enter ID to delete',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (idController.text.isNotEmpty) {
                      await randomStringProvider.deleteName(idController.text);
                      idController.clear(); // Clear the text field
                    }
                  },
                  child: const Text('Delete Name'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
