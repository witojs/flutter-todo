# Todo App

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## To Do App Project

Kita akan membuat project To-do App. Pada Aplikasi ini kita dapat menambahkan To do, menceklis to untuk menandakan telah selesai dilakukan, serta menghapus todo. Kita juga akan menerapkan local storage dengan menggunakan Hive.

### Initial Setting

1. Buat project baru flutter baru dengan nama flutter create todo-app
2. Hapus semua code pada main.dart di folder lib. Sehingga code pada main.dart menjadi seperti berikut:

```dart
//main.dart
import 'package:flutter/material.dart';
import 'package:todo-app/theme.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}
```

3. Buat berkas dengan nama theme.dart, kita akan menambahkan konfigurasi tema untuk aplikasi.

```dart
//theme.dart
import 'package:flutter/material.dart';


ThemeData primaryTheme = ThemeData(

  //seed color
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
  ),

  //scaffold color
  scaffoldBackgroundColor: Colors.orange[300],

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),

);
```

4. Buat folder dengan nama pages kemudian buat berkas dengan nama homepage.dart

```dart
//homepage.dart
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

5. Masukan HomePage widget pada property home di main.dart

```dart
//main.dart
import 'package:flutter/material.dart';
import 'package:todo-app/theme.dart';
import 'package:todo-app/pages/homepage.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      home: const HomePage(),
    );
  }
}
```

### Membuat Halaman Homepage & ToDoTile

Halaman homepage akan menampilkan daftar to do list.

1. Buat folder baru dengan nama util kemudian buat berkas dengan nama todo_item.dart

```dart
//todo_item.dart
import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              //check box
              //task name
            ],
          ),
      ),
    );
  }
}
```

widget ToDoItem akan menerima 3 property yakni:

- taskName dengan value nama todo
- isCompleted dengan value boolean true atau false
- onChanged method untuk merubah nilai dari checkBox

2. Tambahkan variabel tersebut pada constructor ToDoItem, kemudian berikan widget CheckBox & Text.

```dart
//todo_item.dart
import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final Function(bool?)? onChanged;


  const ToDoItem({
    super.key,
    required this.taskName,
    required this.isCompleted,
    required this.onChanged,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.black,
                value: isCompleted,
                onChanged: onChanged
              ),
              Text(taskName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ],
          ),
      ),
    );
  }
}
```

Pada code di atas, Widget CheckBox menerima property activeColor yakni warna dari checkBox, value berupa nilai boolean dari variabel isCompleted dan method onChanged. Widget text menerima string berupa nilai dari variabel taskName. Kita juga memberikan conditional decoration yakni jika isCompleted bernilai true, maka Text akan diberikan garis jika bernilai false maka text normal.

3. Kembali ke halaman home.dart, Kita menampilkan ToDoItem secara dinamis. Dibawah class \_HomePageState, buat variabel List dengan nama toDoList. Buat juga method dengan nama checkBoxChanged. Method checkBoxChange menerima 2 parameter yakni value & index.

```dart
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false]
  ];

  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }
