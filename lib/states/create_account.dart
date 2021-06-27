import 'package:artconnected/utility/my_constant.dart';
import 'package:artconnected/utility/my_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final forKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  Row buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: 250,
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Name in Blank';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'Name :',
              prefixIcon: Icon(Icons.fingerprint),
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

  Row buildUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: 250,
          child: TextFormField(
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill User in Blank';
              } else {
                return null;
              }
            },
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
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Password in Blank';
              } else {
                return null;
              }
            },
            obscureText: true,
            decoration: InputDecoration(
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

  Row buildRePassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: 250,
          child: TextFormField(
            controller: rePasswordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Re-Password in Blank';
              } else {
                return null;
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Re-Password :',
              prefixIcon: Icon(Icons.lock),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildNewAccount()],
        title: Text('สร้าง สมาชิกใหม่'),
        backgroundColor: MyConstant.dart,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: forKey,
          child: ListView(
            children: [
              buildName(),
              buildUser(),
              buildPassword(),
              buildRePassword(),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> insertNewAccount() async {
    String path =
        '${MyConstant.domain}/artConnected/getUserWhereUser.php?isAdd=true&user=${userController.text}';
    print('part =$path');
    await Dio().get(path).then((value) async {
      print('value =$value');
      if (value.toString() == 'null') {
        String apiInsertData =
            '${MyConstant.domain}/artConnected/insertData.php?isAdd=true&name=${nameController.text}&user=${userController.text}&password=${passwordController.text}';
        await Dio().get(apiInsertData).then((value) {});
        if (value.toString() == 'true') {
          Navigator.pop(context);
        } else {
          MyDialog().normalDialog(
              context, 'Cannot Create Accout', 'Please Try Again');
        }
      } else {
        MyDialog().normalDialog(
            context, 'User False', 'ไม่สามารถใช้ user นี้ได้มีคนอื่นใช้แล้ว');
      }
    });
  }

  IconButton buildNewAccount() => IconButton(
        onPressed: () {
          if (forKey.currentState!.validate()) {
            if (passwordController.text == rePasswordController.text) {
              insertNewAccount();
            } else {
              MyDialog().normalDialog(context, 'Password ไม่เหมือนกัน',
                  'กรุณากรอก  Password ให้เหมือนกัน');
            }
          }
        },
        icon: Icon(Icons.cloud_upload),
      );
}
