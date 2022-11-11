import 'package:add_2_calendar/add_2_calendar.dart';
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
                      pickDateTime(context);
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

  Future pickDateTime(BuildContext context) async {
    DateTime? date = await pickDate(context);
    if (date == null) return;

    // ignore: use_build_context_synchronously
    TimeOfDay? time = await pickTime(context);
    if (time == null) return;

    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    setState(() {
      _date = dateTime;
      String newDateTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
      _dateController.text = newDateTime;
    });
  }

  Future<DateTime?> pickDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: _date ?? DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 18, 106, 125),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? const Text(''),
        ),
      );

  Future<TimeOfDay?> pickTime(BuildContext context) => showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
        builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 18, 106, 125),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? const Text(''),
        ),
      );

  void addParty() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = PartyCompanion(
        partyName: drift.Value(_nameController.text),
        desc: drift.Value(_descController.text),
        location: drift.Value(_locationController.text),
        date: drift.Value(_date!),
      );

      _db.insertParty(entity);

      final event = Event(
        title: _nameController.text,
        description:
            '${_descController.text} at ${DateFormat('HH:mm a').format(_date!)}',
        location: _locationController.text,
        startDate: DateTime(
            _date!.year, _date!.month, _date!.day, _date!.hour, _date!.minute),
        endDate: DateTime(_date!.year, _date!.month, _date!.day, _date!.hour,
            _date!.minute + 30),
        iosParams: const IOSParams(reminder: Duration(minutes: 30)),
        androidParams: const AndroidParams(emailInvites: []),
      );

      Add2Calendar.addEvent2Cal(event);

      Navigator.pushNamed(
        context,
        '/',
      );
    }
  }
}
