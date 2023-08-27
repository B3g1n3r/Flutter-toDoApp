import 'package:flutter/material.dart';
import '../model/todo_model.dart';
import '../widgets/todo_item.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final toDoList = ToDo.todoList();
  final todoController = TextEditingController();
  List<ToDo> search = [];

  @override
  void initState() {
    search = toDoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 189, 189, 189),
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      searchBox(),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50, bottom: 20),
                              child: const Text(
                                'Todo List',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                            for (ToDo todoo in search.reversed )
                              TodoLists(
                                todo: todoo,
                                todoTracker: changesTracker,
                                onDelete: deleteItem,
                              )
                          ],
                        ),
                      )
                    ],
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 20, right: 20, left: 20),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                          hintText: "New Item",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        AddItem(todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 68, 168, 255),
                        minimumSize: const Size(60, 60),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  )
                ]),
              )
            ],
          )),
    );
  }

  void changesTracker(ToDo toDo) {
    setState(() {
      toDo.isDone = !(toDo.isDone ?? false);
    });
  }

  void deleteItem(String id) {
    setState(() {
      toDoList.removeWhere((element) => element.id == id);
    });
  }

  void AddItem(String newTodo) {
    setState(() {
      toDoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: newTodo));
    });
    todoController.clear();
  }

  void searchItem(String input) {
    List<ToDo> result = [];
    if (input.isEmpty) {
      result = toDoList;
    } else {
      result = toDoList
          .where((element) =>
              element.todoText!.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    setState(() {
      search = result;
    });
  }

  Container searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child:  TextField(
        onChanged: (value) =>searchItem(value) ,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Color.fromARGB(255, 119, 119, 119))),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor:const Color.fromARGB(255, 189, 189, 189),
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: Color.fromARGB(255, 0, 0, 0),
          size: 30,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset('assets/images/luffy.png'),
          ),
        )
      ]),
    );
  }
}
