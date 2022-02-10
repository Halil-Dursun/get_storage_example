import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GetStorage box = GetStorage();
  Map<String, bool> defaultSettings = {
    'Evli misiniz' : false,
    'Çalışıyor musunuz' :  false,
    'Lisans eğitimi aldınız mı' : true,
  };
  Map<String,dynamic> settings={};

  @override
  void initState() {
    settings = box.read('settings') ?? defaultSettings;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('GetStorage'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,itemCount: settings.length,itemBuilder: (context,index){
              String key = settings.keys.elementAt(index);
              return CheckboxListTile(title: Text(key),value: settings[key], onChanged: (value){
                setState(() {
                  settings[key] = value!;
                });
              });
            }),
            ElevatedButton(onPressed: () async{
              await box.write('settings', settings);
            }, child: Text('Save'))
          ],
        ),
      ),
    );
  }
}

