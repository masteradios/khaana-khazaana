import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/studentProviders/studentProvider.dart';
import '../InstructionDialog/dialogMain.dart';

Widget showQuizForStudent(context, snapshot, index) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    child: Column(
      children: [
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: TextDisplay(
                    snapshot.data.docs[index]['Quiz Title'].toString(),
                    "title",
                    context,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: TextDisplay(
                        snapshot.data.docs[index]['Quiz Description']
                            .toString(),
                        "desc",
                        context,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Divider(),
                    SizedBox(height: 8.0),
                    TextDisplay(
                      snapshot.data.docs[index]['Difficulty'].toString(),
                      "diff",
                      context,
                    ),
                    SizedBox(height: 8.0),
                    TextDisplay(
                      snapshot.data.docs[index]['Total Questions'].toString(),
                      "total",
                      context,
                    ),
                    SizedBox(height: 8.0),
                    Consumer<StudentProvider>(
                      builder: (context, providerValue, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () async {
                                providerValue.getDifficultyLevel(
                                  snapshot.data.docs[index]['Difficulty']
                                      .toString(),
                                );
                                providerValue.getTotalQuestions(
                                  snapshot.data.docs[index]['Total Questions']
                                      .toString(),
                                );
                                providerValue.getQuizTitle(
                                  snapshot.data.docs[index]['Quiz Title']
                                      .toString(),
                                );
                                providerValue.getQuizDescription(
                                  snapshot.data.docs[index]['Quiz Description']
                                      .toString(),
                                );
                                providerValue.getQuizID(
                                  snapshot.data.docs[index].id.toString(),
                                );
                                dialogBoxForInstructions(context);
                              },
                              child: Text(
                                "Attempt Quiz",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget TextDisplay(value, type, context) {
  return Text(
    type == "diff"
        ? "Difficulty: $value"
        : type == "total"
            ? "Questions to Attempt: $value"
            : "$value",
    style: textStyle(type, context),
  );
}

TextStyle textStyle(value, context) {
  return TextStyle(
    fontSize: (value == "title") ? 18.0 : 18.0,
    color: (value == "title") ? Colors.white : Colors.black,
    fontWeight: (value == "title" || value == "desc")
        ? FontWeight.bold
        : FontWeight.normal,
  );
}
