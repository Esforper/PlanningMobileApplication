import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class Activity {
  String id;
  String title;
  String description;
  DateTime createdAt;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Günlük Rapor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DailyReportPage(),
    );
  }
}

class DailyReportPage extends StatefulWidget {
  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

//baslik saatini düzenle
String date1 = DateFormat("yyyy-MM-dd").format(DateTime.now());
class _DailyReportPageState extends State<DailyReportPage> {
  String _currentDate = date1;

  List<Activity> _activities = [];

  void _addActivity() async {
    final newActivity = await showDialog<Activity>(
      context: context,
      builder: (BuildContext context) {
        String description = "belirtilmemiş";
        String title = "belirtilmemiş";
        return AlertDialog(
          //popup ekran için
          title: Text('Yeni Aktivite Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Başlık',
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Açıklama',
                ),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                if(title != null && description != null){
                  final newActivity = Activity(
                    id: UniqueKey().toString(),
                    title: title, // Burada başlık metni girişini almalısınız
                    description: description, // Burada açıklama metni girişini almalısınız
                    createdAt: DateTime.now(),
                  );

                  setState(() {
                    _activities.add(newActivity);
                  });
                }

                Navigator.of(context).pop();
              },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  //ana sayfa tasarımı
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Günlük Rapor'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              _currentDate,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_activities[index].title),
                  // Aktiviteye tıklanınca düzenleme yapmak için
                  onTap: () {
                    String title = _activities[index].title;
                    String description = _activities[index].description;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Popup'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Başlık"),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: title,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text("Açıklama"),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: description,
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        child: Icon(Icons.add),
      ),
    );
  }
}
