import 'package:choice_app/screens/bookings/booking_details.dart';
import 'package:choice_app/screens/bookings/booking_details_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../customWidgets/blurry_back_ground.dart';
import '../../userRole/role_provider.dart';
import '../../userRole/user_role.dart';
import 'bookings_widgets.dart';

class UpcomingBookings extends StatefulWidget {
  const UpcomingBookings({super.key});

  @override
  State<UpcomingBookings> createState() => _UpcomingBookingsState();
}

class _UpcomingBookingsState extends State<UpcomingBookings> {
  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 16),
              itemCount: 5, // Number of dummy bookings
              itemBuilder: (context, index) {
                final role = context.read<RoleProvider>().role;

                //  Conditionally assign name
                final name = role == UserRole.user
                    ? "Wholesome Fork #${index + 1}"   // show restaurant name if user
                    : "John Doe #${index + 1}";         // show customer name otherwise
                return BookingCard(
                  name: name,
                  imageUrl: '',
                  date: '2025-08-01',
                  startTime: '2025-08-01 14:00:00',
                  endTime: '2025-08-01 15:30:00',
                  guests: 2 + index,
                  onDetails: () {
                    if (role == UserRole.user) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UserBookingDetails()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookingDetails()),
                      );
                    }
                  },
                  onCheckIn: () {},
                  onCancel: () {
                    showCancelConfirmationAlert(context: context, id: 0);
                  },
                );
              },
            ),
        ),
      ],
    );
  }

  void showCancelConfirmationAlert({required BuildContext context, required int id}) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return BlurryBackground(
          child: CancelConfirmationAlert(
            controller: reasonController,
            onConfirm: () async{},
          ),
        );
      },
    );
  }
}
