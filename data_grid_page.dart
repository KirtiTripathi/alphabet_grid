import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataGrid extends StatefulWidget {
  @override
  _DataGridState createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _rowController = TextEditingController();
  TextEditingController _columnController = TextEditingController();
  TextEditingController _alphabetController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  int rows;
  int columns;
  String tempRows;
  String tempColumns;
  var alphabetList = [];
  int multiple;
  bool createGrid = false;
  String searchedString;
  var tempStr=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          title: Text(
            "Data Grid",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _rowController,
                            cursorColor: Colors.purple[300],
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.purple[300]),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Enter Rows",
                              hintStyle: TextStyle(color: Colors.purple[300]),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple[300]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              tempRows = _rowController.text;
                              if (tempRows != null || tempRows != "") {
                                rows = int.parse(tempRows);
                                print(rows);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Rows';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _columnController,
                            cursorColor: Colors.purple[300],
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple[300]),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              hintText: "Enter Columns",
                              hintStyle: TextStyle(color: Colors.purple[300]),
                              contentPadding: const EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple[300]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              tempColumns = _columnController.text;
                              if (tempColumns != null || tempColumns != "") {
                                columns = int.parse(tempColumns);
                                print(columns);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Columns';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  textInputAction: TextInputAction.go,
                                  controller: _alphabetController,
                                  cursorColor: Colors.purple[300],
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.purple[300]),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        )),
                                    hintText: "Add alphabets",
                                    hintStyle:
                                        TextStyle(color: Colors.purple[300]),
                                    contentPadding: const EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.purple[300]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                  rows!=null&&columns!=null?  multiple = rows * columns:Container();
                                    if (multiple!= alphabetList.length) {
                                      return 'Please Enter rows*columns number of alphabets';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              FloatingActionButton(
                                onPressed: () {

                                  if (rows != null && columns != null) {
                                    setState(() {
                                     if(_alphabetController.text !=null &&_alphabetController.text.isNotEmpty && _alphabetController.text!="" && alphabetList.length<multiple)
                                       alphabetList.add(_alphabetController.text);

                                     _alphabetController.clear();
                                    });

                                  }
                                  print(alphabetList);
                                },
                                backgroundColor: Colors.purple[300],
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.purple[300],
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      )),
                                  onPressed: () {
                                    print("m*n $multiple");
                                    if (_formKey.currentState.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                          content:
                                          Text('Creating Grid')));
                                    }
                                    if( alphabetList.length!=multiple){ setState(() {
                                     showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text("Alert!"),
                                                    content: Text(
                                                      "you need to enter row*column no. of  alphabets",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  actions: [
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.purple[300],
                                                          textStyle: TextStyle(
                                                            fontSize: 18,
                                                          )),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              });
                                          });}
                                   else{
                                      setState(() {
                                        createGrid= true;

                                      });
                                    }
                                    },
                                  child: Text('Create Grid'),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.purple[300],
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      createGrid= false;
                                      _rowController.clear();
                                      _columnController.clear();
                                      _alphabetController.clear();
                                      rows = null;
                                      columns = null;
                                      alphabetList = [];
                                    });
                                    print(
                                        "Controllers value ${_rowController.text},${_columnController.text}");
                                  },
                                  child: Text('Reset Grid'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                createGrid==true && rows!=null && columns!= null
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                            controller: _searchController,
                            cursorColor: Colors.purple[300],
                            decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(100.0),
                                  ),
                                  borderSide:
                                      BorderSide(color: Colors.purple[300]),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "search..",
                                hintStyle: TextStyle(color: Colors.purple[300]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple[300]),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.purple[300],
                                ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  _searchController.clear();
                                  tempStr=[];
                                },
                                icon: Icon(Icons.clear,size: 20,color: Colors.black,),)
                            ),
                            onChanged: (value) {
                              value.codeUnits.map((unit) {
                                 searchedString = String.fromCharCode(unit);
                                print("Alphabets in a String $searchedString");
                                tempStr.add(searchedString);
                                print("$tempStr ${tempStr.length}");


                              }).toList();
                            }
                            ),
                      )
                    : Container(),
               _alphabetGrid(),
              ],
            ),
          ),
        ));
  }

  Widget _alphabetGrid()=>
      createGrid==true && rows!=null && columns!= null
      ? Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width /1.2,
      child: GridView.count(
        primary: false,
        padding: EdgeInsets.all(5),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: columns,
        children: List.generate(alphabetList.length, (index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:tempStr!=null && tempStr!=""&&tempStr.isNotEmpty&& alphabetList[index]==tempStr[0]?Colors.teal[100]:Colors.purple[100]
            ),
            child: Center(
                child: Text(
                  alphabetList[index].toString(),
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800),
                )),
          );
        }),
      ))
      : Container();

}
