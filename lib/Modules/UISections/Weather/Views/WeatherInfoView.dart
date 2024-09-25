import 'package:flutter/material.dart';

class WeatherInfoView extends StatefulWidget {
  final String topText, information, bottomText;
  const WeatherInfoView(
      {required this.topText,
      required this.information,
      required this.bottomText,
      super.key});
  @override
  State<WeatherInfoView> createState() => _WeatherInfoViewState();
}

class _WeatherInfoViewState extends State<WeatherInfoView> {
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
              widget.topText,
              style: TextStyle(
                  color: const Color(0XFFEBEBF5).withOpacity(0.6), fontSize: 18),
            ),
            Text(
              widget.information,
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
              widget.bottomText,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        )
      ]),
    );
  }
}
