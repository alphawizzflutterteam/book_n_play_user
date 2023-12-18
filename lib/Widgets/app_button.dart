

import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key,this.onTap, this.title }) : super(key: key);

 final String? title ;
  final VoidCallback? onTap ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width/1.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/(1.4)/2),color: AppColors.bluecolor),
        child: Center(
          child: Text(
            title ?? '',
            style: const TextStyle(
              //decoration: TextDecoration.underline,
              color: AppColors.whit,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
