import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curious_ia/Model/poll.dart';
import 'package:curious_ia/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Db {
  BuildContext context;
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _pollCollectionReference =
      Firestore.instance.collection('poll');

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future createPoll(Poll poll) async {
    try {
      await _pollCollectionReference.document(poll.id).setData(poll.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addUser(
    BuildContext context, {
    String id,
    String username,
    int credit,
    mail,votedfor
  }) async {
    createUser(User(
      id: id,
      username: username,
      mail: mail,
      credit: credit,
      votedfor:votedfor,
    ));
    /*  Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeView()));*/
  }

  Future addPoll({
    String id,
    String creatorid,
    String type,
    List<String> urlpic,
    List<double> vote,
  }) async {
    createPoll(Poll(
      id: id,
      creatorid: creatorid,
      urlpic: urlpic,
      vote: vote,
      type: type,
    ));
    /*  Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeView()));*/
  }

  Future updatePoll({
    String id,
    List<double> vote,
  }) async {
    await Firestore.instance.collection('poll').document(id).updateData({
      'vote': vote,
    }).then((_) {
      // _navigationService.navigateTo(TheHomeview);
    });
  }

  Future updateUser({
    String id,
    credit,
  }) async {
    await Firestore.instance.collection('users').document(id).updateData({
      'credit': credit,
    }).then((_) {
      // _navigationService.navigateTo(TheHomeview);
    });
    
  }
    Future updateUser2({
    String id,
    credit,votedfor
  }) async {
    await Firestore.instance.collection('users').document(id).updateData({
      'credit': credit,
      'votedfor': votedfor,
    }).then((_) {
      // _navigationService.navigateTo(TheHomeview);
    });
  }
}
