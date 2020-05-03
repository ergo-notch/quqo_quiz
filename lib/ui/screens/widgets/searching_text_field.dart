import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz/utils/resources.dart';

class PlacesTextField extends StatefulWidget {
  final VoidCallback onClearField;
  final Function(String) onChangeText;
  final TextEditingController controller;
  final Function onFocus;
  final bool autoFocus;
  final VoidCallback onTap;

  PlacesTextField(
      {@required this.onClearField,
        @required this.onChangeText,
        this.onTap,
        this.controller,
        this.onFocus,
        this.autoFocus});

  @override
  State<StatefulWidget> createState() => SearchTextFieldState(
    this.onChangeText,
    this.onClearField,
    this.controller,
    this.onFocus,
    this.autoFocus,
    this.onTap,
  );
}

class SearchTextFieldState extends State<PlacesTextField> {
  final textController;
  final VoidCallback onClearField;
  final Function(String) onChangeText;
  final FocusNode focus = FocusNode();
  final Function onFocus;
  final bool autoFocus;
  bool alreadyFocus = false;
  final VoidCallback onTap;

  SearchTextFieldState(this.onChangeText, this.onClearField,
      this.textController, this.onFocus, this.autoFocus, this.onTap);

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if (onFocus != null) this.onFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget w = Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(8.0)),
            child: new Row(
              children: <Widget>[
                Container(
                    child: SvgPicture.asset(ImageConstants.iconPlaceSearch)),
                new SizedBox(
                  width: 10.0,
                ),
                new Expanded(
                  child: new Stack(
                      alignment: const Alignment(1.0, 1.0),
                      children: <Widget>[
                        new TextField(
                          readOnly: !autoFocus,
                          autofocus: autoFocus,
                          focusNode: focus,
                          onTap: () {
                            this.onTap();
                          },
                          decoration: InputDecoration(
                              hintText: 'Ingresa una dirección',
                              border: InputBorder.none),
                          onChanged: (text) {
                            if (text.length > 0) {
                              onChangeText(text);
                            } else {
                              onClearField();
                            }
                          },
                          controller: textController,
                        ),
                        textController.text.length > 0
                            ? new IconButton(
                            icon: new Icon(Icons.clear),
                            onPressed: () {
                              textController.clear();
                              onClearField();
                            })
                            : new Container(
                          height: 0.0,
                        )
                      ]),
                ),
              ],
            )));
    return w;
  }
}
