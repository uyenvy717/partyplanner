import 'package:flutter/material.dart';
import 'package:partyplanflutter/widgets/events_edit_widget.dart';

class EventsCard extends StatefulWidget {
  const EventsCard({super.key});

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    List avaImages = ['images/ava.jpeg', 'images/ava.jpeg', 'images/ava.jpeg'];

    return Container(
      margin: const EdgeInsets.all(5),
      height: 300,
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
            height: 200,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white.withOpacity(0),
              height: 150,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
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
                        width: 100,
                        height: 50,
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
                        child: const Center(
                          child: Text(
                            'Date: ',
                            style: TextStyle(
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
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [Text('Name'), Text('Location')],
                        ),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const EventsEdit();
                            }));
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
