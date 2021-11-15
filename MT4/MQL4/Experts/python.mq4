#include <Zmq/Zmq.mqh>


void OnStart()
  {
   Context context("helloworld");
   Socket socket(context,ZMQ_REP);

   socket.bind("tcp://*:1110");

   while(true)
     {
      ZmqMsg request;

      // Wait for next request from client

      // MetaTrader note: this will block the script thread
      // and if you try to terminate this script, MetaTrader
      // will hang (and crash if you force closing it)
      socket.recv(request);
      Print("Receive Hello");

      Sleep(100);

      ZmqMsg reply("World");
      // Send reply back to client
      socket.send(reply);
     }
  }

 ZmqMsg MessageHandler(ZmqMsg &_request) {
   
    // Output object
    ZmqMsg reply;
   
    // Message components for later.
    string components[11];
   
    if(_request.size() > 0) {
   
       // Get data from request   
       ArrayResize(_data, _request.size());
       _request.getData(_data);
       string dataStr = CharArrayToString(_data);
      
       // Process data
       ParseZmqMessage(dataStr, components);
      
       // Interpret data
     InterpretZmqMessage(pushSocket, components);
      
    } else {
       // NO DATA RECEIVED
    }
   
    return(reply);
 }


 // Parse Zmq Message
 void ParseZmqMessage(string& message, string& retArray[]) {
   
    Print("Parsing: " + message);
   
    string sep = ";";
    ushort u_sep = StringGetCharacter(sep,0);
   
    int splits = StringSplit(message, u_sep, retArray);
   
//    /*
    for(int i = 0; i < splits; i++) {
       Print(IntegerToString(i) + ") " + retArray[i]);
    }
//    */
 }