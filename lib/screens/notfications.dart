import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notfications extends StatelessWidget {
  const Notfications({Key? key}) : super(key: key);
  static const id = 'Notfications';

  @override
  Widget build(BuildContext context) {
    List<RemoteNotification?> notfications =
        ModalRoute.of(context)!.settings.arguments as List<RemoteNotification?>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffeacded),
        title: Text(
          'Chat',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xff9e59aa),
          ),
        ),
      ),
      body: notfications.isEmpty
          ? const Center(child: Text('There is No data'))
          : ListView.builder(
              itemCount: notfications.length,
              itemBuilder: (context, index) {
                if (notfications[index] != null) {
                  return ListTile(
                    title: Text('${notfications[index]?.title}'),
                    subtitle: Text('${notfications[index]?.body}'),
                  );
                }
                return const SizedBox();
              },
            ),
    );
  }
}
