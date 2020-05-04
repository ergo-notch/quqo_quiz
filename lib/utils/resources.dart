
import 'package:quiz/models/product_model.dart';

enum HttpMethods { GET, POST, PUT, DELETE, PATCH }

class ImageConstants{
  static String facebookButtonImage = "lib/ui/assets/facebook_login.png";
  static String iconPlaceSearch = "lib/ui/assets/search_header.svg";
  static String mapIconEnabled = "lib/ui/assets/maps_icon_enabled.svg";
  static String mapIconDisabled = "lib/ui/assets/maps_icon_disabled.svg";
  static String resultsIconEnabled = "lib/ui/assets/results_icon_enabled.svg";
  static String resultsIconDisabled = "lib/ui/assets/results_icon_disabled.svg";
  static String currentLocationGet = "lib/ui/assets/current_location_get.svg";
}

class Constants{

  static var googleApiKey = "AIzaSyAmlXHQc-tlACdOFcP8v1EkOh-yjlnn7Rk";

  static List<Product> productList = [
    Product(pepsiUrl,'Pepsi','30.00'),
    Product(saladUrl,'Ensalada','100.00'),
    Product(cakeUrl,'Pastel','50.00'),
    Product(iceCreamUrl,'Helado','50.00'),
    Product(coffeUrl,'Café','60.00'),
    Product(meatUrl,'Carne','150.00'),
    Product(pastaUrl,'Pasta','100.00'),
  ];

  static String pepsiUrl="https://www.chedraui.com.mx/medias/750102200817-01-CH1200Wx1200H?context=bWFzdGVyfHJvb3R8MTUwMTQyfGltYWdlL2pwZWd8aDJmL2hkOC84ODI2NTI5Nzc1NjQ2LmpwZ3w4MDgwNzY5ZjMyYjUzNWJlZmEwMjljOWYyZDk2YmJmZmRkZjcxMjIwNjU1N2Y2YjQ0YjE1ZTNiYzAwZDEzYmEy";
  static String saladUrl="https://d1uz88p17r663j.cloudfront.net/resized/84e720e8bc62d59c69924ba55da2b810_ensalada_de_pollo_1_1200_600.jpg";
  static String cakeUrl="https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F1542062283%2Fchocolate-and-cream-layer-cake-1812-cover.jpg%3Fitok%3DrEWL7AIN";
  static String iceCreamUrl="https://designhooks.com/wp-content/uploads/2018/07/ice-cream-bucket-mockup.jpg";
  static String coffeUrl="https://www.inkablelabel.com/wp-content/uploads/2016/09/Coffee-Bag-Mockup.jpg";
  static String meatUrl="https://i.etsystatic.com/10407381/r/il/1ec93b/1990680991/il_570xN.1990680991_gy22.jpg";
  static String pastaUrl="https://sc01.alicdn.com/kf/UTB8y.PkwpPJXKJkSahVq6xyzFXaB/paper-pasta-packaging-bag-paper-pasta-bag.jpg_640x640.jpg";
}