```

4. Pada bagian body panggil ListView.builder dengan property itemCount: toDoList.length dan itemBuilder yang me-return ToDoItem. Pastikan Widget ToDoItem di impor.

```dart
import 'package:flutter/material.dart';
import 'package:todo-app/pages/homepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false]
  ];

  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: const Text('TO DO'),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return ToDoItem(
            taskName: toDoList[index][0],
            isCompleted: toDoList[index][1],
            onChanged: (value){
              checkBoxChanged(value, index);
            },
          );
        },
      ),
    );
  }
}
```

5. Jalankan project, todo-app akan menampilkan todo item secara dinamis.

### Fitur menambahkan Todo

Selanjutnya kita akan membuat fitur untuk menambahkan todo.

1. Pada berkas homepage.dart tambahkan Widget floatingActionButon dengan child Icons.add

```dart
import 'package:flutter/material.dart';
import 'package:todo-app/pages/homepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false]
  ];

  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: const Text('TO DO'),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return ToDoItem(
            taskName: toDoList[index][0],
            isCompleted: toDoList[index][1],
            onChanged: (value){
              checkBoxChanged(value, index);
            },
          );
        },
      ),
    );
  }
}
```

2. Ketika FloatingActionButton tersebut diklik maka akan membuka dialog box dimana kita bisa mengisikan todo baru. Kita akan membuat custom dialogBox.
   Pada dialogbox kita akan membuat sebuah text field dengan 2 buah button, button untuk menyimpan todo dan button untuk membatalkan todo.

3. Buat berkas dengan nama my_button.dart pada folder util kemudian buat customs widget dengan nama MyButton yang merupakan stateless widget

```dart
//my_button.dart
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
```

MyButton akan menerima 2 property yakni text dan onPressed method.

4. Buat berkas dengan nama dialog_box.dart pada folder util dan buat customs widget dengan nama DialogBox.

```dart
//dialog_box.dart
import 'package:flutter/material.dart';
import 'package:playground/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a New Task',
              ),
            ),
            //button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(
                  text: 'Save',
                  onPressed: onSave,
                ),
                //cancel button
                const SizedBox(width: 8),
                MyButton(
                  text: 'Cancel',
                  onPressed: onCancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
```

Pada code di atas, DialogBox akan menerima 3 property yakni controller, onSave & onCancel. Variabel controller berfungsi untuk mengambil nilai text pada textField sedangkan onSave & onCancel merupakan method yang akan kita berikan pada DialogBox tersebut.

5. Kembali ke homepage.dart tambahkan variabel \_controller dengan value instance dari TextEditingController(). Buat juga method dengan nama createNewTask, method tersebut akan memunculkan DialogBox. Berikan property controller dengan nilai \_controller, property onSave dengan fungsi kosong dan property onCancel dengan memanggil method Navigator.of(context).pop() yang berfungsi untuk menutup halaman dialogBox. Pastikan Widget DialogBox di impor.

```dart
//homepage.dart
import 'package:flutter/material.dart';
import 'package:todo-app/pages/homepage.dart';
import 'package:todo-app/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false]
  ];

  //menambahkan text Controller
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //membuat method createNewTask
  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: (){},
          onCancel: ()=> Navigator.of(context).pop()
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: const Text('TO DO'),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        //menambahkan fungsi createNewTask pada property onPressed
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return ToDoItem(
            taskName: toDoList[index][0],
            isCompleted: toDoList[index][1],
            onChanged: (value){
              checkBoxChanged(value, index);
            },
          );
        },
      ),
    );
  }
}
```

6. Selanjutnya buat method saveNewTask. Pada method tersebut kita akan memanggil setState dimana pada body function kita menambahkan toDoList melalui .add method dengan value list yang berisi \_controller.text & nilai false.

```dart
import 'package:flutter/material.dart';
import 'package:todo-app/pages/homepage.dart';
import 'package:todo-app/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false]
  ];

  //text controller
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //save new task
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //create new Task
  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: ()=> Navigator.of(context).pop()
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //code disembunyikan
    );
  }
}
```

Pada method saveNewTask kita juga menghilangkan nilai TextField ketika telah menyimpan todo dengan memanggil \_controller.clear(), serta menutup dialog box dengan memanggil Navigator.of(context).pop().

7. Reload ulang aplikasi dan lakukan penambahan todo dengan mengklik tombol tambah.

### Menghapus Todo

Selanjutnya kita akan membuat fitur delete todo. Untuk interaksi yang menarik kita tambahkan dependenci flutter_slidable (https://pub.dev/packages/flutter_slidable).

1. Install package tersebut dengan menuliskan perintah berikut pada terminal.

```
flutter pub add flutter_slidable
```

2. Pada berkas todo_item.dart Bungkus Container dengan Widget Slidable

```dart
//todo_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ToDoItem extends StatelessWidget {
  final String taskName;
  final bool isCompleted;

  final Function(bool?)? onChanged;
  final Function(BuildContext)? onDelete;

  const ToDoItem({
    super.key,
    required this.taskName,
    required this.isCompleted,
    required this.onChanged,
    required this.onDelete
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      //menambahkan slidable
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          //code disembunyikan
        ),
      ),
    );
  }
}
```

Pada code di atas, kita membungkus Container Widget dengan Slidable Widget beberapa yang perlu diperhatikan yakni:

- endActionPane yakni arah komponen slidable yang dimunculkan dalam hal ini di akhir.
- motion, yakni interaksi animasi dari slidable
- SlidableAction berisi method onPressed dan icon

Pada method onPressed kita memberikan nilai onDelete sehingga kita menambahkan constructor onDelete pada ToDoItem.

3. Ke berkas homepage.dart tambahkan property onDelete pada ToDoItem dengan value deleteTask, kemudian buat method deleteTask. Method ini akan menerima parameter index dan memanggil fungsi setState. Pada body function setState kita menghapus data pada index tersebut dengan menggunakan method removeAt(index).

```dart
//homepage.dart
import 'package:flutter/material.dart';
import 'package:todo-app/pages/homepage.dart';
import 'package:todo-app/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false]
  ];

  //code lainnya disembunyikan

  //menambahkan method deleteTask
  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: const Text('TO DO'),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return ToDoItem(
            taskName: toDoList[index][0],
            isCompleted: toDoList[index][1],
            onChanged: (value){
              checkBoxChanged(value, index);
            },
            //menambahkan property onDelete
            onDelete: (context) => deleteTask,
          );
        },
      ),
    );
  }
}
```

4. Reload aplikasi dan coba slide ToDoItem untuk memunculkan icon delete, kemudian klik icon tersebut untuk menghapus item.

### Local Storage using Hive

Pada aplikasi todo yang kita kerjakan, ketika kita melakukan reload atapun keluar dari aplikasi. Data yang telah kita olah akan menghilang dan kembali ke awal. Kita akan menerapkan local storage agar perubahan yang dilakukan tetap tersimpan. Untuk melakukan hal tersebut kita akan memanfaat kan package hive
https://docs.hivedb.dev/#/

1. Pada pubspec.yaml tambahkan package berikut:

```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^1.1.3
  build_runner: ^2.1.11
