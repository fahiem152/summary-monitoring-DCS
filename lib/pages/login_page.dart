import 'package:flutter/material.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/button_default.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final List<String> items = [
    'Admin Material',
    'Admin Finish Good',
    'Manager / BOD',
  ];
  String? roles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounColor1,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'DCS Production',
                  style: textOpenSans.copyWith(
                    color: blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Warehouse & Delivery',
                  style: textOpenSans.copyWith(
                    color: black2Color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Center(
                  child: SizedBox(
                    height: 150,
                    child: Image.asset('assets/images/logo-vector.png'),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset:
                            const Offset(3, 0), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    color: whiteColor),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NIS',
                        style: textOpenSans.copyWith(
                          color: black2Color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Your NIS',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password',
                        style: textOpenSans.copyWith(
                          color: black2Color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            obscureText: _secureText,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Your Password',
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_outlined
                                    : Icons.visibility),
                                color: const Color(0xff4B556B),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password',
                        style: textOpenSans.copyWith(
                          color: black2Color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: const ImageIcon(
                                AssetImage('assets/icons/arrow-down.png'),
                              ),
                              dropdownColor: whiteColor,
                              borderRadius: BorderRadius.circular(15),
                              isExpanded: true,
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: textOpenSans.copyWith(
                                            color: blackColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              hint: Text(
                                'Select Role Here',
                                style: textOpenSans.copyWith(
                                  color: blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              menuMaxHeight: 300,
                              value: roles,
                              onChanged: (value) {
                                setState(() {
                                  roles = value as String;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ButtonCustom(
                        title: 'Login',
                        press: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}