import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/widgets/custom_date_picker_form_field.dart';
import 'package:partyplanflutter/widgets/custom_text_form_field.dart';
import 'package:drift/drift.dart' as drift;

class EventsAdd extends StatefulWidget {
  const EventsAdd({super.key});

  @override
  State<EventsAdd> createState() => _EventsAddState();
}

class _EventsAddState extends State<EventsAdd> {
  final _formKey = GlobalKey<FormState>();
  late AppDb _db;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _date;

  @override
  void initState() {
    super.initState();

    _db = AppDb();
  }

  @override
  void dispose() {
    _db.close();
    _nameController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Party'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addParty();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
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
                    controller: _locationController,
                    txtLabel: 'Location',
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

  void addParty() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = PartyCompanion(
        partyName: drift.Value(_nameController.text),
        desc: drift.Value(_descController.text),
        location: drift.Value(_locationController.text),
        date: drift.Value(_date!),
      );

      _db.insertParty(entity).then(
            (value) => ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                backgroundColor: Colors.deepOrange,
                content: Text(
                  'New party inserted: $value',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
    }
  }
}
