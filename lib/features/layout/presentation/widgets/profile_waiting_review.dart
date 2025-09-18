import 'package:flutter/material.dart';

class ProfileWaitingReview extends StatelessWidget {
  const ProfileWaitingReview({super.key, });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100.0,
                color: Colors.orange,
              ),
              Text(
                'فريق علي دربك',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Text(
                // 'تهانينا لقد قمت بخطوات التسجيل بنجاح\n'
                'لبدء العمل معنا عليك انتظار مراجعة\n'
                'بياناتك والموافقة عليها وسنعود إليك\n'
                'سريعا',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
