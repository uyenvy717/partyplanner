import 'package:flutter/material.dart';

import '../../widgets/events_card_widget.dart';
import '../utils/app_layout.dart';

class UpcommingParty extends StatefulWidget {
  const UpcommingParty({super.key});

  @override
  State<UpcommingParty> createState() => _UpcommingPartyState();
}

class _UpcommingPartyState extends State<UpcommingParty> {
  int partyCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12.withOpacity(0.03),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return const EventsDetail();
                    // }));
                  },
                  child: const EventsCard(
                    name: 'Bookshop',
                    location: 'Book store',
                    date: '12/05/2022',
                    time: '',
                    id: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
