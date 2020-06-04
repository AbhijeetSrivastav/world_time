import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  //initializing the properties of the class
  String location; //location name for the UI
  String time; //time in that location
  String flag; //URL to asset flag image
  String url; //location in the url for the API call
  bool isDaytime; //true or false if day or night

  //Constructor of the class
  WorldTime({this.location, this.flag, this.url});

  //Function is gone return future
  //it is temporary place holder value until this async function completes
  Future <void> getTime() async {
    //First, we come to await. The await part basically says  -  
    // go ahead and run this function asynchronously and,
    // when it is done, continue on to the next line of code
    //and this all is done in asynchronous function not in sync one

    //Handling the Error Occurring While Loading Data
    try {
      //make request to api and waiting until data is returned from api
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');

      //Convert json string  data to string
      Map data = jsonDecode(response.body);

      //Get properties from data map (like dictionary in python)

      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      //Create a DateTime Object
      DateTime now = DateTime.parse(
          datetime); //creates an instance now of the DateTime object from
      // DateTime class by parsing a string

      //Our offset time is in format +xy: zw
      //To add offset time to now time we need to convert offset time in xy: zw format
      //and now save the hour part and minute part of the offset in different int variables
      //for that we need to take the hour and minute part of that string as substring
      //and after that we have to convert that substring part to int by parsing the string

      int hour = int.parse(offset.substring(1, 3));
      int minute = int.parse(offset.substring(5, 6));

      //now adding the now time from datetime with the add method and giving the duration
      //by giving hours and minutes
      now = now.add(Duration(hours: hour, minutes: minute));


      //Using ternary operator to check whether its day time or not
      //Ternary operator format is:
      // variable_store_result = condition ? if satisfied then value : else the value;
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;


      //convert now object to more readable format
      time = DateFormat.jm().format(now);
    }
    catch (error) {
      print(error);
      time = 'Could Not Load The Time Data!';
    }
  }
}
