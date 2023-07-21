import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 640,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF191B24)),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 360,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFF0F1015),
                      border: Border(
                        left: BorderSide(color: Color(0xFF2B2E3A)),
                        top: BorderSide(color: Color(0xFF2B2E3A)),
                        right: BorderSide(color: Color(0xFF2B2E3A)),
                        bottom:
                            BorderSide(width: 0.50, color: Color(0xFF2B2E3A)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 18,
                  child: Container(
                    width: 104,
                    height: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/tellCraft.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 315,
                  top: 13,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/personLogo.png"),
                        fit: BoxFit.cover,
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 52,
                  top: 279,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/miniClock.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 68,
                  top: 279,
                  child: SizedBox(
                    width: 75,
                    height: 10,
                    child: Text(
                      'MAIS RECENTES',
                      style: TextStyle(
                        color: Color(0xFFB7B7B7),
                        fontSize: 10,
                        fontFamily: 'Mada',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 76,
                  child: Container(
                    width: 340,
                    height: 170,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 340,
                              height: 170,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/Carousel1.png"),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 85,
                            child: Container(
                              width: 217,
                              height: 85,
                              decoration: BoxDecoration(
                                color: Colors.black
                                    .withOpacity(0.10000000149011612),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
