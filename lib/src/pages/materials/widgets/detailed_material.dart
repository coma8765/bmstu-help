import 'package:bmstu_help/src/domain/university/model.dart';
import 'package:flutter/material.dart';

class DetailedMaterial extends StatelessWidget {
  const DetailedMaterial({super.key, required this.material});

  final Content? material;

  @override
  Widget build(BuildContext context) {
    return Text(material!.title);
  }
}
