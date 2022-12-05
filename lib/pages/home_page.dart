import 'package:flutter/material.dart';
import 'package:monitoring_mobile/helper/user_info.dart';
import 'package:monitoring_mobile/list/list_body_home.dart';
import 'package:monitoring_mobile/pages/get_started_page.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/home_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String role = '';
  String firstName = '';
  String lastName = '';

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      role = preferences.getString("role")!;
      firstName = preferences.getString("firstName")!;
      lastName = preferences.getString("lastName")!;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    // AppBar
    PreferredSize getAppbar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: whiteColor,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Image.asset(
                      "assets/images/img_profile.png",
                      width: 50,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            firstName == ''
                                ? 'Waiting'
                                : firstName + ' ' + lastName,
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            role == '' ? 'Waiting' : role,
                            style: blackTextStyle.copyWith(
                              fontWeight: regular,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "DCS Production",
                          desc: "Do you want logout ?",
                          buttons: [
                            DialogButton(
                              child: const Text(
                                "Cencel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            ),
                            DialogButton(
                              color: Colors.red,
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => logout().then((value) =>
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const GetStartedPage()),
                                      (route) => false)),
                              width: 120,
                            )
                          ],
                        ).show();
                      },
                      child: Image.asset(
                        "assets/images/btn_logout.png",
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget getBody() {
      return SingleChildScrollView(
        child: Container(
          color: backgrounColor1,
          child: Padding(
            padding: EdgeInsets.all(defaultMargin),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listBodyHome.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 14,
              ),
              itemBuilder: (context, index) => BodyHome(
                tap: () {
                  // if (listBodyHome[index] == 0) {
                  //   print('Monitoring Stock');
                  // }
                  Navigator.pushNamed(context, '/detail-stock-fg');
                },
                listBodyHome: listBodyHome[index],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: getAppbar(),
      body: getBody(),
    );
  }
}
