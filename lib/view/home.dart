import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    var cityName = ["Bankok", "Delhi", "Asia", "London", "USA", "China"];
    final random = Random();
    var city = cityName[random.nextInt(cityName.length)];
    List<String> navbarItem = [
      "TopNews",
      "Health",
      "Finance",
      "Cricket",
      "Devotion"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("News-Ley"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 163, 214, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                      child: const Icon(
                        Icons.search,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: SearchController(),
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search $city for News"),
                    ),
                  )
                ],
              ),
            ),

            //Navbar Creation ...

            SizedBox(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: navbarItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => {
                        debugPrint(navbarItem[index]),
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            navbarItem[index],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            CarouselSlider(
              options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true),
              items: items.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () => {
                        debugPrint("Animesh Want to see news "),
                      },
                      child: Container(
                        //  width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 14),
                        decoration: BoxDecoration(
                          color: i,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            Container(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.greenAccent,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 1.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset("assets/images/news.jpg"),
                              ),
                               Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(

                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    child: const Text(
                                    "News HeadLine",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ))),
                            ],
                          ),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  final List items = [
    Colors.orange,
    Colors.black,
    Colors.blueAccent,
    Colors.red,
    Colors.green
  ];
}
