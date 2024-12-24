import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/networking/provider.dart';
import '../../../core/theming/colors.dart';
import '../../booking/ui/booking_screen.dart';
import '../../my_account/ui/account_screen.dart';
import '../../rooms/ui/rooms_screen.dart';
import 'home_screen.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({super.key});

  @override
  State<HomeScreenState> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenState> {
  int _selectedIndex = 0; // Tracks the selected tab
  String? userRole; // Holds the user role
  bool isLoading = true; // Tracks loading state

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final userData = await userProvider.getUserData();
      setState(() {
        userRole = userData?.role;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(),
      BookingScreen(),
      RoomsScreen(),
      isLoading
          ? const Center(child: CircularProgressIndicator())
          : AccountScreen(userRole: userRole),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Keeps the state of each screen
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: MyColors.mainBrown,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bed_outlined),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
