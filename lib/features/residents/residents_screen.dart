import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_pattern/features/residents/widgets/resident_card.dart';
import '../../core/networking/room_provider.dart';

class ResidentsScreen extends StatefulWidget {
  @override
  _ResidentsScreenState createState() => _ResidentsScreenState();
}

class _ResidentsScreenState extends State<ResidentsScreen> {
  // TextEditingController for the search input
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Add listener to update search query
    _searchController.addListener(_onSearchChanged);
  }

  // Handle search query changes
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose controller to avoid memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Residents'),
        actions: [
          // Search icon that focuses on the search field
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Optionally focus on the search bar
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search TextField
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Residents',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            // Consumer widget to listen to changes in the RoomProvider
            Consumer<RoomProvider>(
              builder: (context, roomProvider, child) {
                final residents = roomProvider.rooms
                    .where((room) => room.resident != null)
                    .map((room) => room.resident!)
                    .toList();

                // Filter residents based on the search query
                final filteredResidents = residents
                    .where((resident) => resident.name
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()))
                    .toList();

                return Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: filteredResidents.length,
                    itemBuilder: (context, index) {
                      return ResidentCard(resident: filteredResidents[index],);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
