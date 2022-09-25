import 'package:flutter/material.dart';
import 'package:partyplanflutter/widgets/events_detail_widget.dart';

import '../../widgets/events_card_widget.dart';

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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // height: double.infinity,
          // width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const EventsDetail();
                    }));
                  },
                  child: const EventsCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
