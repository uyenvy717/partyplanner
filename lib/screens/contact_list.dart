// import 'package:fast_contacts/fast_contacts.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ContactList extends StatefulWidget {
//   const ContactList({super.key});

//   @override
//   State<ContactList> createState() => _ContactListState();
// }

// class _ContactListState extends State<ContactList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[100],
//       height: double.infinity,
//       child: FutureBuilder(
//         future: getContacts(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return const Center(
//               child: SizedBox(
//                 height: 50,
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }

//           return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 Contact contact = snapshot.data[index];
//                 return ListTile(
//                   title: Text(contact.displayName),
//                   subtitle: Column(children: [
//                     Text(contact.phones[0]),
//                     Text(contact.emails[0]),
//                   ]),
//                 );
//               });
//         },
//       ),
//     );
//   }

//   Future<List<Contact>> getContacts() async {
//     bool isGranted = await Permission.contacts.status.isGranted;

//     if (!isGranted) {
//       await Permission.contacts.request().isGranted;
//     }
//     if (isGranted) {
//       return await FastContacts.allContacts;
//     }
//     return [];
//   }
// }
