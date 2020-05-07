
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/utils/resources.dart';

class UiHelpers{
  static showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: Text(message),
        actions: <Widget>[
          new FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  static getUrlImage(String url) {
    return Constants.photoUrl + url;
  }

}