import 'package:flutter/material.dart';
import 'package:monitoring_mobile/helper/user_info.dart';
import 'package:monitoring_mobile/list/list_body_home.dart';
import 'package:monitoring_mobile/pages/get_started_page.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/dashline.dart';
import 'package:monitoring_mobile/widgets/home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                            "Mitsubishi Motors",
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "Manager / BOD",
                            style: blackTextStyle.copyWith(
                              fontWeight: regular,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        logout().then((value) => Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GetStartedPage()),
                                (route) => false));
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
                  Navigator.pushNamed(context, '/detail-home');
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
