import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/core/constants/app_size.dart';

class JSpace {
  static Widget horizontal(double space) {
    return SizedBox(width: AppSize.width * (space / 1000));
  }

  static Widget vertical(double space) {
    return SizedBox(height: AppSize.height * (space / 1000));
  }
}
