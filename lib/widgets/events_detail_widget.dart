import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class EventsDetail extends StatefulWidget {
  const EventsDetail({super.key});

  @override
  State<EventsDetail> createState() => _EventsDetailState();
}

class _EventsDetailState extends State<EventsDetail> {
  List AvaImages = ['images/ava.jpeg', 'images/ava.jpeg', 'images/ava.jpeg'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/colors.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Row(
              children: [
                for (int i = 0; i < AvaImages.length; i++)
                  Align(
                    widthFactor: 0.5,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(AvaImages[i])),
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
    );
  }
}
