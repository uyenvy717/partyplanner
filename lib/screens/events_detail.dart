import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/route/route_generator.dart';
import 'package:partyplanflutter/utils/app_layout.dart';
import 'package:partyplanflutter/widgets/icon_button_widget.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../widgets/icon_widget.dart';

class EventsDetail extends StatefulWidget {
  final int id;
  const EventsDetail({required this.id, Key? key}) : super(key: key);

  @override
  State<EventsDetail> createState() => _EventsDetailState();
}

class _EventsDetailState extends State<EventsDetail> {
  List avaImages = ['images/ava.jpeg', 'images/ava.jpeg', 'images/ava.jpeg'];
  final ValueNotifier<bool> _notifier = ValueNotifier(false);

  late AppDb _db;
  late PartyData _partyData;
  late String _name, _desc, _location, _date, _time;
  late ListContact _listContact;

  @override
  void initState() {
    super.initState();
    _db = AppDb();
    getParty();
  }

  @override
  void dispose() {
    _notifier.dispose();
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /**Cover and information */
          SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /**Cover */
                Container(
                  height: AppLayout.getSize(context).height * 0.42,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/colors.jpg'),
                        fit: BoxFit.fitHeight),
                  ),
                ),
                Gap(AppLayout.getHeight(20)),
                /**Information */
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(AppLayout.getHeight(10)),
                      Container(
                        margin: EdgeInsets.only(left: AppLayout.getWidth(10)),
                        child: Row(
                          children: [
                            for (int i = 0; i < avaImages.length; i++)
                              Align(
                                widthFactor: 0.5,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundImage:
                                          AssetImage(avaImages[i])),
                                ),
                              ),
                            Gap(AppLayout.getWidth(20)),

                            ValueListenableBuilder(
                                valueListenable: _notifier,
                                builder: (context, bool val, Widget? child) {
                                  return Text(
                                    '${_listContact.listContact.length} going',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  );
                                }),

                            // Gap(AppLayout.getWidth(5)),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/contact_list',
                                    arguments: ContactArguments(
                                        _listContact.listContact,
                                        widget.id,
                                        _notifier));
                              },
                              iconSize: 15,
                              icon: const Icon(Icons.arrow_forward_rounded),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.1,
                        color: Colors.black12,
                      ),
                      Gap(AppLayout.getHeight(5)),
                      /**Details */
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              /**Icon */
                              const IconWidget(name: Icons.calendar_month),
                              Gap(AppLayout.getWidth(10)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _date,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Gap(AppLayout.getHeight(2)),
                                  Text(
                                    _time,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          /**Add to calendar */
                          Container(
                            margin:
                                EdgeInsets.only(left: AppLayout.getWidth(40)),
                            width: AppLayout.getWidth(200),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              onPressed: addCalendar,
                              child: const Text('Add to the Calendar'),
                            ),
                          ),
                          Gap(AppLayout.getHeight(5)),
                          Row(
                            children: [
                              /**Icon */
                              const IconWidget(name: Icons.location_on),
                              Gap(AppLayout.getWidth(10)),
                              Text(
                                _location,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Gap(AppLayout.getHeight(10)),
                          Row(
                            children: [
                              /**Icon */
                              const IconWidget(
                                  name: Icons.description_outlined),
                              Gap(AppLayout.getWidth(10)),
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Gap(AppLayout.getHeight(2)),
                            ],
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: AppLayout.getWidth(63)),
                            child: Text(
                              _desc,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: AppLayout.getSize(context).height * 0.043,
            left: AppLayout.getSize(context).width * 0.015,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            top: AppLayout.getSize(context).height * 0.043,
            right: AppLayout.getSize(context).width * 0.03,
            child: Column(
              children: [
                IconButtonWidget(
                  name: Icons.edit,
                  callBack: () {
                    Navigator.pushNamed(context, '/edit_party',
                        arguments: widget.id);
                  },
                ),
                Gap(AppLayout.getHeight(5)),
                IconButtonWidget(
                  name: Icons.email,
                  callBack: () {
                    sendEmail();
                  },
                ),
                Gap(AppLayout.getHeight(5)),
                IconButtonWidget(
                  name: Icons.delete,
                  callBack: () {
                    deleteParty(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> getParty() async {
    _partyData = await _db.getParty(widget.id);
    print(_partyData.contacts?.listContact.length);
    setState(() {
      _name = _partyData.partyName;
      _desc = _partyData.desc;
      _location = _partyData.location;
      if (_partyData.contacts == null) {
        List<ContactDetail> list = [];
        ListContact contacts = ListContact(list);
        _listContact = contacts;
      } else {
        _listContact = _partyData.contacts!;
      }
      _date =
          '${DateFormat.EEEE('en_US').format(_partyData.date)}, ${DateFormat.yMMMMd('en_US').format(_partyData.date)}';
      _time = DateFormat('h:mm a').format(_partyData.date);
    });
  }

  void addCalendar() {
    final event = Event(
      title: _name,
      description: '$_desc at ${DateFormat('HH:mm a').format(_partyData.date)}',
      location: _location,
      startDate: DateTime(_partyData.date.year, _partyData.date.month,
          _partyData.date.day, _partyData.date.hour, _partyData.date.minute),
      endDate: DateTime(
          _partyData.date.year,
          _partyData.date.month,
          _partyData.date.day,
          _partyData.date.hour,
          _partyData.date.minute + 30),
      iosParams: const IOSParams(reminder: Duration(minutes: 30)),
      androidParams: const AndroidParams(emailInvites: []),
    );

    Add2Calendar.addEvent2Cal(event);
  }

  void deleteParty(BuildContext context) {
    _db.deleteParty(widget.id).then((value) => {
          Navigator.pushNamed(
            context,
            '/',
          )
        });
  }

  void sendEmail() {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['zyzyvy710@gmail.com'],
      isHTML: false,
    );

    FlutterEmailSender.send(email);
  }
}
