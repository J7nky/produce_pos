import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:produce_pos/core/components/high_lighted_button.dart';
import 'package:produce_pos/core/constants/app_colors.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:http/http.dart' as http;
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/modules/auth/controllers/address_controller.dart';

class RegistrationFrom extends StatefulWidget {
  const RegistrationFrom({super.key});
  @override
  State<RegistrationFrom> createState() => _RegistrationFromState();
}

TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _streetController = TextEditingController();
TextEditingController _buildingNameController = TextEditingController();
TextEditingController _floorController = TextEditingController();
TextEditingController _nearbyController = TextEditingController();
TextEditingController _dobController = TextEditingController();

List items = [];
List empty = [];
List _Governorate = [];
List _district = [];
List _towns = [];
var _selectedGovernorate;
var _selectedDistrict;
var _selectedTown;
bool governorateCaution = false;
bool districtCaution = false;
bool townCaution = false;
bool manual = true;
bool pin = false;
bool _autoCorrect = false;
Future<void> readJson(List governorate) async {
  final String response =
      await rootBundle.loadString('assets/files/LebanonCitites.json');
  final data = await json.decode(response);

  items = data;

  for (int i = 0; i < items.length; i++) {
    governorate.add(items[i]["name"]);
  }
  // for (int i = 0; i < _items.length; i++) {
  //   print(_items[i]["name"]);
  //   for (int j = 0; j < _items[i]["cities"].length; j++) {
  //     print(_items[i]['cities'][j]["towns"]);
  //   }
  // }
}

