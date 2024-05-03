import 'package:flutter/material.dart';
import 'package:schedulia/screens/onboarding/screen_three.dart';
import 'package:schedulia/widgets/circle.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Stack(
        children: [
              Circle(width:370,
                height: height * 0.5,
              ),
          Positioned(
           top: 100.0,
                left: 60.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                       Text(
                          'How do you plan to use\nSchedulia?',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: height*0.03),
                        ),Text(
                            'Categorize your task based on\nyour needs.',
                            style: TextStyle(fontSize: height*0.023),
                          ),
                      ],
                    ),
                ),]),
              
                Row(
                  children: [
              
                    if (width > 600) SizedBox(width: width * 0.3,),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,left: width*0.13),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_2_rounded,
                                color:const  Color.fromARGB(255, 255, 168, 96),
                                size: height*0.055,
                              ),
                            const   SizedBox(
                                width: 40.0,
                              ),
                             Text(
                                'Personal',
                                style: TextStyle(
                                    fontSize: height*0.025,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.020,
                              top: MediaQuery.of(context).size.height * 0.020,left: width*0.13),
                          child:  Row(
                            children: [
                              Icon(
                                Icons.work_history,
                                color:const  Color.fromARGB(255, 219, 84, 84),
                                size: height*0.055,
                              ),
                           const    SizedBox(
                                width: 40.0,
                              ),
                              Text(
                                'Work',
                                style: TextStyle(
                                    fontSize: height*0.025,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.020,left: width*0.13),
                          child: Row(
                            children: [
                              Icon(
                                Icons.monitor_heart,
                                color:const  Color.fromARGB(255, 98, 57, 213),
                                size: height*0.055,
                              ),
                             const  SizedBox(
                                width: 40.0,
                              ),
                               Text(
                                'Health',
                                style: TextStyle(
                                    fontSize: height*0.025,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width < 600
                                      ? width * 0.35
                                      : MediaQuery.of(context).size.width *
                                          0.18,
                                  top: MediaQuery.of(context).size.height *
                                      0.05),
                              child: const Text('+ more other options'),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: width*0.7
                      
                      ),
                      child: 
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ScreenThree()));
                          },
                          child: const Text('Next >>')),
                    )
                  
            ])
      );
  }
}
