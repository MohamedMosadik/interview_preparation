// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interview_preparation/View/question_detail_screen.dart';
import 'package:interview_preparation/ViewModel/themeProvider.dart';
import 'package:provider/provider.dart';

import '../Model/questionModel.dart';
import '../ViewModel/cloudFirebase.dart';
import '../ViewModel/connectInternet.dart';
import '../ViewModel/isolate.dart';
import '../ViewModel/sqlf.dart';
import '../ViewModel/themeLightDark.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  late DataBase handler;
  late CloudFirestoreService dbFirebase;
  // File? _image;
  QuestionsModel? firstQuestions;
  QuestionsModel? secondQuestions;
  QuestionsModel? thirdQuestions;
  QuestionsModel? fourthQuestions;

  QuestionsModel? fiveQuestions;
  QuestionsModel? sexQuestions;
  QuestionsModel? sevenQuestions;
  QuestionsModel? eightQuestions;

  QuestionsModel? nineQuestions;
  QuestionsModel? tenQuestions;
  QuestionsModel? elevenQuestions;
  QuestionsModel? twelvelvQuestions;

  List<QuestionsModel>? hardQuestions;
  List<QuestionsModel>? mediumQuestions;
  List<QuestionsModel>? easyQuestions;
  late ThemeProvider themeProvider;

  Future _addQuestionToFirebaseEasy() async {
    easyQuestions = [
      firstQuestions!,
      secondQuestions!,
      thirdQuestions!,
      fourthQuestions!
    ];
    dbFirebase.addProductToFirebase(easyQuestions!);
  }

  Future _addQuestionToFirebaseMedium() async {
    mediumQuestions = [
      fiveQuestions!,
      sexQuestions!,
      sevenQuestions!,
      eightQuestions!
    ];
    dbFirebase.addProductToFirebase(mediumQuestions!);
  }

  Future _addQuestionToFirebaseHard() async {
    hardQuestions = [
      nineQuestions!,
      tenQuestions!,
      elevenQuestions!,
      twelvelvQuestions!
    ];
    dbFirebase.addProductToFirebase(hardQuestions!);
  }

  Future<int> addQuestionsEasy() async {
    firstQuestions = QuestionsModel(
        questions: "What is Flutter ?",
        answer:
            "Flutter is an open-source UI software development kit created by Google. It is used to develop applications for mobile, web, and desktop from a single codebase.",
        id: 1,
        level: "easy");
    secondQuestions = QuestionsModel(
        questions:
            "Explain the difference between StatelessWidget and StatefulWidget",
        answer:
            "StatelessWidget is immutable, meaning its properties can’t change after it’s created. StatefulWidget, on the other hand, is mutable and can change its state during the runtime.",
        id: 2,
        level: "easy");
    thirdQuestions = QuestionsModel(
        questions: "What is a Widget in Flutter ?",
        answer:
            "A Widget is a basic building block of the Flutter UI, representing an immutable description of part of a user interface.",
        id: 3,
        level: "easy");
    fourthQuestions = QuestionsModel(
        questions: 'Explain hot reload in Flutter.',
        answer:
            "Hot reload is a feature in Flutter that allows developers to quickly see the results of code changes reflected in the running application without restarting the entire app. It helps in rapidly iterating on the development process.",
        id: 4,
        level: "easy");

    easyQuestions = [
      firstQuestions!,
      secondQuestions!,
      thirdQuestions!,
      fourthQuestions!
    ];
    return await handler.insertQuestions(easyQuestions!);
  }

  // final product = Product(
  //   name: _nameController.text,
  //   category: _categoryController.text,
  //   price: int.parse(_priceController.text),
  //   description: _descriptionController.text,
  //   imageUrl: _imageUrlController.text,
  // );

  Future<int> addQuestionsMedium() async {
    fiveQuestions = QuestionsModel(
        questions: "What are keys in Flutter and why are they important ?",
        answer:
            "Keys are identifiers for Widgets, used to differentiate between similar Widgets in the Widget tree. They are crucial for managing stateful Widgets and optimizing performance during updates.",
        id: 5,
        level: "medium");
    sexQuestions = QuestionsModel(
        questions: "Explain the concept of State Management in Flutter.",
        answer:
            "State Management in Flutter refers to how the application’s state is maintained and updated throughout the lifecycle of the app. There are various approaches to managing state in Flutter, such as setState, Provider, Bloc, Redux, etc.",
        id: 6,
        level: "medium");
    sevenQuestions = QuestionsModel(
        questions:
            "What are the differences between ListView and GridView in Flutter ?",
        answer:
            "ListView displays its children in a scrolling list either vertically or horizontally, while GridView displays its children in a two-dimensional grid format.",
        id: 7,
        level: "medium");
    eightQuestions = QuestionsModel(
        questions: 'How does Flutter achieve platform independence ?',
        answer:
            "Flutter achieves platform independence by using a single codebase to render its UI on both iOS and Android platforms. It uses its rendering engine to draw UI components, enabling consistent behavior across platforms. ",
        id: 8,
        level: "medium");

    mediumQuestions = [
      fiveQuestions!,
      sexQuestions!,
      sevenQuestions!,
      eightQuestions!
    ];
    return await handler.insertQuestions(mediumQuestions!);
  }

  Future<int> addQuestionsHard() async {
    nineQuestions = QuestionsModel(
        questions: "Explain how Flutter handles navigation between screens.",
        answer:
            "Flutter manages navigation through a navigator widget that manages a stack of route objects. Developers can push and pop routes onto this stack to navigate between screens.",
        id: 9,
        level: "hard");
    tenQuestions = QuestionsModel(
        questions:
            "What are the challenges faced in Flutter app performance optimization ?",
        answer:
            "Challenges in Flutter performance optimization include reducing widget rebuilds, minimizing unnecessary object creation, optimizing layout and rendering, managing memory efficiently, and ensuring smooth animations.",
        id: 10,
        level: "hard");
    elevenQuestions = QuestionsModel(
        questions:
            "How does Flutter handle internationalization and localization ?",
        answer:
            "Flutter supports internationalization and localization through its intl package. Developers can define localized strings, formats, and layouts for different locales and switch between them dynamically.",
        id: 11,
        level: "hard");
    twelvelvQuestions = QuestionsModel(
        questions: 'Explain how Flutter interacts with native code.',
        answer:
            "Flutter uses platform channels to communicate with native code. Developers can create MethodChannels to invoke platform-specific code written in Kotlin/Java (for Android) or Swift/Objective-C (for iOS) from their Flutter app, and vice versa.",
        id: 12,
        level: "hard");

    hardQuestions = [
      nineQuestions!,
      tenQuestions!,
      elevenQuestions!,
      twelvelvQuestions!
    ];
    return await handler.insertQuestions(hardQuestions!);
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<QuestionsModel> qestionList = [];

  List<QuestionsModel> qestionListSql = [];

  Future<void> getQuestions() async {
    try {
      await db
          .collection("interViewQuestions")
          .orderBy("id", descending: false)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          QuestionsModel newProduct = QuestionsModel.fromFirestore(doc.data());
          qestionList.add(newProduct);
        }
        setState(() {});
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // CloudFirestoreService? service;
  // var connectionStatus;
  @override
  void initState() {
    dbFirebase = CloudFirestoreService(FirebaseFirestore.instance);
    super.initState();
    handler = DataBase();

    handler.initializedDB().whenComplete(() async {
      await addQuestionsEasy();
      await addQuestionsMedium();
      await addQuestionsHard();

      await _addQuestionToFirebaseEasy();
      await _addQuestionToFirebaseMedium();
      await _addQuestionToFirebaseHard();
      getQuestions();
      setState(() {});
    });

    // IsolateIO.i.start();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   // final name = await IsolateIO.i.readFromStorage('username');
    //   setState(() {
    //     username = name ?? '';
    //   });
    // });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    themeProvider = context.read<ThemeProvider>();

    // connectionStatus = Provider.of<ConnectivityStatus>(context);
    // service?.add(listofQuestion);
  }

  String username = '';

  @override
  void dispose() {
    _animationController!.dispose();
    editingController.dispose();
    super.dispose();
    // IsolateIO.i.stop();
  }

  _toggleAnimation() {
    _animationController!.isDismissed
        ? _animationController!.forward()
        : _animationController!.reverse();
  }

  String? levelTap;
  Future<void> sortItemsOnline(String value) async {
    switch (value) {
      case 'Easy':
        try {
          qestionList = [];
          listOfSearch = [];
          await db
              .collection('interViewQuestions')
              .where('level', isEqualTo: "easy")
              .orderBy("id", descending: false)
              .get()
              .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              QuestionsModel newProduct =
                  QuestionsModel.fromFirestore(doc.data());
              qestionList.add(newProduct);
            }
            setState(() {});
          });
        } catch (e) {
          print('Error fetching products: $e');
        }
        break;

      case 'Medium':
        try {
          qestionList = [];
          listOfSearch = [];
          await db
              .collection('interViewQuestions')
              .where('level', isEqualTo: "medium")
              .orderBy("id", descending: false)
              .get()
              .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              QuestionsModel newProduct =
                  QuestionsModel.fromFirestore(doc.data());
              qestionList.add(newProduct);
            }
            setState(() {});
          });
        } catch (e) {
          print('Error fetching products: $e');
        }

        break;
      case 'Hard':
        try {
          qestionList = [];
          listOfSearch = [];
          await db
              .collection('interViewQuestions')
              .where('level', isEqualTo: "hard")
              .orderBy("id", descending: false)
              .get()
              .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              QuestionsModel newProduct =
                  QuestionsModel.fromFirestore(doc.data());
              qestionList.add(newProduct);
            }
            setState(() {});
          });
        } catch (e) {
          print('Error fetching products: $e');
        }

        break;
      case 'Default':
        qestionList = [];
        getQuestions();
        break;
    }
    setState(() {});
  }

  Widget offlineGridView(List<QuestionsModel> qestionListSql) {
    return GridView.builder(
      itemCount: qestionListSql.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 8.0, // spacing between rows
        crossAxisSpacing: 8.0, // spacing between columns
      ),
      padding: EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context, int index) {
        return Hero(
          tag: qestionListSql[index].id,
          child: Card(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuestionDetailsScreen(
                          questionsDetails: qestionListSql[index],
                        )));
              },
              title: Center(
                child: Text(
                  qestionListSql[index].questions,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextEditingController editingController = TextEditingController();
  List<QuestionsModel> listOfSearch = [];
  void filterSearchResults(String query, List<QuestionsModel> listOfQuestions) {
    setState(() {
      listOfSearch = listOfQuestions
          .where((item) =>
              item.questions.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> sortItemsOffline(String value) async {
    switch (value) {
      case 'Easy':
        try {
          qestionListSql = [];
          listOfSearch = [];
          levelTap = "easy";

          setState(() {});
        } catch (e) {
          print('Error fetching products: $e');
        }
        break;

      case 'Medium':
        try {
          qestionListSql = [];
          listOfSearch = [];
          levelTap = "medium";
          setState(() {});
        } catch (e) {
          print('Error fetching products: $e');
        }

        break;
      case 'Hard':
        try {
          qestionListSql = [];
          listOfSearch = [];
          levelTap = "hard";
          setState(() {});
        } catch (e) {
          print('Error fetching products: $e');
        }

        break;
      case 'Default':
        qestionListSql = [];
        listOfSearch = [];
        levelTap = "none";
        // getQuestions();
        break;
    }
    setState(() {});
  }

  double opacityLevel = 1.0;
  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.3);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    final rightSlide = MediaQuery.of(context).size.width * 0.5;
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        double slide = rightSlide * _animationController!.value;
        double scale = 1 - (_animationController!.value * 0.2);
        final user = FirebaseAuth.instance.currentUser;
        return Stack(
          children: [
            GestureDetector(
              onPanUpdate: (details) {
                // Swiping in left direction.
                if (details.delta.dx < 0) {
                  _animationController!.reverse();
                }
              },
              child: Scaffold(
                // backgroundColor: Colors.white.withOpacity(0.95),
                body: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, top: 100, bottom: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        // String result = s.substring(0, s.indexOf('.'));
                        user!.email
                            .toString()
                            .substring(0, user.email.toString().indexOf("@")),
                        style: TextStyle(
                          fontSize: 18,
                          // color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            user.email.toString(),
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            // style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            _signOut();
                          },
                          child: Text("Sign Out")),
                      // Divider()
                      Spacer(),

                      AnimatedOpacity(
                        opacity: opacityLevel,
                        duration: const Duration(seconds: 3),
                        child: GestureDetector(
                          onTap: () {
                            _changeOpacity();
                            themeProvider.toggleTheme();
                          },
                          child: Image.asset(
                            themeProvider.attrs.mode == ThemeModes.light
                                ? "asset/night-mode.png"
                                : "asset/themes.png",
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onPanUpdate: (details) {
                // Swiping in right direction.
                if (details.delta.dx > 0) {
                  //  _animationController!.isDismissed
                  // ?
                  _animationController!.forward();
                  // : _animationController!.reverse();
                }

                // Swiping in left direction.
                if (details.delta.dx < 0) {
                  _animationController!.reverse();
                }
              },
              child: Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: AlignmentDirectional.center,
                  child: ClipRRect(
                    borderRadius: !_animationController!.isDismissed
                        ? BorderRadius.circular(25.0)
                        : BorderRadius.zero,
                    child: Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        toolbarHeight: 65,
                        // backgroundColor: Colors.purple,
                        title: SizedBox(
                          height: 50,
                          child: TextFormField(
                            onChanged: (value) {
                              connectionStatus == ConnectivityStatus.Offline
                                  ? filterSearchResults(value, qestionListSql)
                                  : filterSearchResults(value, qestionList);
                            },
                            controller: editingController,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search for Items",
                              hintStyle: TextStyle(
                                  // color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  decorationThickness: 6),

                              prefixIcon: const Icon(Icons.search),
                              // prefixIconColor: Colors.white,
                            ),
                          ),
                        ),
                        actions: [
                          SizedBox(
                            width: 50,
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: DropdownButton<String>(
                                alignment: Alignment.center,
                                borderRadius: BorderRadius.circular(20),
                                dropdownColor: Colors.white.withOpacity(0.7),
                                menuMaxHeight: 300,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                underline: const SizedBox.shrink(),
                                icon: Ink(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.sort,
                                    // color: Colors.white,
                                    // size: 25,
                                  ),
                                ),
                                isExpanded: true,
                                items: <String>[
                                  'Default',
                                  'Easy',
                                  'Medium',
                                  "Hard"
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    connectionStatus ==
                                            ConnectivityStatus.Offline
                                        ? sortItemsOffline(value!)
                                        : sortItemsOnline(value!);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],

                        leading: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              _toggleAnimation();
                            },
                            child: Ink(
                              padding: const EdgeInsets.only(left: 10, top: 18),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  shape: BoxShape.circle),
                              child: AnimatedIcon(
                                size: 25,
                                icon: AnimatedIcons.menu_close,
                                progress: _animationController!,
                              ),
                            ),
                          ),
                        ),

                        shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(24))),
                      ),
                      body: connectionStatus == ConnectivityStatus.Offline
                          ? Column(
                              children: [
                                Expanded(
                                  child: FutureBuilder<List<QuestionsModel>>(
                                      future: levelTap == "easy"
                                          ? handler.filterQuestions("easy")
                                          : levelTap == "medium"
                                              ? handler
                                                  .filterQuestions("medium")
                                              : levelTap == "hard"
                                                  ? handler
                                                      .filterQuestions("hard")
                                                  : handler.retrieveQuestions(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<QuestionsModel>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          qestionListSql = snapshot.data!;
                                          return listOfSearch.isEmpty
                                              ? offlineGridView(qestionListSql)
                                              : offlineGridView(listOfSearch);
                                        } else {
                                          return const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive());
                                        }
                                      }),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                qestionList.length == 0
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Questions",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                qestionList.length == 0
                                    ? Center(
                                        child: CircularProgressIndicator
                                            .adaptive())
                                    : listOfSearch.isEmpty
                                        ? Expanded(
                                            child: offlineGridView(qestionList))
                                        : Expanded(
                                            child:
                                                offlineGridView(listOfSearch))

                                // Expanded(
                                //     child: GridView.builder(
                                //       itemCount: qestionList.length,
                                //       shrinkWrap: true,
                                //       gridDelegate:
                                //           SliverGridDelegateWithFixedCrossAxisCount(
                                //         crossAxisCount:
                                //             2, // number of items in each row
                                //         mainAxisSpacing:
                                //             8.0, // spacing between rows
                                //         crossAxisSpacing:
                                //             8.0, // spacing between columns
                                //       ),
                                //       padding: EdgeInsets.all(8.0),
                                //       itemBuilder: (BuildContext context,
                                //           int index) {
                                //         return Hero(
                                //           tag: qestionList[index].id,
                                //           child: Card(
                                //             shape:
                                //                 ContinuousRectangleBorder(
                                //                     borderRadius:
                                //                         BorderRadius
                                //                             .circular(24)),
                                //             child: ListTile(
                                //               contentPadding:
                                //                   const EdgeInsets.all(8.0),
                                //               onTap: () {
                                //                 Navigator.of(context).push(
                                //                     MaterialPageRoute(
                                //                         builder: (context) =>
                                //                             QuestionDetailsScreen(
                                //                               questionsDetails:
                                //                                   qestionList[
                                //                                       index],
                                //                             )));
                                //               },
                                //               title: Center(
                                //                 child: Text(
                                //                   qestionList[index]
                                //                       .questions,
                                //                   textAlign:
                                //                       TextAlign.center,
                                //                   style: TextStyle(
                                //                       // color: Colors.black,
                                //                       fontSize: 16,
                                //                       fontWeight:
                                //                           FontWeight.w500),
                                //                 ),
                                //               ),
                                //               // subtitle: Container(
                                //               //   height: 10,
                                //               //   width: 10,
                                //               //   decoration: BoxDecoration(
                                //               //     shape: BoxShape.circle,
                                //               //     color: qestionList[index]
                                //               //                 .level ==
                                //               //             "easy"
                                //               //         ? Colors.yellow
                                //               //         : qestionList[index]
                                //               //                     .level ==
                                //               //                 "medium"
                                //               //             ? Colors.green
                                //               //             : Colors.red,
                                //               //   ),
                                //               // ),
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     ),
                                //   ),
                              ],
                            ),
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }
}
