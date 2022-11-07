import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/userdetailresponsemodel.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/services/apiserviceteacher.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<UserDetailsResponseModel>? userDetails;
  String? userId;
  bool updated = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  @override
  getData() async {
    //GETTING USER ID WITH THE HELPOF TOKEN
    userId = await getUserAppId();
    //GETTING USER DETAILS WITH USER ID
    userDetails = getUserDetails(userId!);
    setState(() {});
    print("*-********************************************************");
    print(userId);
    print(userDetails);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: FutureBuilder<UserDetailsResponseModel>(
                future: userDetails,
                builder: (context,
                    AsyncSnapshot<UserDetailsResponseModel> snapshot) {
                  if (snapshot.data == null ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        child: CircularProgressIndicator(color: darkBlueColor),
                      ),
                    );
                  } else if (snapshot.hasData ||
                      snapshot.data != null ||
                      snapshot.connectionState == ConnectionState.done) {
                    var userFinalDetails = snapshot.data;
                    return Column(
                      // "fullName": "Subin Gurung",
                      // "address": "Kadaghari",
                      // "gender": "Male",
                      // "id": "0c188464-ba3d-4493-ac40-1ab1de31178c",
                      // "userName": "nobig22@gmail.com",
                      // "normalizedUserName": "NOBIG22@GMAIL.COM",
                      // "email": "nobig22@gmail.com",
                      // "normalizedEmail": "NOBIG22@GMAIL.COM",
                      // "emailConfirmed": true,
                      // "passwordHash": "AQAAAAEAACcQAAAAEMvs+jRkP02HSwGWF77uDpXFhFZnEB3yApvxSg/LICCUR+2+8BZijZEffy0G8igwQg==",
                      // "securityStamp": "IVSRTA5AA6QYEDWKHRYIZNWLAUQQXN2J",
                      // "concurrencyStamp": "d31b4c89-547a-47af-bc81-5b4f6f7a5e78",
                      // "phoneNumber": null,
                      // "phoneNumberConfirmed": false,
                      // "twoFactorEnabled": false,
                      // "lockoutEnd": null,
                      // "lockoutEnabled": true,
                      // "accessFailedCount": 0

                      children: [
                        //for circle avtar image
                        _getHeader(),

                        _profileName(userFinalDetails!.fullName.toString()),
                        //userFinalDetails['fullName'].toString()),
                        const SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const Divider(
                            height: 10,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _heading("Account Details"),
                            // SizedBox(
                            //   height: 6,
                            // ),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit))
                          ],
                        ),
                        _detailsCard(userFinalDetails.userName.toString(),
                            userFinalDetails.phoneNumber.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const Divider(
                            height: 10,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _heading("Profile Details"),
                            IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      //barrierDismissible: false,
                                      title: "Update Profile",
                                      middleText:
                                          "You will have your private class in zoom video calling app",
                                      content: Column(
                                        children: [
                                          TextFormField(
                                            controller: nameController,
                                            //obscureText: isPassword,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              // labelText: "NabinGurung",
                                              errorText: null,
                                              // prefixIcon: Icon(
                                              //  // icon,
                                              //   color: iconColor,
                                              // ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: textColor1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(35.0)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: textColor1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(35.0)),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              hintText: "Your Name",
                                              hintStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 136, 136, 136)),
                                            ),
                                            // validator: (value) {
                                            //   if (value!.isEmpty) {
                                            //     print("====================================");
                                            //     print("object");
                                            //     setState(() {
                                            //       isValid = !isValid;
                                            //     });
                                            //     return 'Please Enter Name';
                                            //   }
                                            //   return null;
                                            // },
                                            // onSaved: (String? value) {
                                            //   textValue = value;
                                            // },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: genderController,
                                            //obscureText: isPassword,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              // labelText: "NabinGurung",
                                              errorText: null,
                                              // prefixIcon: Icon(
                                              //  // icon,
                                              //   color: iconColor,
                                              // ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: textColor1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(35.0)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: textColor1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(35.0)),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              hintText: "Male",
                                              hintStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 136, 136, 136)),
                                            ),
                                            // validator: (value) {
                                            //   if (value!.isEmpty) {
                                            //     print("====================================");
                                            //     print("object");
                                            //     setState(() {
                                            //       isValid = !isValid;
                                            //     });
                                            //     return 'Please Enter Name';
                                            //   }
                                            //   return null;
                                            // },
                                            // onSaved: (String? value) {
                                            //   textValue = value;
                                            // },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // TextFormField(
                                          //   //       initialValue:
                                          //   //   userFinalDetails.address,
                                          //   controller: phonenumberController,
                                          //   //obscureText: isPassword,
                                          //   keyboardType: TextInputType.text,
                                          //   decoration: InputDecoration(
                                          //     // labelText: "NabinGurung",
                                          //     errorText: null,
                                          //     // prefixIcon: Icon(
                                          //     //  // icon,
                                          //     //   color: iconColor,
                                          //     // ),
                                          //     enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //           color: textColor1),
                                          //       borderRadius:
                                          //           const BorderRadius.all(
                                          //               Radius.circular(35.0)),
                                          //     ),
                                          //     focusedBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //           color: textColor1),
                                          //       borderRadius:
                                          //           const BorderRadius.all(
                                          //               Radius.circular(35.0)),
                                          //     ),
                                          //     contentPadding:
                                          //         const EdgeInsets.all(10),
                                          //     hintText: "9846458568",
                                          //     hintStyle: const TextStyle(
                                          //         fontSize: 14,
                                          //         color: Color.fromARGB(
                                          //             255, 136, 136, 136)),
                                          //   ),
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          TextFormField(
                                            //       initialValue:
                                            //   userFinalDetails.address,
                                            controller: addressController,
                                            //obscureText: isPassword,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              // labelText: "NabinGurung",
                                              errorText: null,
                                              // prefixIcon: Icon(
                                              //  // icon,
                                              //   color: iconColor,
                                              // ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: textColor1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(35.0)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: textColor1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(35.0)),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              hintText: "Your Address",
                                              hintStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 136, 136, 136)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        // RaisedButton(
                                        //     color: Colors.red,
                                        //     child: Text(
                                        //       "Cancel",
                                        //       style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontSize: 18,
                                        //           fontWeight: FontWeight.bold),
                                        //     ),
                                        //     onPressed: () {
                                        //       print("MEETING HAS NOT ENDED");
                                        //       Navigator.of(context,
                                        //               rootNavigator: true)
                                        //           .pop();
                                        //     }),
                                        RaisedButton(
                                          color: Colors.red,
                                          child: const Text(
                                            "Update",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // : CircularProgressIndicator(),
                                          onPressed: () async {
                                            //setState(() {});
                                            const CircularProgressIndicator();
                                            bool isUpdated =
                                                await updateProfile(
                                                    nameController.text,
                                                    genderController.text,
                                                    addressController.text,
                                                    phonenumberController.text);
                                            if (isUpdated) {
                                              setState(() {});
                                              getData();
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Your details has been updated",
                                              );
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Updating details unsuccessfull",
                                              );
                                            }
                                          },
                                        )
                                      ],
                                      buttonColor: Colors.white);
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),

                        _settingsCard(userFinalDetails.fullName!,
                            userFinalDetails.gender, userFinalDetails.address),
                        const Spacer(),
                        //logoutButton()
                      ],
                    );
                  }
                  return Container();
                }),
          ),
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: CachedNetworkImage(
            imageUrl:
                "https://i.pinimg.com/originals/c8/f1/46/c8f14613fdfd69eaced69d0f1143d47d.jpg",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            placeholder: (context, url) {
              return const CircularProgressIndicator();
            },
          ),
        )
      ],
    );
  }

  Widget _profileName(String name) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return SizedBox(
      //color: Colors.red,
      width: MediaQuery.of(context).size.width * 0.6, //80% of width,
      child: Text(
        heading,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _detailsCard(String email, String? phoneNumber) {
    //  if(phoneNumber is null){}
    var number = phoneNumber == "null" ? "Add Phone Number" : phoneNumber;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              leading: const Icon(Icons.mail),
              title: Text(email),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(
                  phoneNumber == "null" ? "Add Phone Number" : phoneNumber!),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsCard(String name, gender, address) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              leading: const Icon(CupertinoIcons.profile_circled),
              title: Text(name),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.male),
              title: Text(gender),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: Text(address == "null" ? "Add your address" : address!),
            )
          ],
        ),
      ),
    );
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {},
      child: Container(
          color: darkBlueColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          )),
    );
  }
}
