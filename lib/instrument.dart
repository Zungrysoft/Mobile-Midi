import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sensors/sensors.dart';

class InstrumentPage extends StatefulWidget {
  @override
  _InstrumentPageState createState() => _InstrumentPageState();
}

class _InstrumentPageState extends State<InstrumentPage> {
  double accel_x = 0;
  double accel_y = 0;
  double accel_z = 0;
  double gyro_x = 0;
  double gyro_y = 0;
  double gyro_z = 0;
  //Stream<dynamic> accel;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (mounted) {
        setState(() {
          accel_x = event.x;
          accel_y = event.y;
          accel_z = event.z;
        });
      }
    });
    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (mounted) {
        setState(() {
          gyro_x = event.x;
          gyro_y = event.y;
          gyro_z = event.z;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mobile MIDI"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('Settings'),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Current Gyro Positions:",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
              ),
              Table(
                border: TableBorder.all(
                    width: 2.0,
                    color: Colors.blueAccent,
                    style: BorderStyle.solid),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "X Axis : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(gyro_x.toStringAsFixed(2),
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Y Axis : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(gyro_y.toStringAsFixed(2),
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Z Axis : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(gyro_z.toStringAsFixed(2),
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
  void dispose() {
    super.dispose();
  }
}