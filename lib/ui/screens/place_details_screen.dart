import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:quiz/models/place_model.dart';
import 'package:quiz/models/product_model.dart';
import 'package:quiz/utils/resources.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaceDetailsScreen extends StatefulWidget {
  @override
  _PlaceDetailsState createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetailsScreen> {
  var productList = Constants.productList;

  PlaceModel place;

  @override
  Widget build(BuildContext context) {
    this.place = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del lugar')),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Stack(
              children: <Widget>[
                    FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: place.photos.isEmpty
                            ? place.icon
                            : place.photos.first),
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
                        onPressed: () {
                          Share.share(place.placeName + "\n" + place.placeUrl,
                              subject: place.placeName + "\n" + place.placeUrl);
                        }),
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
                      onTap: () async {
                        final availableMaps = await MapLauncher.installedMaps;
                        print(
                            availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
                        await availableMaps.first.showMarker(
                          coords: Coords(place.coordenates.latitude,
                              place.coordenates.longitude),
                          title: place.placeName,
                          description: place.address,
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(place.placeName + "\n" + place.address),
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
