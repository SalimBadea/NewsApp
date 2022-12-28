// ignore_for_file: body_might_complete_normally_nullable, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../modules/webView/webview_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function btnPressed,
  required String text,
}) =>
    Container(
      color: background,
      width: width,
      child: MaterialButton(
        onPressed: () {
          btnPressed();
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

class DefaultTextField extends StatelessWidget {
  DefaultTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.textInputType,
    this.isPassword = false,
    this.validate,
    this.suffix,
    this.prefix,
    this.suffixPressed,
    this.onChange,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;
  String labelText = '';
  bool? isPassword;
  IconData? suffix = Icons.remove_red_eye_outlined;
  IconData? prefix = Icons.email;
  Function? suffixPressed;
  Function? onChange;
  String? validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword!,
      validator: (value) {
        if (controller.text.isEmpty) {
          return '$validate field required';
        } else {
          if (labelText == 'Password') {
            if (controller.text.length < 5) {
              return 'password must 8';
            }
          } else if (labelText == 'Email Address') {
            if (!controller.text.contains("@")) {
              return 'Enter valid Email';
            }
          } else if (labelText == 'Search') {
            return '$validate field required';
          }
        }
      },
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            suffixPressed!();
          },
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => listDivider(),
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

Widget listDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
