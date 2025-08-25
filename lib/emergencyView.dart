import 'package:flutter/material.dart';

class EmergencyView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;

  const EmergencyView(
      {Key? key,
      required this.mainScreenAnimationController,
      required this.mainScreenAnimation})
      : super(key: key);

  @override
  _EmergencyViewState createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView>
    with TickerProviderStateMixin {
  late Animation<double> _borderAnimation, _emergencyAnimation;
  late AnimationController _borderAnimationController,
      _emergencyAnimationController;

  @override
  void initState() {
    _borderAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _borderAnimation = Tween(begin: 20.0, end: 70.0).animate(CurvedAnimation(
        curve: Curves.bounceInOut, parent: _borderAnimationController));

    _borderAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _borderAnimationController.repeat();
      }
    });

    _emergencyAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _emergencyAnimation = Tween(begin: 200.0, end: 230.0).animate(
        CurvedAnimation(
            curve: Curves.easeOutSine, parent: _emergencyAnimationController));

    _emergencyAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _emergencyAnimationController.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _borderAnimationController.dispose();
    _emergencyAnimationController.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.mainScreenAnimationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: widget.mainScreenAnimation,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 6, bottom: 18),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                          child: Text('Emergency Button',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                fontFamily: 'Nunito',
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AnimatedBuilder(
                          animation: _emergencyAnimationController,
                          builder: (context, child) {
                            return Center(
                              child: InkWell(
                                onTap: () async {
                                  _emergencyAnimationController.forward();
                                  _borderAnimationController.forward();
                                  //             Navigator.of(context)
                                  // .push(MaterialPageRoute(builder: (context) => EventsPage(animationController: widget.mainScreenAnimationController,)));
                                },
                                child: Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: _borderAnimation.value,
                                      color: Colors.red,
                                    ),
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          offset: Offset(5.1, 5.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15,
                                            left: 40,
                                            right: 40,
                                            bottom: 35),
                                        child: Image.asset(
                                          'assets/alarm.png',
                                          width:
                                              _emergencyAnimation.value * 0.7,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15,
                                            left: 40,
                                            right: 40,
                                            bottom: 35),
                                        child: Image.asset(
                                          'assets/alarm.png',
                                          width:
                                              _emergencyAnimation.value * 0.7,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15,
                                            left: 40,
                                            right: 40,
                                            bottom: 35),
                                        child: Image.asset(
                                          'assets/alarm.png',
                                          width:
                                              _emergencyAnimation.value * 0.7,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      child: Text(
                        'Tap the emergency button\n to alert officials',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
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
}
