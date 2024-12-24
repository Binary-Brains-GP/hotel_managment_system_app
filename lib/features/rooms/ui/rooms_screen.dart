import 'package:design_pattern/core/theming/colors.dart';
import 'package:design_pattern/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/networking/room_provider.dart';
import '../../add_room/add_room_screen.dart';
import '../../home/ui/widgets/room_card.dart';

class RoomsScreen extends StatefulWidget {
  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _openIconButtonPressed() {
    // Open AddRoomScreen using showModalBottomSheet
    showModalBottomSheet(
      context: context,
      builder: (ctx) => AddRoomScreen(
        onAddRoom: (newRoom) {
          // Add the new room to the provider
          Provider.of<RoomProvider>(context, listen: false).addRoom(newRoom);
        }, hotelRoom: [],
      ),
      isScrollControlled: true,
      enableDrag: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the room list from the provider
    final roomProvider = Provider.of<RoomProvider>(context);
    final allRooms = roomProvider.rooms;

    // Filter rooms based on search query
    final filteredRooms = allRooms.where((room) {
      return room.roomType.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("All Rooms",style: MyTextStyle.font20MainBrownRegular,),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.line_weight_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.circle)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search rooms...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two cards per row
                  mainAxisSpacing: 10, // Space between rows
                  childAspectRatio: 0.7, // Adjust card height/width ratio
                ),
                itemCount: filteredRooms.length,
                itemBuilder: (context, index) {
                  return RoomCard(hotelRoom: filteredRooms[index]);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openIconButtonPressed,
        backgroundColor: MyColors.myLightBrown,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
