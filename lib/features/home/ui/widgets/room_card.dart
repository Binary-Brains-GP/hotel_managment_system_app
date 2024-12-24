import 'package:design_pattern/core/routing/routes.dart';
import 'package:design_pattern/core/theming/colors.dart';
import 'package:design_pattern/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/model/room_model.dart';
import '../../../../core/networking/room_provider.dart';

class RoomCard extends StatelessWidget {
  final HotelRoom hotelRoom;

  const RoomCard({
    super.key,
    required this.hotelRoom,
  });
  void _showCannotCloneDialog(BuildContext context){
    showDialog(context: context, builder: (ctx)=> AlertDialog(
      backgroundColor: MyColors.myVeryLightBrown,
      title: Text("Error on Clonning"),
      content: Text("You can't clone reseved room "),
      actions: [ TextButton(
        onPressed: () => Navigator.of(ctx).pop(), // Close dialog
        child: Text('OK',style: MyTextStyle.font18LightBlackRegular,),
      ),],
    ));
  }
  void _showCloneDialog(BuildContext context, HotelRoom room) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Clone Room'),
        content: Text('Do you want to clone this room?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(), // Close dialog
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Clone the room and add to the provider
              final clonedRoom = room.clone(
                DateTime.now().second.toString(), // Unique ID
              );
              roomProvider.addRoom(clonedRoom);
              Navigator.of(ctx).pop(); // Close dialog
            },
            child: Text('Clone'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        if (hotelRoom.resident == null) {
          // Show the clone dialog if the resident is null
          _showCloneDialog(context, hotelRoom);
        } else {
          // Show a dialog indicating the room cannot be cloned
          _showCannotCloneDialog(context);
        }
      },
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.roomDetailsScreen,
            arguments: hotelRoom, // Passing the HotelRoom as an argument
          );
        },
      child: Hero(
        tag: 'room-card-${hotelRoom.roomId}-${context.hashCode}',
        child: Container(
          width: 100,
          height: 150,
          padding: const EdgeInsets.only(right: 14),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    hotelRoom.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Positioned Container at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 100,
                    color: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${hotelRoom.roomType} ${hotelRoom.roomId}",
                          overflow: TextOverflow.ellipsis, // Avoid overflow
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "\$${hotelRoom.price}",
                          overflow: TextOverflow.ellipsis, // Avoid overflow
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                              fontSize: 16

                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 20, // Constrain height for availability
                          child: Text(
                            hotelRoom.isAvailable
                                ? "Available"
                                : "Not Available",
                            overflow: TextOverflow.ellipsis, // Avoid overflow
                            style: TextStyle(
                              color: hotelRoom.isAvailable
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
