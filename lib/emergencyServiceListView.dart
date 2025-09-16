import 'package:emergencyApp/notifiers/emergencyNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmergencyServicesListView extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> animation;

  const EmergencyServicesListView(
      {Key? key, required this.animationController, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmergencyNotifier emergencyNotifier =
        Provider.of<EmergencyNotifier>(context);
    List<dynamic> category = [4];
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  //Defining category
                  final categorys = category[index];
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 0, bottom: 0),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18.0),
                                      bottomLeft: Radius.circular(18.0),
                                      bottomRight: Radius.circular(18.0),
                                      topRight: Radius.circular(18.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        offset: Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(18.0),
                                            bottomLeft: Radius.circular(18.0),
                                          ),
                                          child: SizedBox(
                                            height: 100,
                                            child: AspectRatio(
                                              aspectRatio: 1.2,
                                              child: Image.asset(
                                                'assets/alarm.png',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 16,
                                                  ),
                                                  child: Text(
                                                    "Emergency",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20,
                                                      letterSpacing: 0.0,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 12,
                                                top: 4,
                                              ),
                                              child: Text(
                                                "Emergency Services",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Container(
                                            child: Icon(
                                              Icons.check_circle,
                                              size: 30,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}
