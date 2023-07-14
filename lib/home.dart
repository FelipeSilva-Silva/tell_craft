import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _home();
}

class _home extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: 360,
        height: 640,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF191B24)),
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
                    bottom: BorderSide(width: 0.50, color: Color(0xFF2B2E3A)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 18,
              child: Container(
                width: 100,
                height: 55,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/tellCraft.png'),
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
                    image: NetworkImage("https://via.placeholder.com/35x35"),
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
                    image: NetworkImage("https://via.placeholder.com/10x10"),
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
                            image: NetworkImage(
                                "https://via.placeholder.com/340x170"),
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
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 9,
                      top: 85,
                      child: Text(
                        'Embarque em uma fantasia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Fanwood Text',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      top: 127,
                      child: Text(
                        'Crie  seu próprio conto de fadas ou \naventura do herói com o auxilio de uma I.A.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Fanwood Text',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
