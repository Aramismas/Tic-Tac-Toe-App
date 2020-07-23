import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override 
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool xturn = true; // determines whose turn it is 
  int gameTurn = 0;
  int oScore = 0;
  int xScore = 0;
  List<String> letter = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
            Expanded ( 
              child: Container (
              child: Center( 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                        child: Text ("Tic Tac Toe", style: TextStyle(color: Colors.black, fontSize:15)),
                      ),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[ // creates the scoreboard for the players
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column ( 
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[ 
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Player O", style: TextStyle(color: Colors.black, fontSize: 15)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                                  child: Text(oScore.toString(), style: TextStyle(color: Colors.black, fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column ( 
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[ 
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Player X", style: TextStyle(color: Colors.black, fontSize: 15)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                                  child: Text(xScore.toString(), style: TextStyle(color: Colors.black, fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                        ),
                    ],
                  ),
              ),
              ),
            ),
          Expanded( 
           flex: 3,
           child: GridView.builder(
           itemCount: 9,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
           itemBuilder: (BuildContext context, int box){
             return GestureDetector( // gets feedback from user if they tap on a square
               onTap: () { action(box); },
               child: Container( 
                decoration: BoxDecoration( 
                   border: Border.all(color: Colors.black) // builds the grid
                ),
                 child: Center(  
                   child: Text(letter[box], style: TextStyle(color: Colors.black, fontSize: 45))
                 ), 
               )
             );
           }),
          ),
        ],
      ),
    );
  }

  void action(int box) { // changes an empty box to either an X or O on the player's turn
    setState(() {
      if ((letter[box] == " ") && xturn) {
        letter[box] = "X";
        xturn = false;
        gameTurn++;
      }
      else if ((letter[box] == " ") && !xturn) {
        letter[box] = "O";
        xturn = true;
        gameTurn++;
      }
      checkWin(); // checks if a player won after their turn
    });
  }
  void checkWin() {
    // checks first row
    if (letter[0] != " " && (letter[0] == letter [1]) && (letter[1] == letter [2])) {
      endGame(letter[0]);
    }
    // checks second row
    else if (letter[3] != " " && (letter[3] == letter [4]) && (letter[4] == letter [5])) {
      endGame(letter[3]);
    }
    // checks third row
    else if (letter[6] != " " && (letter[6] == letter [7]) && (letter[7] == letter [8])) {
      endGame(letter[6]);
    }
    // checks first column
    else if (letter[0] != " " && (letter[0] == letter [3]) && (letter[3] == letter [6])) {
      endGame(letter[0]);
    }
    // checks second column
    else if (letter[1] != " " && (letter[1] == letter [4]) && (letter[4] == letter [7])) {
      endGame(letter[1]);
    }
    // checks third column
    else if (letter[2] != " " && (letter[2] == letter [5]) && (letter[5] == letter [8])) {
      endGame(letter[2]);
    }
    // checks left diagonal
    else if (letter[0] != " " && (letter[0] == letter [4]) && (letter[4] == letter [8])) {
      endGame(letter[0]);
    }
    // checks right diagonal
    else if (letter[2] != " " && (letter[2] == letter [4]) && (letter[4] == letter [6])) {
      endGame(letter[2]);
    }
    else if (gameTurn == 9) { // if there is a Tie
      Future.delayed(const Duration(milliseconds: 700), () {
      showDialog( // displays replay message 
      barrierDismissible: false,
      context: context,
       builder: (BuildContext context) {
         return AlertDialog( 
           title: Text("Tie"),
           actions: <Widget>[ 
             FlatButton( 
               child: Text("Play Again"),
               onPressed: () {
                 restart();
                 Navigator.of(context).pop(); // removes the message
               },
             )
           ],
         );
       }
      );
      });
    }
  }
  void endGame(String player) {
    Future.delayed(const Duration(milliseconds: 700), () {
    showDialog( // displays replay message 
      barrierDismissible: false,
      context: context,
       builder: (BuildContext context) {
         return AlertDialog( 
           title: Text("Player " + player + " Won"),
           actions: <Widget>[ 
             FlatButton( 
               child: Text("Play Again"),
               onPressed: () {
                 restart();
                 Navigator.of(context).pop(); // removes the message
               },
             )
           ],
         );
       }
      );
      });
    if (player == "X") { // if player X wins
      xScore++;
    } 
    else if (player == "O") { // if player O wins
      oScore++;
    }
  }
  void restart() { // cleans the board and the loser goes first
    setState(() {
      for (int i = 0; i < 9; i++) {
        letter[i] = " ";
      }
      gameTurn = 0;
    });
  }
}
