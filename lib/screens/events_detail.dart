import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/utils/app_layout.dart';

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
  late String _name, _desc, _location, _date, _time;

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
      body: Stack(
        children: [
          /**Cover and information */
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: AppLayout.getSize(context).height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/colors.jpg'),
                      fit: BoxFit.fitHeight),
                ),
              ),
              Gap(AppLayout.getHeight(25)),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10)),
                child: Text(
                  _name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(15)),
              Container(
                margin: EdgeInsets.only(left: AppLayout.getWidth(20)),
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
                    Gap(AppLayout.getWidth(20)),
                    const Text(
                      '7+ going',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Gap(AppLayout.getWidth(10)),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Gap(AppLayout.getHeight(15)),
              Container(
                margin: EdgeInsets.only(left: AppLayout.getWidth(10)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(avaImages[0])),
                    ),
                    Gap(AppLayout.getWidth(2)),
                    Column(
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
                  ],
                ),
              ),
              Gap(AppLayout.getHeight(15)),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Gap(AppLayout.getHeight(5)),
                    Text(
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      _desc,
                    ),
                    Gap(AppLayout.getHeight(5)),
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Gap(AppLayout.getHeight(5)),
                    Row(
                      children: [
                        const Icon(Icons.location_pin),
                        Gap(AppLayout.getWidth(5)),
                        Text(
                          _location,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          /**Date & time */
          Positioned(
            top: AppLayout.getSize(context).height * 0.35,
            left: AppLayout.getSize(context).width * 0.65,
            child: Container(
              height: AppLayout.getHeight(60),
              width: AppLayout.getWidth(100),
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF).withOpacity(0.95),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x000602d3).withOpacity(0.15),
                    spreadRadius: 0.1,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _date,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      _time,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getParty() async {
    _partyData = await _db.getParty(widget.id);
    setState(() {
      _name = _partyData.partyName;
      _desc = _partyData.desc;
      _location = _partyData.location;
      _date = DateFormat('MMM d').format(_partyData.date);
      _time = DateFormat('h:mm a').format(_partyData.date);
    });
  }
}
