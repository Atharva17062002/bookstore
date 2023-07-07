import 'dart:convert';

import 'package:bookstore/Constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle ({
required http.Response response,
required BuildContext context,
required VoidCallback onSuccess// Function ()?
}) {
  switch(response.statusCode){
    case 200:
      onSuccess();
    break;
    case 400:
      showsnackBar(context, jsonDecode(response.body)['msg']);
    case 500:
      showsnackBar(context, jsonDecode(response.body)['error']);
    default:
      showsnackBar(context, response.body);
  }
}