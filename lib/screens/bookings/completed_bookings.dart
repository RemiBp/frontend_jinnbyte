import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../userRole/role_provider.dart';
import '../../userRole/user_role.dart';
import 'booking_details.dart';
import 'booking_details_user.dart';
import 'bookings_widgets.dart';

class CompletedBookings extends StatefulWidget {
  const CompletedBookings({super.key});

  @override
  State<CompletedBookings> createState() => _CompletedBookingsState();
}

class _CompletedBookingsState extends State<CompletedBookings> {
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

              final name = role == UserRole.user
                  ? "Wholesome Fork #${index + 1}"   // show restaurant name if user
                  : "John Doe #${index + 1}";
              return BookingCard(
                name: name,
                imageUrl: '',
                date: '2025-08-01',
                startTime: '2025-08-01 14:00:00',
                endTime: '2025-08-01 15:30:00',
                guests: 2 + index,
                onDetails: (){
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
              );
            },
          ),
        ),
      ],
    );
  }
}
