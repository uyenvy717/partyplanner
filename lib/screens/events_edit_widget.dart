import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/route/route_generator.dart';
import 'package:partyplanflutter/screens/contact_list.dart';
import 'package:partyplanflutter/utils/app_layout.dart';
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
  late ListContact _listContact;
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
              editParty(context);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppLayout.getWidth(8)),
        child: SingleChildScrollView(
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
                    Gap(AppLayout.getHeight(8)),
                    CustomTextFormField(
                      controller: _descController,
                      txtLabel: 'Description',
                    ),
                    Gap(AppLayout.getHeight(8)),
                    CustomTextFormField(
                      controller: _locationController,
                      txtLabel: 'Location',
                    ),
                    Gap(AppLayout.getHeight(8)),
                    CustomDatePickerFormField(
                      controller: _dateController,
                      txtLabel: 'Date',
                      callback: (() {
                        pickDateTime(context);
                      }),
                    ),
                    Gap(AppLayout.getHeight(8)),
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, '/contact_list', arguments: ContactArguments(contacts, widget.id,));
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => ContactList(

                    //                 contacts: contacts,
                    //                 id: widget.id,
                    //                 updateContact:
                    //                     (List<ContactDetail> newContacts) {
                    //                   updateContacts(newContacts);
                    //                 })));
                    //   },
                    //   icon: const Icon(Icons.outgoing_mail),
                    // ),
                  ],
                ),
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: contacts.length,
              //   itemBuilder: (context, index) {
              //     final contact = contacts[index];
              //     return Column(children: [
              //       ListTile(
              //         leading: const CircleAvatar(
              //           radius: 20,
              //           child: Icon(Icons.person),
              //         ),
              //         title: Text(contact.name),
              //         subtitle: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(contact.phoneNumber),
              //           ],
              //         ),
              //       ),
              //       const Divider()
              //     ]);
              //   },
              // )
            ],
          ),
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

  void editParty(BuildContext context) {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = PartyCompanion(
        id: drift.Value(widget.id),
        partyName: drift.Value(_nameController.text),
        desc: drift.Value(_descController.text),
        location: drift.Value(_locationController.text),
        date: drift.Value(
            DateFormat('dd/MM/yyyy HH:mm').parse(_dateController.text)),
      );

      _db
          .updateParty(entity)
          .then((value) => {Navigator.pushNamed(context, '/')});
    }
  }

  Future<void> getParty() async {
    _partyData = await _db.getParty(widget.id);
    _nameController.text = _partyData.partyName;
    _descController.text = _partyData.desc;
    _locationController.text = _partyData.location;
    if (_partyData.contacts == null) {
      // List<ContactDetail> list = [];
      // ListContact contacts = ListContact(list);
      _listContact = [] as ListContact;
    } else {
      _listContact = _partyData.contacts!;
    }
    _dateController.text =
        DateFormat('dd/MM/yyyy HH:mm').format(_partyData.date);
  }

  // void updateContacts(List<ContactDetail> newContacts) {
  //   setState(() {
  //     contacts = newContacts;
  //   });
  //   // print(contacts);
  // }
}
