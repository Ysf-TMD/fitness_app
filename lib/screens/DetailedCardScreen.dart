import "dart:async";

import "package:flutter/material.dart";

class DetailedcardScreen extends StatefulWidget {
  //const DetailedcardScreen({super.key});
  final String imageUrl;

  final String name;

  final String slogan;

  final int second;

  final String username;

  final String usermail;

  DetailedcardScreen({
    required this.imageUrl,
    required this.name,
    required this.slogan,
    required this.second,
    required this.username,
    required this.usermail,
  });

  @override
  State<DetailedcardScreen> createState() => _DetailedcardScreenState();
}

class _DetailedcardScreenState extends State<DetailedcardScreen> {
  late int _secondsRemaining;
  late bool _isCounting ;
  late bool _exerciseCompleted;


  // initialisation
  @override
  void initState(){
    super.initState();
    _isCounting  = false ;
    _exerciseCompleted = false ;
    _secondsRemaining  = widget.second;
  }

  void _startCounting(){
   setState(() {
     _isCounting = true ;

   });
   const oneSec = Duration(seconds: 1);
   Timer.periodic(oneSec,(timer){
     if(_secondsRemaining == 0){
       setState(() {
         _isCounting = false ;
         _exerciseCompleted = true ;
         timer.cancel();
       });
     }else{
       setState(() {
         _secondsRemaining-- ;
       });
     }
   });
  }



  Future<void> _loadExerciseCompletionState() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade100,
        title: const Text("Exercise Details "),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text("Welcome , ${widget.username}"),
          const SizedBox(
            height: 10,
          ),
          Text("Welcome , ${widget.usermail}"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.network(widget.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.slogan,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                _isCounting
                    ? Column(
                        children: [
                          CircularProgressIndicator(
                            value: (_secondsRemaining / widget.second),
                            strokeWidth: 10,
                            backgroundColor: Colors.grey,
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.blue),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "$_secondsRemaining seconds",
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      )
                    : const SizedBox(
                        height: 16.0,
                      ),
                _exerciseCompleted
                    ? const Column(
                        children: [
                          const Text(
                            "Exercise Completed",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _startCounting();
                        },
                        child:  Text(_isCounting ? "Counting Down ... " : "Start Counting"),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
