import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/providers/tipusmapa_provider.dart';

enum MenuItem { item1, item2, item3, item4 }

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _controller2;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _puntInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    Set<Marker> markers = new Set<Marker>();
    markers
        .add(new Marker(markerId: MarkerId('id1'), position: scan.getLatLng()));

    MapType tipusmapa = MapType.satellite;
    final tipusMapa_provider = Provider.of<TipeMapProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.center_focus_strong),
            onPressed: () {
              _controller2.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: _puntInicial.target, zoom: 50)));
            },
          )
        ],
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          markers: markers,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: tipusMapa_provider.tipusmapas,
          initialCameraPosition: _puntInicial,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _controller2 = controller;
          },
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: PopupMenuButton(
                icon: new Icon(
                  Icons.change_circle,
                  color: Colors.purple,
                  size: 50,
                ),
                onSelected: (value) {
                  if (value == MenuItem.item1) {
                    tipusmapa = MapType.satellite;
                    tipusMapa_provider.tipusmapas = tipusmapa;
                  }
                  if (value == MenuItem.item2) {
                    tipusmapa = MapType.normal;
                    tipusMapa_provider.tipusmapas = tipusmapa;
                  }
                  if (value == MenuItem.item3) {
                    tipusmapa = MapType.terrain;
                    tipusMapa_provider.tipusmapas = tipusmapa;
                  }
                  if (value == MenuItem.item4) {
                    tipusmapa = MapType.hybrid;
                    tipusMapa_provider.tipusmapas = tipusmapa;
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                          value: MenuItem.item1,
                          child:
                              Center(child: Icon(Icons.satellite_alt_rounded))),
                      PopupMenuItem(
                        value: MenuItem.item2,
                        child: Center(
                          child: Icon(Icons.map),
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuItem.item3,
                        child: Center(
                          child: Icon(Icons.terrain),
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuItem.item4,
                        child: Center(
                          child: Icon(Icons.map_outlined),
                        ),
                      ),
                    ]),
          ),
          alignment: Alignment.bottomLeft,
        ),
      ]),
    );
  }
}
