import 'package:emergencyApp/notifiers/emergencyNotifier.dart';
import 'package:emergencyApp/emergency.dart';
import 'package:emergencyApp/emergencyServiceListView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> with TickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> topBarAnimation;
  List<Widget> listViews = [];
  late EmergencyNotifier emergencyNotifier;
  var scrollController = ScrollController();

  double topBarOpacity = 0.0;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emergencyNotifier = Provider.of<EmergencyNotifier>(context);
    // getLandingServices(emergencyNotifier);
  }

  void addAllListData() {
    var count = 5;
    listViews.add(
      Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/medical.png',
              width: 90,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text('MEDICAL',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontFamily: 'Montserrat')),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text('CENTRE',
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontFamily: 'Montserrat')),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    listViews.add(
      Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 350,
                decoration: BoxDecoration(
                  //  border: Border.all(
                  //               width:2,
                  //               color:Colors.blue,
                  //             ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/doctor.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Health is Wealth',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'See a Doctor Today!',
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'Montserrat',
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
    listViews.add(
      EmergencyServicesListView(
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              height: 150,
            ),
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(color: Colors.transparent),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
            height: MediaQuery.of(context).size.width * 0.28,
            width: MediaQuery.of(context).size.width * 0.28,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EmergencyPage(
                          animationController: animationController,
                        )));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/alarm.png', width: 70),
                ],
              ),
            )),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
}
