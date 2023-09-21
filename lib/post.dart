
import 'package:flutter/material.dart';

class PostSample extends StatelessWidget {
  const PostSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 100,width: double.maxFinite,color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
