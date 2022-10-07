import 'package:flutter/material.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/widgets/events_card_widget.dart';

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
      backgroundColor: Colors.black12.withOpacity(0.03),
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
            return ListView.builder(
              itemCount: parties.length,
              itemBuilder: (context, index) {
                final party = parties[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/party_detail', arguments: party.id);
                        },
                        child: EventsCard(
                          name: party.partyName.toString(),
                          location: party.location.toString(),
                          date: party.date.toString(),
                          id: party.id,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const Text('No data found');
        },
      ),
    );
  }
}
