import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Creating empty map to receive data from loading screen

  Map data = {};

  @override
  Widget build(BuildContext context) {
    //Receive the actual argument in empty data map from loading screen
    //We are not using setState as this is first time Build function running and no widget has been yet returned
    //and checks if after pop the loading screen we should store the dat

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    //Set Background
    String bgImage = data['isDaytime'] == true ? 'day.jpg' : 'night.jpg';

    Color bgColor = data['isDaytime'] == true ? Colors.grey[900] : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  //long async function to go to loading screen
                  //select option and get the data
                  //pop the loading screen and
                  //come back to home screen with data
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.white60,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
