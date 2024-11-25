import 'package:eos_todolist/screens/add_button.dart';
import 'package:eos_todolist/screens/todo_item.dart';
import 'package:eos_todolist/screens/setting_screen.dart';
import 'package:flutter/material.dart';


class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  List toDoLists = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    toDoLists.add("111111");
    toDoLists.add("222222");
    toDoLists.add("333333");
  }

  void _showAddToDoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("할 일 추가"),
            content: TextField(
              controller: _textController,
              decoration: InputDecoration(
                  hintText: "할 일을 입력하세요",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              maxLength: 20,
            ),
            actions: [
              TextButton(
                onPressed: (){
                  _textController.clear();
                  Navigator.of(context).pop();
                },
                child: Text("취소"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if(_textController.text.isNotEmpty) {
                      toDoLists.add(_textController.text);
                    }
                    _textController.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: Text("확인"),
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFA4C639).withOpacity(0.1),
          title: Text('EOS Todolist'),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/week7.png'),
          ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
          ),
        ]
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 10,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/week7.png'),
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EOS'),
                    Text(
                      '고동영',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('안녕하세요'),
                  ],
                ),
              ],
            ),
          ),

          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 300,
                  decoration: BoxDecoration(
                    color: Color(0xFFA4C639).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: MediaQuery.of(context).size.width / 2 - 75,
                child: Container(
                  width: 150,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Color(0xFFA4C639).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "To do list",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(
                  top: 80,
                  left: 40,
                  right: 25
              ),
              child: Container(
                height: MediaQuery.of(context).size.height - 400,
                child: ListView.builder(
                  itemCount: toDoLists.length,
                  itemBuilder: (BuildContext context, int index){
                  return ToDoItem(
                    title: toDoLists[index],
                    onDelete: () {
                      setState(() {
                        toDoLists.removeAt(index);
                      });
                    },
                  );
                },
                ),
              ),
              ),
              Positioned(
                bottom: 30,
                  right: 50,
                  child: AddButton(
                    onPressed: _showAddToDoDialog,
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
