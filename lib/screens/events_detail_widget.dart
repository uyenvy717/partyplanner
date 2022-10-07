import 'package:flutter/material.dart';
import 'package:partyplanflutter/data/db/app_db.dart';

class EventsDetail extends StatefulWidget {
  final int id;
  const EventsDetail({required this.id, Key? key}) : super(key: key);

  @override
  State<EventsDetail> createState() => _EventsDetailState();
}

class _EventsDetailState extends State<EventsDetail> {
  List avaImages = ['images/ava.jpeg', 'images/ava.jpeg', 'images/ava.jpeg'];

  late AppDb _db;
  late PartyData _partyData;

  final TextEditingController _nameController = TextEditingController();
  // String test = '', test2 = '', test3 = '', test4 = '';

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                toolbarHeight: 200,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/colors.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 5),
                      child: Text(
                        // _partyData.partyName,
                        _nameController.text,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, left: 9),
                      child: Row(
                        children: [
                          for (int i = 0; i < avaImages.length; i++)
                            Align(
                              widthFactor: 0.5,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(avaImages[i])),
                              ),
                            ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            '7+ going',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(avaImages[0])),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Name of person',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text('Organizer'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        // _partyData.desc,
                        _nameController.text,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 2),
                      child: Text(
                        'Location',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_pin),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          // _partyData.location,
                          _nameController.text,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 150),
                color: Colors.white.withOpacity(0),
                height: 150,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: SizedBox(
                            width: 20,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0x000602d3).withOpacity(0.15),
                                spreadRadius: 0.1,
                                blurRadius: 2,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              // _partyData.date.toIso8601String(),
                              _nameController.text,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getParty() async {
    _partyData = await _db.getParty(widget.id);
    // test = _partyData.partyName;
    // test2 = _partyData.desc;
    // test3 = _partyData.location;
    // test4 = _partyData.date.toIso8601String();
    _nameController.text = _partyData.partyName;
  }
}