```

2. Pada main.dart inisialiasai Hive dengan cara berikut:

```dart
//main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playground/pages/homepage.dart';
import 'package:playground/theme.dart';


void main() async {
  //init the hive
  await Hive.initFlutter();

  //open the box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: primaryTheme,
    );
  }
}
```

Pastikan kita telah mengimpor package hive.

3. Buat folder dengan nama database pada folder lib, kemudian buat berkas dengan nama database.dart

```dart
//database.dart
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('mybox');

  //run method if first time opening the app
  void createInitialData(){
    toDoList = [
      ['make tutorial', false],
      ['Do execise', false],
    ];
  }

  //load the data from database
  void loadData(){
    toDoList = _myBox.get('TODOLIST');
  }

  //update the database
  void updateDataBase(){
    _myBox.put('TODOLIST', toDoList);
  }
}
```

Pada class ToDoDatabase di atas, Kita membuat variabel List toDoList dan kita membuat private variabel \_myBox dengan menginisiasi Hive.box. Kemudian kita membuat method createInitialData, method ini akan memberikan value awal kepada variabel toDoList.
Pada class ToDoDatabase juga terdapat method loadData & UpdataDataBase. loadData akan mengambil data dari \_myBox dengan key 'TODOLIST'.Sedangkan method updateDataBase akan menyimpan data toDoList ke \_myBox.

4. Buka berkas homepage.dart, kita akan menghapus variabe toDoList dan mengganti nya dengan instance dati ToDoDatabase. Pada class \_HomePageState tuliskan code berikut:

```dart
//reference to hive box
  final _mybox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //if first time opening the app, create default data
    if(_mybox.get('TODOLIST') == null){
      db.createInitialData();
    } else {
      //data already exits
      db.loadData();
    }
    super.initState();
  }
```

Pada code di atas, kita membuat variabel \_mybox yang merupakan instance dari Hive. Kemudian kita membuat variabel dengan nama db dan memberikan value instance dari ToDoDatabase, pastikan kita mengimpor class tersebut.
Kita Selanjutnya melakukan proses ambil data di dalam method initState agar perubahan langsung dapat ditampilkan. Pada method tersebut kita melakukan pengecekan jika data dari local Storage 'TODOLIST' belum ada, maka kita memberikan data default dengan method db.createInitialData, jika sudah ada maka kita memanggil method db.loadData.

5. Jika kita perhatikan pada berkas homepage.dart akan terdapat banyak error, hal tersebut dikarenakan variabel toDoList telah kita hapus, sebagai ganti nya kita akan menggunakan db yang merupakan instance dari ToDoDatabase. Cara nya cukup mudah yakni kita hanya perlu menambahkan awalan db. kepada semua variabel toDoList.

6. Pada masing-masing method yakni:

- checkBoxChanged
- saveNewTask
- deleteTask
  Tambahkan method db.updateDatabase, agar setiap perubahan data kita kirimkan ke local storage. Sehingga code pada homepage.dart akan menjadi seperti berikut:

```dart
//homepage.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo-app/data/database.dart';
import 'package:todo-app/util/dialog_box.dart';
import 'package:todo-app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference to hive box
  final _mybox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //if first time opening the app, create default data
    if(_mybox.get('TODOLIST') == null){
      db.createInitialData();
    } else {
      //data already exits
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create new task
  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: ()=> Navigator.of(context).pop(),
        );
      }
    );
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: const Text('TO DO'),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0],
            isCompleted: db.toDoList[index][1],
            onChanged: (value){
              checkBoxChanged(value, index);
            },
            onDelete: (context)=> deleteTask(index),
          );
        },
      ),
    );
  }
}
```

7. Jalankan ulang aplikasi, maka perubahan yang telah kita lakukan pada aplikasi akan tetap tersimpan walaupun kita melakukan reload atau restart.
