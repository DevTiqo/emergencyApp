import 'package:emergencyApp/emergencyView.dart';
import 'package:emergencyApp/models/category.dart';
import 'package:emergencyApp/models/emergency.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'model/event.dart';

class EmergencyPage extends StatefulWidget {
  final AnimationController animationController;

  const EmergencyPage({Key? key, required this.animationController})
      : super(key: key);
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage>
    with TickerProviderStateMixin {
  //widget definitions
  late Animation<double> animation;
  List<Category> promo = [];
  List<Widget> listViews = [];
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  late Emergency emergency;
  List<Category> emergencyData = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      '10% OFF',
      'assets/alarm.png',
      'Injuries & Fractures',
      'Shawarma',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      "5% OFF",
      'assets/alarm.png',
      'Virus Symptoms',
      'Plantain',
    ),
    Category(
      Color(0xff00E9DA),
      Color(0xff5189EA),
      'Fashion',
      'assets/alarm.png',
      'Unconsciousness',
      'Chicken',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/alarm.png',
      'Fits & Siezures',
      '',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/alarm.png',
      'Other (Specify)',
      '',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/alarm.png',
      'Other (Specify)',
      '',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/alarm.png',
      'Other (Specify)',
      '',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/alarm.png',
      'Other (Specify)',
      '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    emergency =
        new Emergency('', '', '', '', '', 'Pending', null, DateTime.now());
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

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
    emergency.type = "Medical";
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
            getMainListViewUI(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  )),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text('MEDICAL',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white38,
                            fontFamily: 'Montserrat')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text('EMERGENCY',
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white38,
                            fontFamily: 'Montserrat')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('What type of incident is occuring?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: new BorderRadius.circular(
                        AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
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
          return GridView.builder(
            controller: scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top * 4.5,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
              left: 20,
              right: 20,
            ),
            itemCount: emergencyData.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              widget.animationController.forward();
              return EmergencyDataView(
                emergencyData: emergencyData[index],
                emergency: emergency,
                animation: animation,
                animationController: widget.animationController,
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.4 / 2,
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0),
          );
        }
      },
    );
  }
}

showAlertDialog(
    BuildContext context,
    String image,
    String emergency,
    Emergency emergencyToSend,
    Animation animation,
    AnimationController animationController) {
  // show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0)), //this right here
          child: Container(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: Offset(4, 4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              emergency,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                              width: 60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: Offset(4, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            decoration: InputDecoration(
                                fillColor: Colors.blue,
                                border: InputBorder.none,
                                hintText:
                                    'Where is the incident ongoing? \nList other information that can help \nofficials or protect student and staff'),
                            onChanged: (value) {
                              emergencyToSend.description = value;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 350.0,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          showEmergencyButton(
                            context,
                            animation,
                            animationController,
                            emergencyToSend,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Send Emergency Alert",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

showEmergencyButton(BuildContext context, Animation animation,
    AnimationController animationController, Emergency emergencyToSend) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Container(
          child: Scaffold(
            body: Stack(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height * 0.4 +
                      MediaQuery.of(context).padding.top,
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                child: SizedBox(
                  width: AppBar().preferredSize.height,
                  height: AppBar().preferredSize.height,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: new BorderRadius.circular(
                          AppBar().preferredSize.height),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
                child: EmergencyView(
                  mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / 1) * 5, 1.0,
                              curve: Curves.fastOutSlowIn))),
                  mainScreenAnimationController: animationController,
                ),
              ),
            ]),
          ),
        );
      });
}

//Data View for Energency
class EmergencyDataView extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  final Emergency emergency;

  final Category emergencyData;

  const EmergencyDataView(
      {Key? key,
      required this.emergencyData,
      required this.animationController,
      required this.emergency,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: SizedBox(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, left: 8, right: 4, bottom: 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        showAlertDialog(
                            context,
                            emergencyData.image,
                            emergencyData.name,
                            emergency,
                            animation,
                            animationController);
                        emergency.category = emergencyData.name;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: Container(
                              width: 180,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    offset: Offset(4, 4),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/alarm.png',
                                    width: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      emergencyData.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
