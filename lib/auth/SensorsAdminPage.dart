import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sensors_state.dart'; // Import the SensorsState class

class SensorsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SensorsState>(
      builder: (context, sensorsState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('SensorsAdmin'),
            backgroundColor: Colors.deepPurple,
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Temperature Sensor'),
                trailing: Switch(
                  value: sensorsState.isTemperatureSensorActive,
                  onChanged: (value) {
                    sensorsState.toggleTemperatureSensor(value);
                  },
                ),
              ),
              ListTile(
                title: Text('Humidity Sensor'),
                trailing: Switch(
                  value: sensorsState.isHumiditySensorActive,
                  onChanged: (value) {
                    sensorsState.toggleHumiditySensor(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
