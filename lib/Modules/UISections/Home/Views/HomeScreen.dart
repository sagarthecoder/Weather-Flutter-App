import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/Modules/UISections/TabBar/TabItem.dart';
import 'package:weather_flutter/Modules/UISections/Theme/Views/ThemeView.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Views/WeatherScreen.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../Weather/ViewModel/WeatherViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: TabItem.values.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: makeTabBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChangeNotifierProvider<WeatherViewModel>(
            create: (context) => WeatherViewModel(),
            child: WeatherScreen(),
          ),
          ThemeView(),
        ],
      ),
    );
  }

  Widget makeTabBar() {
    return Container(
      color: Colors.white54,
      child: TabBar(
        controller: _tabController,
        indicatorPadding: EdgeInsets.only(bottom: 4),
        tabs: [
          Tab(
            text: 'Weather',
            icon: Icon(WeatherIcons.day_windy),
          ),
          Tab(
            text: 'Theme',
            icon: Icon(Icons.branding_watermark),
          )
        ],
      ),
    );
  }
}
