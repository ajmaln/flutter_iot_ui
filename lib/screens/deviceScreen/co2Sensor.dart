import 'package:flutter/material.dart';
import 'package:iot_ui/screens/deviceScreen/widgets/dialWidget.dart';


class CO2Sensor extends StatefulWidget {
  @override
  _CO2SensorState createState() => _CO2SensorState();
}

class _CO2SensorState extends State<CO2Sensor> {
  final String title = 'CO2 Sensor';
  int selected;

  @override
  void initState() {
    super.initState();
    selected = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          child: Material(
            child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
            color: Colors.transparent,
          ),
          tag: title,
        ),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: PageView(
          controller: PageController(
            initialPage: 0,
          ),
          children: <Widget>[
            generalFloor(title: 'First Floor', context: context, selected: selected, onSelect: (index) {
              setState(() {
                selected = index;
              });
            }, value: 980),
            generalFloor(title: 'Second Floor', context: context, selected: selected, onSelect: (index) {
              setState(() {
                selected = index;
              });
            }, value: 650),
            generalFloor(title: 'Third Floor', context: context, selected: selected, onSelect: (index) {
              setState(() {
                selected = index;
              });
            }, value: 330)
            // firstFloor(),
            // secondFloor(),
            // thirdFloor(),
          ],
        ),
      ),
    );
  }
}


Widget generalFloor({String title, double value, BuildContext context, int selected, Function onSelect}) {
  String getSelectedText(selected) {
    if(selected == 0) {
      return 'Auto';
    } else if (selected == 1) {
      return 'Home';
    }
    return 'Away';
  }
  return Column(
    children: <Widget>[
      SizedBox(height: 50.0,),
      Text(title, style: Theme.of(context).primaryTextTheme.title,),
      Expanded(
        flex: 5,
        child: DialWidget(value: value.toInt(),)
      ),
      Expanded(
        flex: 2,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Stack(
            children: <Widget>[
              AnimatedAlign(
                alignment: selected == 0 ? Alignment.centerLeft: (selected == 1 ? Alignment.center : Alignment.centerRight),
                child: OutlineButton(
                  child: Text(getSelectedText(selected)),
                  textColor: Colors.transparent,
                  borderSide: BorderSide(
                    color: Colors.lightBlueAccent,
                    style: BorderStyle.solid,
                    width: 0.8,
                  ),
                  onPressed: (){},
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  textColor: selected == 0 ? Colors.lightBlueAccent: Colors.white, 
                  child: Text('Auto'), 
                  onPressed: () {
                    onSelect(0);
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  textColor: selected == 1 ? Colors.lightBlueAccent: Colors.white, 
                  child: Text('Home'), 
                  onPressed: () {
                    onSelect(1);
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  textColor: selected == 2 ? Colors.lightBlueAccent: Colors.white, 
                  child: Text('Away'), 
                  onPressed: () {
                    onSelect(2);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}


