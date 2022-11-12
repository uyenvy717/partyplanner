import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactList extends StatefulWidget {
  const ContactList({
    required this.contacts,
    required this.id,
    required this.updateContact,
    Key? key,
  }) : super(key: key);

  final List<ContactDetail> contacts;
  final int id;
  final Function updateContact;

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select Participant'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edit_party',
                    arguments: widget.id);
              },
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          child: FutureBuilder(
            future: getContacts(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child:
                      SizedBox(height: 50, child: CircularProgressIndicator()),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Contact contact = snapshot.data[index];
                    return Column(children: [
                      ListTile(
                        leading: const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                        title: Text(contact.displayName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(contact.phones[0]),
                          ],
                        ),
                        onTap: (() {
                          ContactDetail data = ContactDetail(
                              contact.displayName, contact.phones[0]);
                          widget.contacts.add(data);

                          widget.updateContact(widget.contacts);
                        }),
                      ),
                      const Divider()
                    ]);
                  });
            },
          ),
        ),
      ),
    );
  }

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return await FastContacts.allContacts;
    }
    return [];
  }
}