import 'dart:convert';

import 'package:artconnected/models/user_model.dart';
import 'package:artconnected/utility/my_constant.dart';
import 'package:artconnected/utility/my_dialog.dart';
import 'package:artconnected/widgets/show_image.dart';
import 'package:artconnected/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  final formkey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dart,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeCreateAccount),
        child: Text('New'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.0,
            colors: [Colors.white, MyConstant.light],
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                newImage(),
                newAppName(),
                buildUser(),
                buildPassword(),
                buildLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: 250,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: MyConstant.dart,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: () {
              if (formkey.currentState!.validate()) {
                checkLogin();
              }
            },
            child: Text('Login'),
          ),
        ),
      ],
    );
  }

  Future<Null> checkLogin() async {
    String path =
        '${MyConstant.domain}/artConnected/getUserWhereUser.php?isAdd=true&user=${userController.text}';
    await Dio().get(path).then((value) {
      print('value ==>$value');
      if (value.toString() == 'null') {
        MyDialog()
            .normalDialog(context, 'User False', 'ไม่มี  User นี้ในฐานข้อมูล');
      } else {
        var result = json.decode(value.data);
        print('result = $result');
        for (var item in result) {
          UserModel model = UserModel.fromMap(item);
          if (passController.text == model.password) {
            Navigator.pushNamedAndRemoveUntil(
                context, MyConstant.routeMyservice, (route) => false);
          } else {
            MyDialog().normalDialog(
                context, 'Password False', 'please Try Again Password False');
          }
        }
      }
    });
  }

  Row buildUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: 250,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill  user';
              } else {
                return null;
              }
            },
            controller: userController,
            decoration: InputDecoration(
              labelText: 'User :',
              prefixIcon: Icon(Icons.perm_identity),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: 250,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill password';
              } else {
                return null;
              }
            },
            controller: passController,
            obscureText: redEye,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      redEye = !redEye;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye)),
              labelText: 'Password :',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row newAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          child: ShowTitle(
            title: MyConstant.appName,
            textStyle: MyConstant().h1Style(),
          ),
        ),
      ],
    );
  }

  Row newImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          child: ShowImage(),
        ),
      ],
    );
  }
}
