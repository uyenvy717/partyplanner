import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/widgets/events_card_widget.dart';
import '../utils/app_layout.dart';

class ExpiredParty extends StatefulWidget {
  const ExpiredParty({super.key});

  @override
  State<ExpiredParty> createState() => _ExpiredPartyState();
}

class _ExpiredPartyState extends State<ExpiredParty> {
  late AppDb _db;

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
      backgroundColor: Colors.white,
      body: FutureBuilder<List<PartyData>>(
        future: _db.getParties(),
        builder: (context, snapshot) {
          final List<PartyData>? parties = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (parties != null) {
            return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppLayout.getWidth(10)),
                      height: AppLayout.getHeight(100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(AppLayout.getHeight(7)),
                            padding:
                                EdgeInsets.only(top: AppLayout.getHeight(30)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage('images/ava.jpeg')),
                                ),
                                Gap(AppLayout.getWidth(3)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Good morning",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Gap(AppLayout.getWidth(3)),
                                        const Icon(Icons.waving_hand_outlined)
                                      ],
                                    ),
                                    const Text(
                                      "Andrew Ainsley",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          /**Notification */
                          Container(
                            margin: EdgeInsets.only(
                                right: AppLayout.getWidth(10),
                                top: AppLayout.getHeight(20)),
                            height: AppLayout.getWidth(30),
                            width: AppLayout.getWidth(30),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                shape: BoxShape.circle),
                            child: const Icon(Icons.notifications_none),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: parties.length,
                      itemBuilder: (context, index) {
                        final party = parties[index];
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppLayout.getWidth(20)),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/party_detail',
                                      arguments: party.id);
                                  print(party.id);
                                },
                                child: EventsCard(
                                  name: party.partyName.toString(),
                                  location: party.location.toString(),
                                  date: DateFormat('MMM d').format(party.date),
                                  time: DateFormat('h:mm a').format(party.date),
                                  id: party.id,
                                ),
                              ),
                              Gap(AppLayout.getHeight(8)),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ));
          }

          return const Text('No data found');
        },
      ),
    );
  }
}
