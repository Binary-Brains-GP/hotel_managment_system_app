import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../core/adapter/currency_converter.dart';
import '../../../core/adapter/euro_converter.dart';
import '../../../core/adapter/usd_converter.dart';
import '../../../core/model/resident_model.dart';
import '../../../core/networking/provider.dart';
import '../../../core/networking/resident_payment_provider.dart';
import '../../../core/networking/room_provider.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import 'edit_resident_bottom_sheet.dart';

class ResidentCard extends StatefulWidget {
  final Resident resident;

  const ResidentCard({Key? key, required this.resident}) : super(key: key);

  @override
  State<ResidentCard> createState() => _ResidentCardState();
}

class _ResidentCardState extends State<ResidentCard> {
  String? userRole; // Holds the user role
  bool isLoading = true; // Tracks loading state

  // Fetch the user role
  Future<void> _fetchUserRole() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final userData = await userProvider.getUserData();
      setState(() {
        userRole = userData?.role;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  // Show the ModalBottomSheet to edit resident details
  void _openEditBottomSheet(BuildContext context, Resident resident) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    final availableRooms = roomProvider.getAvailableRooms(); // Get dynamically available rooms
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditResidentBottomSheet(
          resident: resident,
          availableRooms: availableRooms,
        );
      },
    );
  }

  // Show a confirmation dialog for checking out
  void _showDialogCheckOut(BuildContext context, Resident resident) {
    String selectedCurrency = 'USD'; // Default currency
    double convertedPrice = resident.totalPrice; // Includes boarding options
    final CurrencyConverter usdConverter = USDConverter();
    final CurrencyConverter euroConverter = EuroConverter();

    // Available boarding options
    final List<BoardingOption> availableBoardingOptions = [
      BoardingOption(name: 'Laundry Service', cost: 10.0),
      BoardingOption(name: 'Room Cleaning', cost: 15.0),
      BoardingOption(name: 'Breakfast', cost: 20.0),
    ];

    final List<BoardingOption> selectedBoardingOptions = [];

    void updatePrice() {
      double boardingTotal = selectedBoardingOptions.fold(
        0.0,
            (sum, option) => sum + option.cost,
      );
      double basePrice = resident.roomPrice + boardingTotal;

      if (selectedCurrency == 'USD') {
        convertedPrice = usdConverter.convert(basePrice);
      } else if (selectedCurrency == 'Euro') {
        convertedPrice = euroConverter.convert(basePrice);
      }
    }

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: MyColors.myVeryLightBrown,
          title: Text("Check Out"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Currency Selection Dropdown
              DropdownButton<String>(
                value: selectedCurrency,
                items: ['USD', 'Euro']
                    .map((currency) => DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                    updatePrice();
                  });
                },
              ),
              SizedBox(height: 10),

              // Boarding Services Dropdown
              DropdownButton<BoardingOption>(
                hint: Text("Select a boarding service"),
                items: availableBoardingOptions
                    .map(
                      (option) => DropdownMenuItem(
                    value: option,
                    child: Text("${option.name} (\$${option.cost})"),
                  ),
                )
                    .toList(),
                onChanged: (selectedOption) {
                  if (selectedOption != null &&
                      !selectedBoardingOptions.contains(selectedOption)) {
                    setState(() {
                      selectedBoardingOptions.add(selectedOption);
                      updatePrice(); // Recalculate total price
                    });
                  }
                },
              ),
              SizedBox(height: 10),

              // Selected Boarding Options
              if (selectedBoardingOptions.isNotEmpty) ...[
                Text("Selected Services:"),
                ...selectedBoardingOptions.map(
                      (option) => ListTile(
                    title: Text(option.name),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                          selectedBoardingOptions.remove(option);
                          updatePrice(); // Recalculate total price
                        });
                      },
                    ),
                  ),
                ),
                Divider(),
              ],

              // Display Total Price
              Text(
                "Total fees: ${convertedPrice.toStringAsFixed(2)} $selectedCurrency",
                textAlign: TextAlign.center,
                style: MyTextStyle.font18LightBlackRegular,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add the payment to cumulative income
                resident.boardingOptions.addAll(selectedBoardingOptions);
                Provider.of<ResidentPaymentProvider>(context, listen: false)
                    .addPayment(resident);

                // Remove the resident and update the room status
                final paymentProvider =
                Provider.of<ResidentPaymentProvider>(context, listen: false);
                paymentProvider.removePayment(resident.name);

                final roomProvider =
                Provider.of<RoomProvider>(context, listen: false);
                roomProvider.updateRoomAvailability(
                    resident.roomID.toString(), true);
                roomProvider.removeResidentFromRoom(resident.roomID.toString());

                Navigator.of(ctx).pop(); // Close dialog
              },
              child: Text('OK', style: MyTextStyle.font18LightBlackRegular),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(), // Close dialog
              child: Text('Cancel', style: MyTextStyle.font18LightBlackRegular),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchUserRole(); // Fetch the user role on initialization
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userRole == 'admin'
          ? null
          : () => _openEditBottomSheet(context, widget.resident), // Disable interaction for admin
      onLongPress: userRole == 'admin'
          ? null
          : () => _showDialogCheckOut(context, widget.resident), // Disable interaction for admin
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.resident.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Room: ${widget.resident.roomType} (${widget.resident.roomID})'),
              Text("Duration: ${widget.resident.duration} days"),
              Row(
                children: [
                  Text('Check-In:'),
                  Text('Check-In: ${widget.resident.checkIn.toLocal()}'.split(' ')[1]),
                ],
              ),
              Row(
                children: [
                  Text('Check-Out:'),
                  Text('Check-Out: ${widget.resident.checkOut.toLocal()}'.split(' ')[1]),
                ],
              ),
              Text('Price: \$${widget.resident.roomPrice.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
