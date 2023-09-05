import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("News-Ley"),
          centerTitle: true,
        ),
        body: Column(
            children: [
             Container(
               
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(horizontal:24,vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius:BorderRadius.circular(10),
                   ),
                child: Row(
                 children: [
                     Icon(Icons.search),
                     Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Any Country for News"
                          ),
                      ),
                      )
                  ],
                ) , 
              ),
            ],
        ),
    );
  }
}