class _RegistrationFromState extends State<RegistrationFrom>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _getUserCityAndLocation();

    readJson(_Governorate);
    super.initState();
  }

  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Location _location = Location();
  LatLng _initialPosition = const LatLng(0.0, 0.0); // Default to (0,0)
  String? _cityName;
  LatLng? _selectedLocation;

  Future<void> _getUserCityAndLocation() async {
    try {
      // Check location permission
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      // Get current location
      final userLocation = await _location.getLocation();
      final latitude = userLocation.latitude!;
      final longitude = userLocation.longitude!;

      // Reverse geocode to get city name
      String city = await _getCityFromCoordinates(latitude, longitude);
      setState(() {
        _cityName = city;
        _initialPosition = LatLng(latitude, longitude);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<String> _getCityFromCoordinates(double lat, double lng) async {
    const String apiKey = 'YOUR_GOOGLE_API_KEY';
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      if (results.isNotEmpty) {
        final addressComponents = results.first['address_components'] as List;
        final cityComponent = addressComponents.firstWhere(
          (component) => (component['types'] as List).contains('locality'),
          orElse: () => null,
        );
        return cityComponent != null ? cityComponent['long_name'] : 'Unknown';
      }
    }
    return 'Unknown';
  }

  Future<void> _checkPermissionAndGetLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check location service
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    } // Check location permission
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    } // Check location permission
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }
  }

  void _addMarker(LatLng position, String markerId) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(markerId),
        position: position,
        draggable: true,
        onDragEnd: (newPosition) {
          print("New position: $newPosition");
        },
      ));
    });
  }

  void _onMapTapped(LatLng position) {
    _addMarker(position, "Pinned Location");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose

    super.dispose();
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
            bottomNavigationBar: Obx(() => Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: controller.isLoading.value == false
                      ? Stack(children: [
                          highLightedButton(
                              text: "Submit",
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    _selectedLocation != null) {
                                  // final user = FirebaseAuth.instance.currentUser;
                                  String address =
                                      'Governorate: $_selectedGovernorate, District: $_selectedDistrict , Town: $_selectedTown , Street: ${_streetController.text}, Nearby: ${_nearbyController!.text}, Building Name: ${_buildingNameController.text}, Floor: ${_floorController.text}.';
                                  controller
                                      .updateUserLocation(
                                          _firstNameController.text,
                                          _lastNameController.text,
                                          _emailController.text,
                                          _dobController.text,
                                          address,
                                          _selectedLocation!.latitude,
                                          _selectedLocation!.longitude)
                                      .then((v) {
                                    Get.offNamed(AppRoutes.entryPoint);
                                  });
                                  // _collectionRef
                                  //     .doc(user!.phoneNumber)
                                  //     .set({
                                  //       'phone': "+961 ${user.phoneNumber}",
                                  //       "firstName": _firstNameController.text,
                                  //       "lastName": _lastNameController.text,
                                  //       "email": _emailController.text,
                                  //       "dob": _dobController.text,
                                  //       "address": address
                                  //     })
                                  //     .then((value) => Navigator.pushAndRemoveUntil(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 const MainBottomNavigator(index: 0)),
                                  //         (Route<dynamic> route) => false))
                                  //     .catchError((error) =>
                                  //         print("something is wrong. "));
                                } else {
                                  _dialog(context);
                                }
                                setState(() {
                                  _autoCorrect = true;
                                });
                              }),
                        ])
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                )),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppDefaults.padding * 2,
                      left: AppDefaults.padding,
                      right: AppDefaults.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Submit the form to continue",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.primary),
                      ),
                      Text(
                        "We will not share your information with anyone.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: Form(
                        autovalidateMode: _autoCorrect
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Information',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppDefaults.padding / 2),
                              child: Text(
                                "First Name*",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            CustomFormField(
                              keyBoardType: TextInputType.text,
                              controller: _firstNameController,
                              hintText: 'Enter your First Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your first name';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppDefaults.padding / 2),
                              child: Text(
                                "Last Name*",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            CustomFormField(
                              keyBoardType: TextInputType.text,
                              controller: _lastNameController,
                              hintText: 'Enter your Last Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your last name';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppDefaults.padding / 2),
                              child: Text(
                                "Email Address*",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            CustomFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter an email address';
                                  } else if (_emailController.text
                                          .endsWith("@gmail.com") ||
                                      _emailController.text
                                          .endsWith("@yahoo.com") ||
                                      _emailController.text
                                          .endsWith("@hotmail.com") ||
                                      _emailController.text
                                          .endsWith("@outlook.com")) {
                                    return null;
                                  } else {
                                    return "Please Enter a valid email address";
                                  }
                                },
                                keyBoardType: TextInputType.emailAddress,
                                controller: _emailController,
                                hintText: 'example@domain.com'),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppDefaults.padding / 2),
                              child: Text(
                                "Date Of Birth*",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            CustomFormField(
                                keyBoardType: TextInputType.datetime,
                                controller: _dobController,
                                hintText: 'DD.MM.YYY',
                                readOnly: true,
                                onTap: () {
                                  _selectDateFromPicker(context);
                                }),
                            // TextFormField(
                            //     cursorColor: AppColors.primary,
                            //     controller: _dobController,
                            //     readOnly: true,
                            //     decoration: InputDecoration(
                            //       focusedBorder: const OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: AppColors.coloredBackground)),
                            //       border: const OutlineInputBorder(
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(10))),
                            //       hintText: "Date Of Birth",
                            //       suffixIcon: IconButton(
                            //         onPressed: () =>
                            //             _selectDateFromPicker(context),
                            //         icon: const Icon(
                            //             Icons.calendar_today_outlined),
                            //       ),
                            //     )),
                            SizedBox(
                              height: 30.spMax,
                            ),
                            Text(
                              'Delivery Address Information',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10.spMax,
                            ),
                            Center(
                              child: Container(
                                width: 300.spMax,
                                height: 35.spMax,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.primary),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          _checkPermissionAndGetLocation();

                                          setState(() {
                                            manual = false;
                                            pin = !pin;
                                          });
                                        },
                                        child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.ease,
                                            height: 35.spMax,
                                            width: 150.spMax,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: pin
                                                  ? AppColors.primary
                                                  : Colors.white,
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Pin Location",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color: pin
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                            ))),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            manual = !manual;
                                            pin = false;
                                          });
                                        },
                                        child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.ease,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: manual
                                                  ? AppColors.primary
                                                  : Colors.white,
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Manual Entry",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: !pin
                                                          ? Colors.white
                                                          : Colors.black),
                                            ))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.spMax,
                            ),
                            pin == true
                                ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 300.spMax,
                                        child: GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                            target: _initialPosition,
                                            zoom:
                                                12.0, // Adjust zoom level as needed
                                          ),

                                          indoorViewEnabled: true,
                                          // markers: _markers,
                                          onMapCreated: (controller) {
                                            _mapController = controller;
                                          },
                                          onTap: _onMapTapped,

                                          onCameraMove: (position) {
                                            _initialPosition = position.target;
                                          },
                                          gestureRecognizers: {
                                            Factory<OneSequenceGestureRecognizer>(
                                                () =>
                                                    EagerGestureRecognizer()), // Allows the map to handle gestures
                                          },
                                        ),
                                      ),
                                      const Icon(
                                        Icons.location_pin,
                                        size: 50,
                                        color: AppColors.primary,
                                      ),
                                      // Confirm button at the bottom
                                      Positioned(
                                        width: 200.spMax,
                                        bottom: 20,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _selectedLocation =
                                                  _initialPosition;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Location selected: ${_initialPosition.latitude}, ${_initialPosition.longitude}"),
                                              ),
                                            );
                                          },
                                          child: const Text('Confirm Location'),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 60,
                                          left: 20,
                                          child: CircleAvatar(
                                            backgroundColor: AppColors.primary,
                                            child: InkWell(
                                                child: const Icon(
                                                  Icons.my_location,
                                                  color: Colors.white,
                                                ),
                                                onTap: () async {
                                                  final location =
                                                      await _location
                                                          .getLocation();
                                                  final currentPosition =
                                                      LatLng(location.latitude!,
                                                          location.longitude!);

                                                  _mapController.animateCamera(
                                                      CameraUpdate.newLatLng(
                                                          currentPosition));
                                                  _addMarker(currentPosition,
                                                      "Current Location");
                                                }),
                                          ))
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              AppDefaults.padding / 2),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom:
                                                    AppDefaults.padding / 2),
                                            child: Text(
                                              "Governorate*",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 180.h,
                                          child: Card(
                                            elevation: 2,
                                            child: DropdownButton(
                                                value: _selectedGovernorate,
                                                hint: const Padding(
                                                  padding: EdgeInsets.all(
                                                      AppDefaults.padding / 2),
                                                  child: Text("Governorate"),
                                                ),
                                                underline: Container(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                isExpanded: true,
                                                items: _Governorate.map((item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              AppDefaults
                                                                      .padding /
                                                                  2),
                                                      child: Text(item),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedGovernorate =
                                                        value;
                                                    _selectedDistrict = null;
                                                    _selectedTown = null;
                                                    _district.clear();
                                                    _towns.clear();
                                                    for (int i = 0;
                                                        i <
                                                            items[_Governorate
                                                                        .indexOf(
                                                                            "$_selectedGovernorate")]
                                                                    ["cities"]
                                                                .length;
                                                        i++) {
                                                      // print(_items[_Governorate.indexOf(
                                                      //         "$_selectedGovernante")]
                                                      //     ["cities"][i]['name']);
                                                      _district.add(items[
                                                              _Governorate.indexOf(
                                                                  "$_selectedGovernorate")]
                                                          [
                                                          "cities"][i]['name']);
                                                    }
                                                  });
                                                }),
                                          ),
                                        ),
                                        _autoCorrect
                                            ? _selectedGovernorate == null
                                                ? const Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      'Please enter your governorate',
                                                    ),
                                                  )
                                                : Container()
                                            : SizedBox(
                                                height: 5.h,
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              AppDefaults.padding / 2),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom:
                                                    AppDefaults.padding / 2),
                                            child: Text(
                                              "District*",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 180.h,
                                          child: Card(
                                            elevation: 2,
                                            child: DropdownButton(
                                                value: _selectedDistrict,
                                                hint: const Padding(
                                                  padding: EdgeInsets.all(
                                                      AppDefaults.padding / 2),
                                                  child: Text("District"),
                                                ),
                                                underline: Container(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                isExpanded: true,
                                                items: _selectedGovernorate ==
                                                        null
                                                    ? empty.map((item) {
                                                        return DropdownMenuItem(
                                                          value: item,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    AppDefaults
                                                                            .padding /
                                                                        2),
                                                            child: Text(item),
                                                          ),
                                                        );
                                                      }).toList()
                                                    : _district.map((item) {
                                                        return DropdownMenuItem(
                                                          value: item,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    AppDefaults
                                                                            .padding /
                                                                        2),
                                                            child: Text(item),
                                                          ),
                                                        );
                                                      }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedDistrict = value;
                                                    _selectedTown = null;
                                                    _towns.clear();
                                                    for (int i = 0;
                                                        i <
                                                            items[_Governorate.indexOf(
                                                                            "$_selectedGovernorate")]
                                                                        [
                                                                        "cities"]
                                                                    [_district
                                                                        .indexOf(
                                                                            "$_selectedDistrict")]["towns"]
                                                                .length;
                                                        i++) {
                                                      _towns.add(items[_Governorate
                                                                      .indexOf(
                                                                          "$_selectedGovernorate")]
                                                                  ["cities"][
                                                              _district.indexOf(
                                                                  "$_selectedDistrict")]
                                                          ["towns"][i]);
                                                    }
                                                  });
                                                }),
                                          ),
                                        ),
                                        _autoCorrect
                                            ? _selectedDistrict == null
                                                ? const Padding(
                                                    padding: EdgeInsets.all(2),
                                                    child: Text(
                                                      'Please enter your district',
                                                    ),
                                                  )
                                                : Container()
                                            : SizedBox(
                                                height: 5.h,
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              AppDefaults.padding / 2),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom:
                                                    AppDefaults.padding / 2),
                                            child: Text(
                                              "Microregion*",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 180.h,
                                          child: Card(
                                            elevation: 2,
                                            child: DropdownButton(
                                                value: _selectedTown,
                                                hint: const Padding(
                                                  padding: EdgeInsets.all(
                                                      AppDefaults.padding / 2),
                                                  child: Text("Town/Village"),
                                                ),
                                                underline: Container(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                isExpanded: true,
                                                items: _selectedDistrict == null
                                                    ? empty.map((item) {
                                                        return DropdownMenuItem(
                                                          value: item,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    AppDefaults
                                                                            .padding /
                                                                        2),
                                                            child: Text(item),
                                                          ),
                                                        );
                                                      }).toList()
                                                    : _towns.map((item) {
                                                        return DropdownMenuItem(
                                                          value: item,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    AppDefaults
                                                                            .padding /
                                                                        2),
                                                            child: Text(item),
                                                          ),
                                                        );
                                                      }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedTown = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                        _autoCorrect
                                            ? _selectedTown == null
                                                ? const Padding(
                                                    padding: EdgeInsets.all(2),
                                                    child: Text(
                                                      'Please enter your microregion',
                                                    ),
                                                  )
                                                : Container()
                                            : SizedBox(
                                                height: 30.h,
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: AppDefaults.padding / 2),
                                          child: Text(
                                            "Street*",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                        CustomFormField(
                                            validator: (value) {
                                              if (value!.isEmpty &&
                                                  _selectedLocation == null) {
                                                return 'Please Enter your street address';
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyBoardType: TextInputType.text,
                                            controller: _streetController,
                                            hintText: 'Street'),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: AppDefaults.padding / 2),
                                          child: Text(
                                            "Nearby",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                        CustomFormField(
                                            validator: (value) {
                                              if (value!.isEmpty &&
                                                  _selectedLocation == null) {
                                                return 'Please Enter your nearby address';
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyBoardType: TextInputType.text,
                                            controller: _nearbyController,
                                            hintText: 'Nearby'),
                                      ]),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppDefaults.padding / 2),
                              child: Text(
                                "Building Name*",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            CustomFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter your building name';
                                  } else {
                                    return null;
                                  }
                                },
                                hintText: 'Building Name',
                                keyBoardType: TextInputType.text,
                                controller: _buildingNameController),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppDefaults.padding / 2),
                              child: Text(
                                "Floor*",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            CustomFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter your floor number';
                                  } else {
                                    return null;
                                  }
                                },
                                hintText: 'Floor Number',
                                keyBoardType: TextInputType.number,
                                controller: _floorController),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  int year = DateTime.now().year;
  late DateTime? picked;
  Future<void> _selectDateFromPicker(BuildContext context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 1),
        firstDate: DateTime(DateTime.now().year - 85),
        lastDate: DateTime(DateTime.now().year));

    if (picked != null) {
      setState(() {
        _dobController.text =
            "${picked!.day}/ ${picked!.month}/ ${picked!.year}";
        _dobController.text =
            "${picked!.day}/ ${picked!.month}/ ${picked!.year}";
      });
    }
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.keyBoardType,
      required this.controller,
      required this.hintText,
      this.inputFormatters,
      this.validator,
      this.readOnly,
      this.onTap});
  final TextInputType keyBoardType;
  final TextEditingController controller;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onTap: onTap,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatters,
          validator: validator,
          cursorColor: AppColors.primary,
          controller: controller,
          keyboardType: keyBoardType,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.coloredBackground)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

_dialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Center(
            child: Text(
              "Error",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "The information appears to be incorrect or missing; please try to correct them.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "close",
                  style: Theme.of(context).textTheme.labelMedium,
                ))
          ],
        );
      });
}
