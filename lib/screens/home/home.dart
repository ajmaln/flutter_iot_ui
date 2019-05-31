import 'package:flutter/material.dart';
import 'package:iot_ui/screens/home/widgets/deviceCard.dart';
import 'package:iot_ui/widgets/gradientIcon.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIndex;
  int selected;
  List<double> sparkLineData;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    selected = 1;
    sparkLineData = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          elevation: 0.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.assessment), onPressed: (){}, color: Colors.white,)
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Home Dashboard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
              Row(
                children: <Widget>[
                  Text("Good Morning", style: TextStyle(fontSize: 15.0),),
                  SizedBox(width: 5.0,),
                  Text("Ajmal!", style: TextStyle(fontSize: 15.0, color: Colors.lightBlueAccent),)
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
           currentIndex = index; 
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active, color: Colors.white,),
            activeIcon: GradientIcon(
              icon: Icon(Icons.notifications_active), 
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: <Color>[
                  Colors.greenAccent[200],
                  Colors.blueAccent[200]
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            title: Text('', style: TextStyle(fontSize: 0.0),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer, color: Colors.white,),
            activeIcon: GradientIcon(
              icon: Icon(Icons.av_timer), 
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: <Color>[
                  Colors.greenAccent[200],
                  Colors.blueAccent[200]
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            title: Text('', style: TextStyle(fontSize: 0.0),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.white,),
            activeIcon: GradientIcon(
              icon: Icon(Icons.calendar_today), 
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: <Color>[
                  Colors.greenAccent[200],
                  Colors.blueAccent[200]
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            title: Text('', style: TextStyle(fontSize: 0.0),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart, color: Colors.white,),
            activeIcon: GradientIcon(
              icon: Icon(Icons.show_chart), 
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: <Color>[
                  Colors.greenAccent[200],
                  Colors.blueAccent[200]
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            title: Text('', style: TextStyle(fontSize: 0.0),)
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 9.0),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
          Expanded(
            flex: 5,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: CustomScrollPhysics(),
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                DeviceCard(
                  value: '1345',
                  unit: 'RPM',
                  title: 'Thermostat',
                  subtitle: 'Heating and ventilation',
                  iconData: Icons.hot_tub,
                ),
                DeviceCard(
                  value: '123',
                  unit: 'KWH',
                  title: 'Electricity',
                  subtitle: '12 outlet points',
                  iconData: Icons.flash_on,
                ),
                DeviceCard(
                  value: '23',
                  unit: 'KWH',
                  title: 'Security',
                  subtitle: '16 cameras',
                  iconData: Icons.photo_camera,
                ),
                DeviceCard(
                  value: '980',
                  unit: 'KWH',
                  title: 'CO2 Sensor',
                  subtitle: 'Ventilation',
                  iconData: Icons.all_inclusive,
                  onTap: () {
                    Navigator.pushNamed(context, 'co2Sensor/');
                  },
                ),
                SizedBox(
                  width: 15.0,
                ),
            ],)
          ),
          SizedBox(height: 5.0,),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Row(children: <Widget>[
              SizedBox(width: 15.0,),
              Text('Statistic', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),)
            ],),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: SizedBox(
                width: 200.0,
                child: Stack(
                  children: <Widget>[
                    AnimatedAlign(
                      alignment: selected == 0 ? Alignment.centerLeft: Alignment.centerRight,
                      child: OutlineButton(
                        child: Text(selected == 0 ? 'Month': 'Year'),
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
                        textColor: Colors.lightBlueAccent, 
                        child: Text('Month'), 
                        // highlightElevation: 1.0,
                        // borderSide: BorderSide(
                        //   color: Colors.lightBlueAccent, //Color of the border
                        //   style: BorderStyle.solid, //Style of the border
                        //   width: 0.8, //width of the border
                        // ), 
                        onPressed: () {
                          setState(() {
                            selected = 0;
                          });
                        },
                      ),
                    ),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        textColor: Colors.lightBlueAccent, 
                        child: Text('Year'), 
                        // highlightElevation: 1.0,
                        // borderSide: BorderSide(
                        //   color: Colors.lightBlueAccent, //Color of the border
                        //   style: BorderStyle.solid, //Style of the border
                        //   width: 0.8, //width of the border
                        // ), 
                        onPressed: () {
                          setState(() {
                            selected = 1;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15.0, bottom: 15.0, top: 15.0),
              child: Sparkline(
                enableGridLines: true,
                labelPrefix: 'K',
                useCubicSmoothing: true,
                data: selected == 0 ? sparkLineData.sublist(0, 5): sparkLineData,
                lineGradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: <Color>[
                    Colors.greenAccent[200],
                    Colors.blueAccent[200]
                  ],
                  tileMode: TileMode.mirror,
                ),
                pointsMode: PointsMode.all,
                pointSize: 7.0,
                lineWidth: 2.5,
              ),
            ),
            flex: 4,
          )
        ],),
      )
    );
  }
}


class CustomScrollPhysics extends BouncingScrollPhysics {
  final List<int> todos = [1,2,3,4];
  CustomScrollPhysics({
    ScrollPhysics parent,
  }) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels / (position.maxScrollExtent / (todos.length.toDouble() - 1));
    // return position.pixels / position.viewportDimension;
  }

  double _getPixels(ScrollPosition position, double page) {
    // return page * position.viewportDimension;
    return page * (position.maxScrollExtent / (todos.length.toDouble() - 1));
  }

  double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) || (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) return super.createBallisticSimulation(position, velocity);
    //final Tolerance tolerance = this.tolerance;
    final Tolerance tolerance = Tolerance(distance: 1, velocity: 2);
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    return null;
  }
}