import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_pattern/core/theming/colors.dart';
import 'package:design_pattern/core/theming/styles.dart';
import 'package:design_pattern/core/widgets/app_text_btn.dart';
import 'package:design_pattern/features/booking/ui/widgets/room_card_for_booking.dart';
import '../../../core/model/room_model.dart';
import '../../../core/networking/room_provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool showActiveRooms = true;

  @override
  Widget build(BuildContext context) {
    // Get the RoomProvider using Consumer
    return Consumer<RoomProvider>(
      builder: (context, roomProvider, child) {
        // Filter rooms based on availability
        List<HotelRoom> filteredRooms = roomProvider.rooms
            .where((room) => room.isAvailable == showActiveRooms)
            .toList();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 4,
            title: const Text(
              "Bookings",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.line_weight_outlined, color: Colors.black),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.circle, color: Colors.black),
              ),
            ],
          ),
          body: Column(
            children: [
              // Active and Past Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextBtn(
                    backGroundColor:
                    showActiveRooms ? MyColors.mainBrown : Colors.black12,
                    buttonHeight: 45,
                    buttonText: "Active",
                    onPressed: () {
                      if (!showActiveRooms) {
                        setState(() {
                          showActiveRooms = true;
                        });
                      }
                    },
                    buttonWidth: 175,
                    textStyle: showActiveRooms
                        ? MyTextStyle.font16WhiteRegular
                        : MyTextStyle.font16BlackRegular,
                  ),
                  AppTextBtn(
                    backGroundColor:
                    showActiveRooms ? Colors.black12 : MyColors.mainBrown,
                    buttonHeight: 45,
                    buttonText: "Occupied",
                    onPressed: () {
                      if (showActiveRooms) {
                        setState(() {
                          showActiveRooms = false;
                        });
                      }
                    },
                    buttonWidth: 175,
                    textStyle: showActiveRooms
                        ? MyTextStyle.font16BlackRegular
                        : MyTextStyle.font16WhiteRegular,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Room List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredRooms.length,
                  itemBuilder: (context, index) {
                    return RoomCardForBooking(hotelRoom: filteredRooms[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
