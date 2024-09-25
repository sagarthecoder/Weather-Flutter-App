import 'package:flutter/material.dart';

class TemperatureInfoView extends StatefulWidget {
  final String place;
  final String temperature;
  final String description;
  const TemperatureInfoView(
      {required this.place,
      required this.temperature,
      required this.description,
      super.key});

  @override
  State<TemperatureInfoView> createState() => _TemperatureInfoViewState();
}

class _TemperatureInfoViewState extends State<TemperatureInfoView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.place,
            style: const TextStyle(color: Colors.white, fontSize: 34),
          ),
          Text(
            '${widget.temperature} | ${widget.description}',
            style: TextStyle(
              color: const Color(0XFFEBEBF5).withOpacity(0.6),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
