import 'package:flutter/material.dart';


class Onboardingthree extends StatelessWidget {
  const Onboardingthree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              
            ),
            Image.asset("assets/images/Frame3.png"),
            SizedBox(
              width: 300,
              child: Text(
                "Start Your Adventure",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF121212),
                ),
              ),
            ),
            SizedBox(
              width: 300,

              child: Text(
                "Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let's go!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFA6A6A6), fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF54408C),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 327,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xFF54408C),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: 327,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 230, 255),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Color(0xFF54408C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
