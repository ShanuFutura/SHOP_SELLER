// import 'package:city_mapping/pages/customer/customer_shop_view.dart';
// import 'package:city_mapping/pages/customer/map_sample.dart';
// import 'package:city_mapping/pages/shop/dashboard.dart';
// import 'package:city_mapping/pages/shop_model.dart';
import 'package:shop_seller/models/shop.dart';
import 'package:shop_seller/pages/customer/map_sample.dart';
import 'package:shop_seller/pages/customer/view_products.dart';
import 'package:shop_seller/pages/customer/view_shops.dart';
import 'package:shop_seller/utils/get_location.dart';
// import 'package:city_mapping/utils/network_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_seller/utils/network_service.dart';

class NearbyShops extends StatefulWidget {
  const NearbyShops({Key? key}) : super(key: key);

  @override
  State<NearbyShops> createState() => _NearbyShops();
}

class _NearbyShops extends State<NearbyShops> {
  String address =
      "Please wait until your address appears.\nif any not please check your location service is enabled..";

  bool isFound = false;
  @override
  void initState() {
    super.initState();
    findAddress();
    genaratePins();
  }

  Position? position;
  findAddress() {
    determinePosition().then((value) {
      print('location data $value');
      position = value;
      getAddress(value).then((value) {
        setState(() {
          isFound = true;
          address = "${value.subLocality}\n" +
              "${value.subAdministrativeArea}\n" +
              "${value.country}\n" +
              "${value.postalCode}\n";
        });
      });
    });
  }

  BuildContext? myContext;

  @override
  Widget build(BuildContext context) {
    myContext = context;
    return Scaffold(
      appBar: AppBar(title: const Text("Customer"), actions: [
        IconButton(
            onPressed: findAddress, icon: const Icon(Icons.pin_end_rounded))
      ]),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            address,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Visibility(
              visible: isFound,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MapSample(
                            markers: markers,
                            currentLocation: LatLng(
                                position!.latitude, position!.longitude)),
                      ),
                    );
                  },
                  icon: const Icon(Icons.explore),
                  label: const Text("start discover")))
        ],
      )),
    );
  }

  Future<List<Shop>> getShops() async {
    List jsonList = await getData("view_shop.php");
    return jsonList.map((json) => Shop.fromJson(json)).toList();
  }

  genaratePins() async {
    final shops = await getShops();
    for (var shop in shops) {
      pin(shop);
    }
    setState(() {
      markers;
    });
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  pin(Shop shop) {
    final split = shop.shopLocation!.split(',');
    LatLng lng = LatLng(double.parse(split[0]), double.parse(split[1]));
    Marker marker = Marker(
      onTap: () {
        print(shop.name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ViewProducts(shopId: shop.sRegisterId!,shopName: shop.name!,),
          ),
        );
      },
      markerId: MarkerId(shop.name!),
      position: lng,
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: shop.name,
        snippet: shop.phone,
      ),
    );
    MarkerId markerId = MarkerId(shop.name!);
    markers[markerId] = marker;
  }

  Future<Placemark> getAddress(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks[0];
  }
}
