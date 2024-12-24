import 'package:design_pattern/core/networking/resident_payment_provider.dart';
import 'package:design_pattern/core/widgets/app_text_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/model/resident_model.dart';
import '../../../core/model/room_model.dart';
import '../../../core/networking/room_provider.dart';
import '../../../core/theming/styles.dart';

class BookingForm extends StatefulWidget {
  final HotelRoom hotelRoom;

  const BookingForm({Key? key, required this.hotelRoom}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  int? duration;
  DateTime? checkOutDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 400 // Adjusts for the keyboard
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Book Room: ${widget.hotelRoom.roomId}",
                style: MyTextStyle.font16MainBrownRegular,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter a name" : null,
                onSaved: (value) => name = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: "Duration (nights)"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a duration";
                  }
                  if (int.tryParse(value) == null) {
                    return "Enter a valid number";
                  }
                  return null;
                },
                onSaved: (value) => duration = int.parse(value!),
              ),
              SizedBox(height: 16),
              AppTextBtn(
                buttonText: "Confirm Booking",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Calculate check-out date
                    final checkInDate = DateTime.now();
                    checkOutDate = checkInDate.add(Duration(days: duration!));

                    // Create a new resident
                    final resident = ResidentBuilder()
                        .setName(name!)
                        .setRoomID(int.parse(widget.hotelRoom.roomId))
                        .setRoomType(widget.hotelRoom.roomType)
                        .setDuration(duration!)
                        .setCheckIn(checkInDate)
                        .setCheckOut(checkOutDate!)
                        .setRoomPrice(widget.hotelRoom.price * duration!)
                        .build();

                    // Update state via Provider
                    Provider.of<RoomProvider>(context, listen: false)
                        .bookRoom(widget.hotelRoom.roomId, resident);
                    Provider.of<ResidentPaymentProvider>(context,listen:false).addPayment(resident);

                    // Close the bottom sheet
                    Navigator.pop(context);

                    // Optionally show a confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Room booked successfully!")),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
