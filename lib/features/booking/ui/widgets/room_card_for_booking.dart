import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/model/room_model.dart';
import '../../../../core/theming/colors.dart';

class RoomCardForBooking extends StatelessWidget {
  final HotelRoom hotelRoom;

  const RoomCardForBooking({
    super.key,
    required this.hotelRoom,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.myVeryLightGray,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.only(left: 4, top: 8, right: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                hotelRoom.imagePath, // Placeholder for room image
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 230,
                  child: Row(
                    children: [
                      Text(
                        "${hotelRoom.roomType} ${hotelRoom.roomId}", overflow: TextOverflow.clip,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text("Rating: ${hotelRoom.roomRate}  "),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  " \$ ${hotelRoom.price}  per night",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                Container(
                  width: 230,
                  child: Row(
                    children: [
                      Text(
                        "${hotelRoom.resident?.name ?? 'Available'}",
                        style: hotelRoom.resident != null
                            ? TextStyle(color: Colors.black87)
                            : TextStyle(color: CupertinoColors.activeGreen,fontSize: 16),
                      ),
                      Spacer(),
                      Text("Check Out: "),
                      Text(
                        "${hotelRoom.resident?.checkOut.toLocal() ?? ''}".split(' ')[0],
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              hotelRoom.isAvailable ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
