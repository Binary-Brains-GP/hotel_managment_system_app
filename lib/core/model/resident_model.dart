class Resident {
  int roomID;
  String name;
  String roomType;
  int duration;
  DateTime checkIn;
  DateTime checkOut;
  double roomPrice;
  List<BoardingOption> boardingOptions; // List of extra services

  Resident._({
    required this.roomID,
    required this.name,
    required this.roomType,
    required this.duration,
    required this.checkIn,
    required this.checkOut,
    required this.roomPrice,
    this.boardingOptions = const [], // Default to empty list
  });

  // Calculate total price, including boarding options
  double get totalPrice {
    final extrasCost = boardingOptions.fold(0.0, (sum, option) => sum + option.cost);
    return roomPrice + extrasCost;
  }

  Resident copyWith({
    String? name,
    int? roomID,
    String? roomType,
    int? duration,
    DateTime? checkIn,
    DateTime? checkOut,
    double? roomPrice,
    List<BoardingOption>? boardingOptions,
  }) {
    return Resident._(
      roomID: roomID ?? this.roomID,
      name: name ?? this.name,
      roomType: roomType ?? this.roomType,
      duration: duration ?? this.duration,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      roomPrice: roomPrice ?? this.roomPrice,
      boardingOptions: boardingOptions ?? this.boardingOptions,
    );
  }

  factory Resident.builder() => ResidentBuilder().build();

  static List<Resident> getResidents() {
    return [
      ResidentBuilder()
          .setRoomID(101)
          .setName("John Doe")
          .setRoomType("Deluxe")
          .setDuration(5)
          .setCheckIn(DateTime(2024, 12, 1))
          .setCheckOut(DateTime(2024, 12, 6))
          .setRoomPrice(120.0)
          .addBoardingOption(BoardingOption(name: "Breakfast", cost: 20.0))
          .build(),
      ResidentBuilder()
          .setRoomID(102)
          .setName("Jane Smith")
          .setRoomType("Standard")
          .setDuration(3)
          .setCheckIn(DateTime(2024, 12, 2))
          .setCheckOut(DateTime(2024, 12, 5))
          .setRoomPrice(80.0)
          .addBoardingOption(BoardingOption(name: "Gym Access", cost: 15.0))
          .build(),
    ];
  }
}

class BoardingOption {
  final String name;
  final double cost;

  BoardingOption({
    required this.name,
    required this.cost,
  });
}

class ResidentBuilder {
  int _roomId = 0;
  String _name = '';
  String _roomType = '';
  int _duration = 0;
  DateTime _checkIn = DateTime.now();
  DateTime _checkOut = DateTime.now();
  double _roomPrice = 0.0;
  List<BoardingOption> _boardingOptions = [];

  ResidentBuilder setName(String name) {
    _name = name;
    return this;
  }

  ResidentBuilder setRoomType(String roomType) {
    _roomType = roomType;
    return this;
  }

  ResidentBuilder setDuration(int duration) {
    _duration = duration;
    return this;
  }

  ResidentBuilder setCheckIn(DateTime checkIn) {
    _checkIn = checkIn;
    return this;
  }

  ResidentBuilder setCheckOut(DateTime checkOut) {
    _checkOut = checkOut;
    return this;
  }

  ResidentBuilder setRoomPrice(double roomPrice) {
    _roomPrice = roomPrice;
    return this;
  }

  ResidentBuilder setRoomID(int roomID) {
    _roomId = roomID;
    return this;
  }

  ResidentBuilder addBoardingOption(BoardingOption option) {
    _boardingOptions.add(option);
    return this;
  }

  Resident build() => Resident._(
    roomID: _roomId,
    name: _name,
    roomType: _roomType,
    duration: _duration,
    checkIn: _checkIn,
    checkOut: _checkOut,
    roomPrice: _roomPrice,
    boardingOptions: _boardingOptions,
  );
}
