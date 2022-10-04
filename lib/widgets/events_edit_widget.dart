import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partyplanflutter/widgets/custom_date_picker_form_field.dart';
import 'package:partyplanflutter/widgets/custom_text_form_field.dart';

class EventsEdit extends StatefulWidget {
  const EventsEdit({super.key});

  @override
  State<EventsEdit> createState() => _EventsEditState();
}

class _EventsEditState extends State<EventsEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _localController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Party'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextFormField(
              controller: _nameController,
              txtLabel: 'Party name',
            ),
            const SizedBox(
              height: 8,
            ),
            CustomTextFormField(
              controller: _descController,
              txtLabel: 'Description',
            ),
            const SizedBox(
              height: 8,
            ),
            CustomTextFormField(
              controller: _localController,
              txtLabel: 'Local',
            ),
            const SizedBox(
              height: 8,
            ),
            CustomDatePickerFormField(
              controller: _dateController,
              txtLabel: 'Date',
              callback: (() {
                pickDate(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.pink,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? const Text(''),
      ),
    );

    if (newDate == null) {
      return;
    }

    setState(() {
      _date = newDate;
      String date = DateFormat('dd/MM/yyyy').format(newDate);
      _dateController.text = date;
    });
  }
}
