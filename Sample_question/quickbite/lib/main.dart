import 'package:flutter/material.dart';

//==========================================
//  main() function
// ==========================================
// Every single Flutter appstartsBy looking for this 'main' function.
void main() {
  // runApp takes your app design (MyApp) and throws it onto the screen.
  runApp(const MyApp());
}

// ==========================================
// MyApp
// ==========================================
// Think of MyApp as the master blueprint for your whole app.
// 'StatelessWidget' just means this is a dumb screen. It draws once and doesn't change.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the "theme" of your app. 
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // This just hides that ugly "DEBUG" sticker in the top right corner.
      title: 'QuickBite',
      home: HomeScreen(), // 'home' tells the app: "When you open, go straight to the HomeScreen."
    );
  }
}

// ==========================================
// PART A: HOME SCREEN (5 Marks)
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    // SCAFFOLD: This is the most important word in Flutter UI.
    // Think of Scaffold as a blank piece of paper. It automatically gives you 
    // a designated spot for a top bar, a middle body, and a bottom menu.
    return Scaffold(
      backgroundColor: Colors.grey[200], // A nice light grey background
      
      // 1️THE APP BAR (The Roof)
      // This sits at the very top of your screen.
      appBar: AppBar(
        title: const Text("QuickBite", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false, // The teacher wanted the title on the left. This makes sure it stays left!
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Makes the text and icons black
        elevation: 0, // Elevation is the drop-shadow. Setting it to 0 makes it look flat and modern.
        actions: [
          // 'actions' is a list of buttons on the RIGHT side of the AppBar.
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {}, // This is empty because the teacher didn't ask us to make the cart work.
          ),
        ],
      ),

      // 2️.THE BODY 
      // SingleChildScrollView is a lifesaver widget. If you add too much content to this screen, 
      // the phone will run out of space and show an error. This makes the screen scrollable!
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Adds a 20-pixel padding around the whole screen
          
          // COLUMN: Think of a Column like stacking Lego blocks top-to-bottom.
          // Everything inside 'children' gets stacked vertically.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // 'Stretch' forces the boxes to fill the whole width of the phone.
            children: [
              
              // Here we use our custom helper (scroll to the bottom to see how it works).
              // We just say "Make a Burger item box" and hand it a picture link.for exam you guys will be given images so create the folder and define the path in the yaml file
              _buildFoodCategory(
                "Burgers", 
                "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=60"
              ),
              
              // SizedBox is literally just an invisible empty box. We use it to create gaps between items.
              const SizedBox(height: 15), 
              
              _buildFoodCategory(
                "Pizza", 
                "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=500&q=60"
              ),
              const SizedBox(height: 15),
              
              _buildFoodCategory(
                "Desserts", 
                "https://images.unsplash.com/photo-1551024601-bec78aea704b?auto=format&fit=crop&w=500&q=60"
              ),
              const SizedBox(height: 30), // A bigger gap before the button

              // PART B (i): THE ORDER BUTTON
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black, 
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // NAVIGATION (PUSH): This is how you travel in Flutter!
                  // Imagine your app is a deck of cards. The HomeScreen is on top.
                  // Navigator.push() takes the 'OrderScreen' card and slaps it directly on top of the 'HomeScreen'.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderScreen()),
                  );
                },
                child: const Text(
                  "Order Now",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),

      // 3️.THE BOTTOM MENU (The Basement)
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
    );
  }

  // ==========================================
  // HELPER WIDGET: _buildFoodCategory
  // ==========================================
  // Why did we make this? If we didn't, we would have to copy/paste the 20 lines of code below 
  // THREE times for Burgers, Pizza, and Dessert. This saves time and makes the code clean!
  Widget _buildFoodCategory(String name, String imageUrl) {
    return Column( // Remember, Column stacks things vertically.
      children: [
        
        // CONTAINER: Think of a Container like an empty cardboard box.
        // You can give it a size, color it, and put things inside it.
        Container(
          height: 140, 
          width: double.infinity, // 'double.infinity' just means "take up as much width as you possibly can"
          
          // BoxDecoration is where we do all the styling (colors, rounded corners, images)
          decoration: BoxDecoration(
            color: Colors.grey[300], 
            borderRadius: BorderRadius.circular(12), // This rounds the sharp corners!
            
            // This is how we insert a picture onto the box
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover, // 'Cover' zooms the image slightly so it perfectly fits the box without stretching.
            ),
          ),
        ),
        
        const SizedBox(height: 10), // A tiny invisible gap between the picture and the text
        
        // This is a smaller Container just for the dark text background
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), // Padding pushes the walls of the box OUT away from the text
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            name, // This prints "Burgers", "Pizza", etc. depending on what we asked for above.
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
} 

// ==========================================
// PART B: ORDER SCREEN (5 Marks)
// ==========================================
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Blank piece of paper for the second screen
      backgroundColor: Colors.grey[200],
      
      // 'Center' grabs everything inside it and shoves it to the exact dead-center of the phone screen.
      body: Center( 
        child: Column( // Stacking things top-to-bottom again
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            
            // The Welcome Message
            const Text(
              "Welcome to QuickBite Ordering Page",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Centers the text itself if it breaks into two lines
            ),
            
            const SizedBox(height: 30), // Invisible gap
            
            // ROW: Remember how Column stacks top-to-bottom? 
            // Row places widgets side-by-side, from left-to-right!
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Pushes the two buttons to the middle of the Row
              children: [
                
                // Button 1: The Home Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400]),
                  onPressed: () {
                    
                    // NAVIGATION (POP): Remember our deck of cards?
                    // Navigator.pop() grabs the top card (OrderScreen) and throws it in the trash.
                    // This automatically reveals the HomeScreen that was hiding underneath it!
                    Navigator.pop(context); 
                  },
                  child: const Text("Home", style: TextStyle(color: Colors.black)),
                ),
                
                const SizedBox(width: 20), // Instead of a vertical gap, this is a horizontal gap between buttons
                
                // Button 2: Place Order
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    // We leave this blank because the teacher didn't ask us to do anything here.
                  },
                  child: const Text("Place Order", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}