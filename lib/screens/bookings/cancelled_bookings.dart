import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'booking_details.dart';
import 'bookings_widgets.dart';

class CancelledBookings extends StatefulWidget {
  const CancelledBookings({super.key});

  @override
  State<CancelledBookings> createState() => _CancelledBookingsState();
}

class _CancelledBookingsState extends State<CancelledBookings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 16),
            itemCount: 5, // Number of dummy bookings
            itemBuilder: (context, index) {
              return BookingCard(
                name: 'John Doe #${index + 1}',
                imageUrl: '',
                date: '2025-08-01',
                startTime: '2025-08-01 14:00:00',
                endTime: '2025-08-01 15:30:00',
                guests: 2 + index,
                onDetails: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookingDetails(isCancelled: true,)),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
