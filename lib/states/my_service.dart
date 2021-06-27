import 'dart:convert';
import 'dart:ffi';

import 'package:artconnected/models/test_model.dart';
import 'package:artconnected/utility/my_constant.dart';
import 'package:artconnected/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List<TestModel> testModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> readAllData() async {
    String path = '${MyConstant.domain}/artConnected/getAllData.php';
    await Dio().get(path).then((value) {
      for (var item in json.decode(value.data)) {
        TestModel model = TestModel.fromMap(item);
        setState(() {
          testModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body:testModels.length == 0 ? CircularProgressIndicator() :  buildContent(),
    );
  }

  Padding buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowTitle(title: 'Temp :', textStyle: MyConstant().h1Style()),
            buildGaugeLinear(9),
            buildGaugeLinear(4),
            buildGaugeLinear(18),
            ShowTitle(title: 'Pressure :', textStyle: MyConstant().h1Style()),
            Row(
              children: [
                buildGaugeRadial(90),
                buildGaugeRadial(120),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGaugeRadial(double value) => Container(
        width: 150,
        child: SfRadialGauge(
          axes: [
            RadialAxis(
              minimum: 0,
              maximum: 25,
              pointers: [NeedlePointer(value: value)],
            ),
          ],
        ),
      );

  Widget buildGaugeLinear(double value) => SfLinearGauge(
        maximum: 25,
        markerPointers: [
          LinearShapePointer(value: value),
        ],
        ranges: [
          LinearGaugeRange(
            startValue: 0,
            endValue: value,
          )
        ],
      );
}
