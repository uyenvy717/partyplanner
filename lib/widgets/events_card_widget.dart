import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:partyplanflutter/utils/app_layout.dart';

class EventsCard extends StatefulWidget {
  final String name;
  final String location;
  final String date;
  final String time;
  final int id;

  const EventsCard({
    Key? key,
    required this.name,
    required this.location,
    required this.date,
    required this.time,
    required this.id,
  }) : super(key: key);

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    List avaImages = ['images/ava.jpeg', 'images/ava.jpeg', 'images/ava.jpeg'];

    return Container(
      margin: const EdgeInsets.all(5),
      width: AppLayout.getSize(context).width * 0.8,
      height: AppLayout.getHeight(250),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: const Color(0x000602d3).withOpacity(0.15),
            spreadRadius: 0.1,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('images/colors.jpg'), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
            ),
            height: AppLayout.getHeight(150),
          ),
          /*
          information of party
          */
          Positioned(
            height: AppLayout.getHeight(200),
            width: AppLayout.getWidth(300),
            top: AppLayout.getHeight(100),
            child: Container(
              color: Colors.white.withOpacity(0),
              height: AppLayout.getHeight(100),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Gap(AppLayout.getWidth(5)),
                      Expanded(
                        child: Row(
                          children: [
                            for (int i = 0; i < avaImages.length; i++)
                              Align(
                                widthFactor: 0.5,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage(avaImages[i])),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: AppLayout.getHeight(8)),
                        width: AppLayout.getWidth(100),
                        height: AppLayout.getHeight(50),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
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
                            children: [
                              Text(
                                widget.date,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                widget.time,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(AppLayout.getHeight(5)),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name),
                            Text(widget.location),
                          ],
                        ),
                      ),
                      /*
                        Edit button
                      */
                      Container(
                        width: AppLayout.getWidth(100),
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/edit_party',
                                arguments: widget.id);
                          },
                          child: const Text('Edit'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
