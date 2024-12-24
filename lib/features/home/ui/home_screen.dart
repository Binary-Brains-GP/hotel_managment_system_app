import 'package:design_pattern/core/theming/colors.dart';
import 'package:design_pattern/features/home/ui/widgets/horizontal_text_scroller.dart';
import 'package:design_pattern/features/home/ui/widgets/room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/networking/room_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "The Royal"; // Default selected category

  @override
  Widget build(BuildContext context) {
    // Fetch rooms dynamically from RoomProvider
    final roomProvider = Provider.of<RoomProvider>(context);
    final filteredRooms = roomProvider.rooms
        .where((room) =>
    room.category == selectedCategory && room.isAvailable == true)
        .toList();

    void _onCategorySelected(String category) {
      setState(() {
        selectedCategory = category;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: const Padding(
          padding: EdgeInsets.only(left: 50),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.line_weight_outlined)),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.dark_mode)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.circle)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/images/big img.png"),
                const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "A Hotel for Every \nmoment rich in emotion",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Choose a room",
                style: TextStyle(
                  fontSize: 26,
                  color: MyColors.myLightBrown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            HorizontalTextScroller(onCategorySelected: _onCategorySelected),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.7),
                padEnds: false,
                itemCount: filteredRooms.length,
                itemBuilder: (context, index) {
                  return RoomCard(hotelRoom: filteredRooms[index]);
                },
              ),
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
