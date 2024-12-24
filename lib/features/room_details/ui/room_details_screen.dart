import 'package:design_pattern/core/theming/styles.dart';
import 'package:design_pattern/core/widgets/app_text_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/model/room_model.dart';
import 'booking_form_screen.dart';

class RoomDetailsScreen extends StatelessWidget {
  final HotelRoom hotelRoom;

  const RoomDetailsScreen({Key? key, required this.hotelRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Room: ${hotelRoom.roomId}",
          style: MyTextStyle.font20MainBrownRegular,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Manually pop the screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: 312,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    hotelRoom.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          hotelRoom.roomType,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text("Rating: ${hotelRoom.roomRate}  "),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$${hotelRoom.price} per night',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "${hotelRoom.roomDescription}",
                      style: MyTextStyle.font16MainBrownRegular,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    AppTextBtn(
                      buttonText: "Book room",
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return BookingForm(hotelRoom: hotelRoom);
                          },
                        );
                      },
                      textStyle: MyTextStyle.font18WhiteRegular,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
