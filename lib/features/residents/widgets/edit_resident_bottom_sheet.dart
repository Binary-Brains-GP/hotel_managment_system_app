import 'package:design_pattern/core/widgets/app_text_btn.dart';
import 'package:flutter/material.dart';
import 'package:design_pattern/core/model/resident_model.dart';
import 'package:design_pattern/core/model/room_model.dart';
import 'package:provider/provider.dart';

import '../../../core/networking/resident_payment_provider.dart';
import '../../../core/networking/room_provider.dart';

class EditResidentBottomSheet extends StatefulWidget {
  final Resident resident;
  final List<HotelRoom> availableRooms;

  const EditResidentBottomSheet({
    Key? key,
    required this.resident,
    required this.availableRooms,
  }) : super(key: key);

  @override
  _EditResidentBottomSheetState createState() =>
      _EditResidentBottomSheetState();
}

class _EditResidentBottomSheetState extends State<EditResidentBottomSheet> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  // Variable to store the selected room
  HotelRoom? _selectedRoom;

  @override
  void initState() {
    super.initState();

    // Initialize text controllers with current resident data
    _nameController.text = widget.resident.name;

    // Initialize the selected room
    if (widget.availableRooms.isEmpty) {
      _selectedRoom = null; // No available rooms
    } else {
      _selectedRoom = widget.availableRooms.firstWhere(
        (room) => room.roomId == widget.resident.roomID,
        orElse: () => widget.availableRooms.first,
      );
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nameController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_nameController.text.isEmpty ||
        _selectedRoom == null ||
        _durationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill out all fields")),
      );
      return;
    }

    final duration = int.parse(_durationController.text);

    // Update the resident details
    final updatedResident = widget.resident.copyWith(
      name: _nameController.text,
      roomID: int.parse(_selectedRoom!.roomId),
      roomType: _selectedRoom!.roomType,
      duration: duration,
    );

    // Notify the provider
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    roomProvider.updateResidentDetails(widget.resident.roomID, updatedResident);
    Provider.of<ResidentPaymentProvider>(context, listen: false)
        .editResidentPayment(widget.resident.name, widget.resident.roomPrice);
    // Close the bottom sheet
    Navigator.pop(context);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Resident details updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Edit Resident',
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 16),
            // Name input field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Resident Name'),
            ),
            SizedBox(height: 8),
            // Room selection dropdown
            DropdownButton<HotelRoom>(
              value: _selectedRoom,
              onChanged: (HotelRoom? newRoom) {
                setState(() {
                  _selectedRoom = newRoom;
                });
              },
              items: widget.availableRooms
                  .where((room) =>
                      room.resident == null ||
                      room.roomId == widget.resident.roomID)
                  .map((room) {
                return DropdownMenuItem<HotelRoom>(
                  value: room,
                  child: Text('Room ${room.roomId} - ${room.roomType}'),
                );
              }).toList(),
              hint: Text('Select a Room'),
            ),
            // Save button
            SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration (nights)'),
            ),
            SizedBox(height: 16),

            AppTextBtn(buttonText: "Save", onPressed: _saveChanges),

            SizedBox(height: 400),
          ],
        ),
      ),
    );
  }
}
