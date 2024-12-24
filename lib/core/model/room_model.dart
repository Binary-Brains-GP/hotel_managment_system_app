import 'package:design_pattern/core/model/resident_model.dart';

class HotelRoom {
  final String roomId; // Unique identifier for the room
  String roomType; // Type of room (e.g., Single, Double, Suite)
  String roomDescription; // Short description of the room
  double roomRate; // The rate for the room per night
  bool isAvailable;
  DateTime? checkInDate; // Date the room is booked from
  DateTime? checkOutDate; // Date the room is booked until
  String imagePath; // Path to the room image
  double price; // Price of the room
  String category;
  Resident? resident; // Details of the resident (optional)

  // Constructor
  HotelRoom(
      {required this.roomId,
      required this.roomType,
      required this.roomDescription,
      required this.roomRate,
      required this.isAvailable,
      this.checkInDate,
      this.checkOutDate,
      this.resident,
      required this.imagePath,
      required this.price,
      required this.category});

  // Static method to get a list of rooms


  String toString() {
    return 'HotelRoom(roomId: $roomId, roomType: $roomType, resident: ${resident?.name ?? "None"})';
  }
  HotelRoom clone(String newRoomId) {
    return HotelRoom(
      roomId: newRoomId,
      roomType: this.roomType,
      roomDescription: this.roomDescription,
      roomRate: this.roomRate,
      isAvailable: this.isAvailable,
      imagePath: this.imagePath,
      price: this.price,
      category: this.category,
    );
  }

  static List<HotelRoom> getRooms() {
    List<Resident> residents = Resident.getResidents();

    return [
      HotelRoom(
        roomId: '101',
        roomType: 'Single',
        roomDescription: "Basic Comfort: A simple yet functional room with a double bed, a nightstand, and a closet. The room has a small desk for studying, and the amenities include a shared bathroom with showers. This room is ideal for those who want to experience basic comfort without breaking the bank.",
        roomRate: 4,
        isAvailable: false,
        imagePath: 'assets/images/room img.png',
        price: 41.0,
        category: 'Economy',
        resident: residents.where((residents) => residents.roomID.toString()=='101').firstOrNull
      ),
      HotelRoom(
        roomId: '102',
        roomType: 'Double',
        roomDescription: "Compact Space: A compact room with two beds, a small desk, and a chair. The room has limited storage space, but it's perfect for solo travelers or couples on a tight budget.",
        roomRate: 4.1,
        isAvailable: true,
        imagePath: 'assets/images/room img.png',
        price: 45.0,
        category: 'Economy',
      ),
      HotelRoom(
        roomId: '103',
        roomType: 'Suite',
        roomDescription: "Room with a View: A standard-sized room with a queen bed, a large window, and a comfortable chair. The room also features a flat-screen TV and a mini-fridge. This room is perfect for those who want to enjoy the outdoors without sacrificing comfort.",
        roomRate: 3.7,
        isAvailable: true,
        imagePath: 'assets/images/room img.png',
        category: 'Economy',
        price: 37.0,
      ),
      HotelRoom(
        roomId: '104',
        roomType: 'Single',
        roomDescription:
            "Cozy Room: A compact, budget-friendly room with a queen-sized bed, a small desk, and a comfortable chair. The walls are adorned with colorful posters, and there's a small TV for entertainment. This room is perfect for students or travelers on a tight budget.",
        roomRate: 4.6,
        category: 'Standard',
        isAvailable: true,
        imagePath: 'assets/images/room img.png',
        price: 55.0,
      ),
      HotelRoom(
        roomId: '105',
        roomType: 'Double',
        roomDescription: "Room with a View: A standard-sized room with a queen bed, a large window, and a comfortable chair. The room also features a flat-screen TV and a mini-fridge. This room is perfect for those who want to enjoy the outdoors without sacrificing comfort.",
        roomRate: 4.5,
        category: 'Luxury',
        isAvailable: true,
        imagePath: 'assets/images/room img.png',
        price: 90.0,
      ),
      HotelRoom(
        roomId: '106',
        roomType: 'Suite',
        roomDescription:
            "Private Suite: A luxurious suite with two bedrooms, a living area, and a private balcony. Each bedroom has its own en-suite bathroom, and there's a shared butler service available 24/7. This room is perfect for those who want to experience luxury without sacrificing space.",
        roomRate: 3.9,
        category: 'Standard',
        isAvailable: true,
        imagePath: 'assets/images/room img.png',
        price: 71.0,
      ),
    ];
  }
}
