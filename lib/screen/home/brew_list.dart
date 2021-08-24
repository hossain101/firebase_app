
import 'package:firebase_app/models/brew.dart';
import 'package:firebase_app/screen/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


class BrewList extends StatefulWidget {

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew?>?>(context)??[];

    if(brews !=null ) {
      brews.forEach((brew) {
        print(brew!.name);
        print(brew.sugar);
        print(brew.strength);
      }

      );
    }
    return brews ==null? Scaffold(backgroundColor: Colors.green,): ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew: brews[index]);

      },


    );
  }
}
