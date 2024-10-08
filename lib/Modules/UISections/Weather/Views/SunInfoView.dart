import 'package:flutter/material.dart';

class SunInfoView extends StatefulWidget {
  final String sunriseTime;
  final String sunsetTime;
  const SunInfoView(
      {required this.sunriseTime, required this.sunsetTime, super.key});

  @override
  State<SunInfoView> createState() => _SunInfoViewState();
}

class _SunInfoViewState extends State<SunInfoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 4),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SUNRISE',
              style: TextStyle(
                  color: const Color(0XFFEBEBF5).withOpacity(0.6), fontSize: 18),
            ),
            Text(
              widget.sunriseTime,
              style: const TextStyle(color: Colors.white, fontSize: 26),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Divider(
                color: Colors.grey,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Sunset: ${widget.sunsetTime}',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        )
      ]),
    );
  }
}
