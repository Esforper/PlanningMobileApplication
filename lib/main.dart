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
        return AlertDialog(
          title: Text('Yeni Aktivite Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Başlık',
                ),
                onChanged: (value) {
                  // Başlık alanındaki değişiklikleri takip etmek için gerekiyor.
                  // Şu anlık bir işlem yapmıyoruz.
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Açıklama',
                ),
                onChanged: (value) {
                  // Açıklama alanındaki değişiklikleri takip etmek için gerekiyor.
                  // Şu anlık bir işlem yapmıyoruz.
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
                final newActivity = Activity(
                  id: UniqueKey().toString(),
                  title: 'Başlık', // Burada başlık metni girişini almalısınız
                  description: 'Açıklama', // Burada açıklama metni girişini almalısınız
                  createdAt: DateTime.now(),
                );

                setState(() {
                  _activities.add(newActivity);
                });

                Navigator.of(context).pop();
              },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Popup'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Textbox1 Alanı'),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Textbox1',
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Textbox2 Alanı'),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Textbox2',
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
