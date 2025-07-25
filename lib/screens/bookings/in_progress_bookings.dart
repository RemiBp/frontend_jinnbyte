import 'package:choice_app/customWidgets/no_item_found.dart';
import 'package:flutter/cupertino.dart';

class InProgressBookings extends StatefulWidget {
  const InProgressBookings({super.key});

  @override
  State<InProgressBookings> createState() => _InProgressBookingsState();
}

class _InProgressBookingsState extends State<InProgressBookings> {
  @override
  Widget build(BuildContext context) {
    return NoItemFound();
  }
}
