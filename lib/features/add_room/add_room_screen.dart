import 'dart:io';

import 'package:design_pattern/core/model/room_model.dart';
import 'package:design_pattern/core/theming/styles.dart';
import 'package:design_pattern/features/add_room/widgets/dotted_image_picker.dart';
import 'package:flutter/material.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key, required List<HotelRoom> hotelRoom, required this.onAddRoom});
  final Function(HotelRoom) onAddRoom;

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  File? _image;
  final _formKey = GlobalKey<FormState>();

  // Controllers and variables to store user input
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _roomTypeController = TextEditingController();
  final TextEditingController _roomDescriptionController =
      TextEditingController();
  final TextEditingController _roomRateController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _category;
  late bool _isAvailable = true;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  // Mock category list for the dropdown
  final List<String> _categories = ['Luxury', 'Standard', 'Economy'];
  void _handleImagePicked(File? image) {
    setState(() {
      _image = image; // Store the selected image in state
    });
  }
  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = pickedDate;
        } else {
          _checkOutDate = pickedDate;
        }
      });
    }
  }
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newRoom = HotelRoom(
        roomId: _roomIdController.text,
        roomType: _roomTypeController.text,
        roomDescription: _roomDescriptionController.text,
        roomRate: double.parse(_roomRateController.text),
        isAvailable: _isAvailable,
        checkInDate: _checkInDate,
        checkOutDate: _checkOutDate,
        imagePath: 'assets/images/room img.png',
        price: double.parse(_priceController.text),
        category: _category ?? '',
      );

      widget.onAddRoom(newRoom); // Pass the new room to the callback
      Navigator.pop(context); // Close the form screen
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new)),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "Add New Room",
                      style: MyTextStyle.font18LightBlackRegular,
                    ),
                  ],
                ),
              ),
              _image != null
                  ? Image.file(
                      File(_image!.path),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : DottedImagePicker(
                   onImagePicked:_handleImagePicked,
                    ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                  child: Column(
                children: [
                  TextFormField(
                    controller: _roomIdController,
                    decoration: InputDecoration(labelText: 'Room ID'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter Room ID' : null,
                  ),
                  TextFormField(
                    controller: _roomTypeController,
                    decoration: InputDecoration(labelText: 'Room Type'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter Room Type' : null,
                  ),
                  TextFormField(
                    controller: _roomDescriptionController,
                    decoration: InputDecoration(labelText: 'Room Description'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter Room Description' : null,
                  ),
                  TextFormField(
                    controller: _roomRateController,
                    decoration: InputDecoration(labelText: 'Room Rate'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter Room Rate' : null,
                  ),
                  TextFormField(
                    controller: _capacityController,
                    decoration: InputDecoration(labelText: 'Capacity'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter Capacity' : null,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter Price' : null,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Category'),
                    value: _category,
                    items: _categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _category = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a category' : null,
                  ),
                  SwitchListTile(
                    title: Text('Available'),
                    value: _isAvailable,
                    onChanged: (value) {
                      setState(() {
                        _isAvailable = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Check-in Date: ${_checkInDate?.toIso8601String() ?? 'Not selected'}'),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text('Pick Date'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Check-out Date: ${_checkOutDate?.toIso8601String() ?? 'Not selected'}'),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, false),
                        child: Text('Pick Date'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveForm,
                    child: Text('Save Room'),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
