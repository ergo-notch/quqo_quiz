import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/product_entity.dart';
import 'package:quiz/utils/resources.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaceDetailsScreen extends StatefulWidget {
  @override
  _PlaceDetailsState createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetailsScreen> {
  var productList = Constants.productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del lugar')),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.red,
                        ),
                        onPressed: () {}),
                  ),
                )
              ],
            ),
          ),
          Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  InkWell(
                      onTap: () {},
                      child: Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Hola"),
                        ),
                      )),
                  Expanded(
                      child: ListView.separated(
                          shrinkWrap: false,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return _buildProductItemView(
                                this.productList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemCount: this.productList.length))
                ]),
              ))
        ],
      ),
    );
  }
}

Widget _buildProductItemView(Product product) {
  return InkWell(
      onTap: () {},
      child: ListTile(
        leading: SizedBox(
            width: 50,
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: product.strUrlImage)),
        title: Text(product.strProductName),
        trailing: Text("\$" + product.strProductPrice),
      ));
}
