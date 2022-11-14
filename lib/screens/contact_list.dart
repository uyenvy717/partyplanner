import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/route/route_generator.dart';
import 'package:partyplanflutter/utils/app_layout.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactList extends StatefulWidget {
  const ContactList({
    required this.args,
    Key? key,
  }) : super(key: key);

  final ContactArguments args;

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late AppDb _db;
  List<ContactDetail> temp = [];
  // ListContact temp1 = ListContact(temp);

  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: FutureBuilder(
          future: getContacts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                  child:
                      SizedBox(height: 50, child: CircularProgressIndicator()));
            }
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: AppLayout.getHeight(35)),
                      height: AppLayout.getSize(context).height * 0.04,
                      alignment: Alignment.center,
                      child: const Text('Select Participant',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold))),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Contact contact = snapshot.data[index];
                        return Column(children: [
                          ListTile(
                              leading: const CircleAvatar(
                                  radius: 20, child: Icon(Icons.person)),
                              title: Text(contact.displayName),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(contact.phones[0])]),
                              onTap: (() {
                                ContactDetail data = ContactDetail(
                                    contact.displayName, contact.phones[0]);
                                temp.add(data);
                              })),
                          const Divider()
                        ]);
                      }),
                  Container(
                    width: AppLayout.getWidth(200),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () {
                        ListContact tempList = ListContact(temp);
                        _db.updateGuest(tempList, widget.args.id);
                        Navigator.pushNamed(context, '/party_detail',
                            arguments: widget.args.id);
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            );
          },
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
