import 'package:e_commerse_app/views/pages/home.dart';
import 'package:e_commerse_app/views/pages/log_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    // Future.delayed(
    //     const Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (_) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/cover.png'), fit: BoxFit.cover)),
        //  color: Color.fromARGB(255, 241, 220, 191),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/logoo.png'),
                ),

                // const SizedBox(
                //   height: 10,
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context, MaterialPageRoute(builder: (_) => LogIn()));
                //   },
                //   child: Text(
                //     'Get Srarted',
                //     style: GoogleFonts.akayaKanadaka(
                //         color: Colors.white, fontSize: 50),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                //CircularProgressIndicator()
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => LogIn()));
                    },
                    child: Container(
                      child: Text(
                        'Get Srarted',
                        style: GoogleFonts.akayaKanadaka(
                            color: Colors.white, fontSize: 50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
