import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main()
{
  runApp(MaterialApp(home: CircularSliderWidget(),));
}
class CircularSliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleek Circular Slider Example'),
      ),
      body: Center(
        child: SleekCircularSlider(
          initialValue: 50, // Initial value
          max: 100, // Maximum value
          appearance: CircularSliderAppearance(
            customColors: CustomSliderColors(
              // progressBarColors: [Colors.blue], // Customize progress bar colors
              trackColor: Colors.grey, // Customize track color
              shadowColor: Colors.green, // Customize shadow color
              shadowMaxOpacity: 0.2, // Set shadow maximum opacity
            ),
            customWidths: CustomSliderWidths(
              progressBarWidth: 15, // Set progress bar width
              trackWidth: 12, // Set track width
              shadowWidth: 20, // Set shadow width
            ),
            size: 300, // Set the slider's size
            startAngle: 330, // Set the starting angle
            angleRange: 240, // Set the angle range
            infoProperties: InfoProperties(
              // Customize label style
              mainLabelStyle: TextStyle(fontSize: 24, color: Colors.blue),
              modifier: (double value) {
                // Display value as a percentage
                return '${value.toStringAsFixed(0)}%';
              },
            ),
            spinnerMode: false, // Disable spinner mode
            animationEnabled: true, // Enable animation
          ),
          onChange: (double value) {
            // Handle value change here
          },
        ),
      ),
    );
  }
}
