import 'package:flutter/cupertino.dart';
import '../model/resident_model.dart';
import '../model/room_model.dart';

class RoomProvider extends ChangeNotifier {
  final List<HotelRoom> _rooms = HotelRoom.getRooms();

  List<HotelRoom> get rooms => _rooms;

  void addRoom(HotelRoom room) {
    _rooms.add(room);
    notifyListeners(); // Notify listeners when a room is added
  }

  List<HotelRoom> getAvailableRooms() {
    return rooms.where((room) => room.resident == null).toList();
  }

  void updateRoomAvailability(String roomId, bool availability) {
    final room = _rooms.firstWhere((room) => room.roomId == roomId);
    room.isAvailable = availability;
    notifyListeners(); // Notify listeners when room availability changes
  }

  void bookRoom(String roomId, Resident resident) {
    final room = rooms.firstWhere((room) => room.roomId == roomId);
    room.resident = resident;
    room.isAvailable = false;
    notifyListeners(); // Notify listeners when a room is booked
  }

  void removeResidentFromRoom(String roomId) {
    final room = _rooms.firstWhere((room) => room.roomId == roomId);
    room.resident = null;
    room.isAvailable = true;
    notifyListeners(); // Notify listeners when a resident is removed
  }

  void updateResidentDetails(int currentRoomId, Resident updatedResident) {
    // Find the current room by ID
    final currentRoom = rooms.firstWhere(
          (room) => int.parse(room.roomId) == currentRoomId,
      orElse: () => throw Exception("Room not found"),
    );

    // Check if the room is changing
    if (currentRoom.roomId != updatedResident.roomID) {
      // Mark the current room as available
      currentRoom.resident = null;
      currentRoom.isAvailable = true;

      // Find the new room by ID
      final newRoom = rooms.firstWhere(
            (room) => int.parse(room.roomId) == updatedResident.roomID,
        orElse: () => throw Exception("New Room not found"),
      );

      // Assign the resident to the new room with the correct room price
      updatedResident.roomPrice = newRoom.price * updatedResident.duration;  // Ensure correct price assignment
      newRoom.resident = updatedResident;
      newRoom.isAvailable = false;

      // Debug print to verify
      print('Updated Resident Price: ${updatedResident.roomPrice}');

      // Notify ResidentPaymentProvider and WorkerPaymentProvider
      notifyListeners(); // Notify listeners here
    } else {
      // Update the resident details in the current room
      currentRoom.resident = updatedResident;

      // Notify only ResidentPaymentProvider when resident details are updated without changing room
      notifyListeners();
    }

  }
}
