import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(
        url: 'http://worldtimeapi.org/timezone/Asia/Kolkata',
        location: 'Kolkata',
        flag: 'india.png'),
    WorldTime(
        url: 'http://worldtimeapi.org/timezone/Asia/Hong_Kong',
        location: 'Hong_Kong',
        flag: 'china.png'),
    WorldTime(
        url: 'http://worldtimeapi.org/timezone/Asia/Tokyo',
        location: 'Tokyo',
        flag: 'japan.png'),
    WorldTime(
        url: 'http://worldtimeapi.org/timezone/Asia/Singapore',
        location: 'Singapore',
        flag: 'singapore.png'),
    WorldTime(
        url: 'http://worldtimeapi.org/timezone/Europe/London',
        location: 'London',
        flag: 'uk.png'),
    WorldTime(
        url: 'http://worldtimeapi.org/timezone/Europe/Berlin',
        location: 'Berlin',
        flag: 'germany.png'),
    WorldTime(
        url: 'http://worldtimeapi.org/timezone/Africa/Cairo',
        location: 'Cairo',
        flag: 'egypt.png'),
    WorldTime(
        url: 'http://worldtimeapi.org/timezone/America/New_York',
        location: 'New_York',
        flag: 'usa.png')
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    //Navigate to home screen and pass the data we get to the home screen
    //as home screen is already sitting underneath in the app we will pop loading screen
    //to get back to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDaytime': instance.isDaytime,
    });
  }

  //initializes the widget again by overriding the initial widget inherited from StatefulWidget
  //helps to update the widget on change of the data while using API to fetch the data

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: Text('Change Location'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(
                  locations[index].location,
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/${locations[index].flag}',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
