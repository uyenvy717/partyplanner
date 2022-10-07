import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/widgets/custom_date_picker_form_field.dart';
import 'package:partyplanflutter/widgets/custom_text_form_field.dart';
import 'package:drift/drift.dart' as drift;

class EventsEdit extends StatefulWidget {
  final int id;
  const EventsEdit({required this.id, Key? key}) : super(key: key);

  @override
  State<EventsEdit> createState() => _EventsEditState();
}

class _EventsEditState extends State<EventsEdit> {
  final _formKey = GlobalKey<FormState>();

  late AppDb _db;
  late PartyData _partyData;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _date;

  @override
  void initState() {
    super.initState();

    _db = AppDb();
    getParty();
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
        title: const Text('Edit Party'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              editParty();
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              deleteParty();
            },
            icon: const Icon(Icons.delete),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(
                    height: 8,
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/contact_list');
                  //   },
                  //   icon: const Icon(Icons.outgoing_mail),
                  // ),
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

  void editParty() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = PartyCompanion(
        id: drift.Value(widget.id),
        partyName: drift.Value(_nameController.text),
        desc: drift.Value(_descController.text),
        location: drift.Value(_locationController.text),
        date: drift.Value(_date!),
      );

      _db.updateParty(entity).then(
            (value) => ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                backgroundColor: Colors.deepOrange,
                content: Text(
                  'Party updated: $value',
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

  void deleteParty() {
    _db.deleteParty(widget.id).then(
          (value) => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.deepOrange,
              content: Text(
                'Party deleted: $value',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
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

  Future<void> getParty() async {
    _partyData = await _db.getParty(widget.id);
    _nameController.text = _partyData.partyName;
    _descController.text = _partyData.desc;
    _locationController.text = _partyData.location;
    _dateController.text = _partyData.date.toIso8601String();
  }
}
