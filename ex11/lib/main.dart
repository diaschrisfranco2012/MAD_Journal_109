import 'package:flutter/material.dart';

void main() {
  runApp(const HotelApp());
}

class HotelApp extends StatelessWidget {
  const HotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Reservation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// A) HOME SCREEN (StatelessWidget)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> hotels = const [
    {
      "name": "The Grand Azure",
      "location": "Maldives",
      "rating": "4.9",
      "image": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=600&q=80"
    },
    {
      "name": "Emerald Bay Resort",
      "location": "Bali, Indonesia",
      "rating": "4.7",
      "image": "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=600&q=80"
    },
    {
      "name": "Urban Skyline Hotel",
      "location": "New York, USA",
      "rating": "4.8",
      "image": "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600&q=80"
    },
    {
      "name": "Taj Resort & Convention Centre",
      "location": "Dona Paula, Goa",
      "rating": "4.9",
      "image": "https://images.unsplash.com/photo-1582719508461-905c673771fd?w=600&q=80"
    },
    {
      "name": "ITC Grand Goa Resort",
      "location": "Arossim Beach, Goa",
      "rating": "4.8",
      "image": "https://images.unsplash.com/photo-1540541338287-41700207dee6?w=600&q=80"
    },
    {
      "name": "W Goa",
      "location": "Vagator, Goa",
      "rating": "4.7",
      "image": "https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=600&q=80"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        
        // --- APP BAR ---
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Hotel Reservation App",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.indigo,
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.hotel), text: 'Hotels'),
              Tab(icon: Icon(Icons.book_online), text: 'Bookings'),
            ],
          ),
        ),

        // --- DRAWER ---
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1542314831-c6a4d14d8373?w=600&q=80"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(Icons.person, size: 35, color: Colors.indigo),
                    ),
                    SizedBox(height: 10),
                    Text("John Doe", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.indigo),
                title: const Text('Home', style: TextStyle(fontSize: 16)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.library_books, color: Colors.indigo),
                title: const Text('My Bookings', style: TextStyle(fontSize: 16)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.contact_support, color: Colors.indigo),
                title: const Text('Contact Us', style: TextStyle(fontSize: 16)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),

        // --- BODY ---
        body: TabBarView(
          children: [
            // TAB 1: HOTELS LIST (Modern styling)
            ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        hotel["image"]!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      hotel["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey[500], size: 16),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              hotel["location"]!,
                              style: TextStyle(color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward_ios, color: Colors.indigo, size: 18),
                    ),
                    onTap: () {
                      // Navigate to Booking Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingScreen(
                            hotelName: hotel["name"]!,
                            hotelImage: hotel["image"]!,
                            rating: hotel["rating"]!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            // TAB 2: BOOKINGS
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_online, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text("No active bookings yet.", style: TextStyle(color: Colors.grey[500], fontSize: 18)),
                ],
              ),
            ),
          ],
        ),

        // --- BOTTOM NAVIGATION BAR ---
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// B) BOOKING SCREEN (StatefulWidget)
class BookingScreen extends StatefulWidget {
  final String hotelName;
  final String hotelImage;
  final String rating;

  const BookingScreen({
    super.key,
    required this.hotelName,
    required this.hotelImage,
    required this.rating,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Form State Variables
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _roomType = 'Single';
  
  // Amenities Checkboxes
  bool _hasWiFi = false;
  bool _hasBreakfast = false;
  bool _hasParking = false;

  // Functionsn to  show pickers
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.network(
                        widget.hotelImage,
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                            stops: const [0.0, 0.5],
                          ),
                        ),
                      ),
                      // Overlaid Text
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 24),
                                const SizedBox(width: 5),
                                Text(
                                  widget.rating,
                                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.hotelName,
                              style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      // Floating Back Button
                      Positioned(
                        top: 50,
                        left: 15,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withValues(alpha: 0.8),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      )
                    ],
                  ),

                  // --- 1. BOOKING FORM ---
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Customer Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        
                        // TEXT FIELD (Customer Name)
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Enter Full Name",
                            filled: true,
                            fillColor: Colors.grey[100],
                            prefixIcon: const Icon(Icons.person_outline, color: Colors.indigo),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // DATE & TIME PICKERS
                        const Text("Arrival Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: _pickDate,
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(color: Colors.indigo[50], borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today, color: Colors.indigo, size: 20),
                                      const SizedBox(width: 10),
                                      Text(
                                        _selectedDate == null ? "Select Date" : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                                        style: TextStyle(color: _selectedDate == null ? Colors.grey[600] : Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: InkWell(
                                onTap: _pickTime,
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(color: Colors.indigo[50], borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time, color: Colors.indigo, size: 20),
                                      const SizedBox(width: 10),
                                      Text(
                                        _selectedTime == null ? "Select Time" : _selectedTime!.format(context),
                                        style: TextStyle(color: _selectedTime == null ? Colors.grey[600] : Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // RADIO BUTTON GROUP (Room Type)
                        const Text("Room Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: ['Single', 'Double', 'Deluxe'].map((type) {
                              return RadioListTile<String>(
                                title: Text(type, style: const TextStyle(fontWeight: FontWeight.w500)),
                                value: type,
                                groupValue: _roomType,
                                activeColor: Colors.indigo,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                onChanged: (value) => setState(() => _roomType = value!),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // CHECKBOX GROUP (Amenities)
                        const Text("Extra Amenities", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: const Text("Free WiFi"),
                                secondary: const Icon(Icons.wifi, color: Colors.indigo),
                                value: _hasWiFi,
                                activeColor: Colors.indigo,
                                dense: true,
                                onChanged: (val) => setState(() => _hasWiFi = val!),
                              ),
                              CheckboxListTile(
                                title: const Text("Breakfast Included"),
                                secondary: const Icon(Icons.restaurant, color: Colors.indigo),
                                value: _hasBreakfast,
                                activeColor: Colors.indigo,
                                dense: true,
                                onChanged: (val) => setState(() => _hasBreakfast = val!),
                              ),
                              CheckboxListTile(
                                title: const Text("Parking Space"),
                                secondary: const Icon(Icons.local_parking, color: Colors.indigo),
                                value: _hasParking,
                                activeColor: Colors.indigo,
                                dense: true,
                                onChanged: (val) => setState(() => _hasParking = val!),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 2. BOTTOM ACTION BUTTONS ---
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.withValues(alpha: 0.2), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, -2)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.indigo),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text("Go Back", style: TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      //confirmation SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.white),
                              const SizedBox(width: 10),
                              Text('Booking Successful for ${_nameController.text.isEmpty ? "Guest" : _nameController.text}!'),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text("Book Now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}