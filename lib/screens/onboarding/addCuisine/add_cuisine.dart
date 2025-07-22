import 'package:flutter/material.dart';
import '../../../customWidgets/custom_drop_down.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/text_field_label.dart';
import '../../../res/res.dart';

class CuisineType {
  final int id;
  final String name;

  CuisineType({required this.id, required this.name});
}

class AddCuisine extends StatefulWidget {
  const AddCuisine({super.key});

  @override
  State<AddCuisine> createState() => _AddCuisineState();
}

class _AddCuisineState extends State<AddCuisine> {
  int? selectedCuisineId;
  CuisineType? selectedCuisine;

  final List<CuisineType> dummyCuisineTypes = [
    CuisineType(id: 1, name: 'Italian'),
    CuisineType(id: 2, name: 'Chinese'),
    CuisineType(id: 3, name: 'Mexican'),
    CuisineType(id: 4, name: 'Indian'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth() * .05,
            vertical: getHeight() * .1,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextFieldLabel(
              label: "Slot Duration",
            ),
            CustomDropdown(
              items: [
                CuisineType(id: 1, name: 'Italian'),
                CuisineType(id: 2, name: 'Chinese'),
                CuisineType(id: 3, name: 'Mexican'),
              ].map((c) {
                return DropdownMenuItem<int>(
                  value: c.id,
                  child: CustomText(
                    text: c.name,
                    fontWeight: FontWeight.w400,
                    fontSize: sizes?.fontSize16,
                    lines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              selectedValue: selectedCuisineId,
              hintText: 'Select cuisine type',
              onChanged: (id) {
                setState(() {
                  selectedCuisineId = id!;
                  selectedCuisine = [
                    CuisineType(id: 1, name: 'Italian'),
                    CuisineType(id: 2, name: 'Chinese'),
                    CuisineType(id: 3, name: 'Mexican'),
                  ].firstWhere((c) => c.id == id);
                });
              },
              validator: (id) => id == null ? 'Please select cuisine type' : null,
            )
          ],
        ),
      ),
    );
  }
}
