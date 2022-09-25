import 'package:flutter/material.dart';

class EventsDetail extends StatefulWidget {
  const EventsDetail({super.key});

  @override
  State<EventsDetail> createState() => _EventsDetailState();
}

class _EventsDetailState extends State<EventsDetail> {
  List avaImages = ['images/ava.jpeg', 'images/ava.jpeg', 'images/ava.jpeg'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/colors.jpg'),
                          fit: BoxFit.cover)),
                ),
                title: const Center(
                  child: Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 50),
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
                                color:
                                    const Color(0x000602d3).withOpacity(0.15),
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
}
