//impportando os pacotes necessarios 
import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(CalculadoraApp());
//definindo o widget principal do aplicativo
class CalculadoraApp extends Statelesswidget{
 @override
 Widget build(BuildContext contex){
   return MaterialApp(
     title:'calculadora',
     theme: ThemeData(
       primarySwatch: Colors.blue,
     )
     home:Calculadora(),
   );
 }
}
class HistoricoItem{
  final String expressao;
  final String resultado;

  HistoricoItem(this.expressao, this.resultado);
}
//definindo o widget da pagina inicial
class Calculadora extends StatefulWidget{
  @override
  _CalculadoraState creareState()=> _CalculadoraState();
}
class _CalculadoraState extends State<Calculadora>{
  String num1='';
  String num2 ='';
  String operacao='';
  List<HistoricoItem>historico[];

  void adicionarNumero(String numero){
    if(operacao.isEmpty){
      num1 = num1 + numero;
    }
    else{
      num2 = num2 + numero;
    }
    setState((){});
  }
  void definirOperacao(String op){
    if(num1.isEmpty)return;
    setState((){
      operacao = op;
    });
  }
  void calcular(){
    double n1 = double.parse(num1);
    double n2 = double.parse(num2);
    double res = 0;

    switch(operacao){
      case "+":
      res = n1 + n2;
      break;
       case "-":
      res = n1 - n2;
      break;
       case "x":
      res = n1 * n2;
      break;
      //window + .
       case "÷":
       if(n2 !=0){
         res = n1 / n2;
       }else{
         num1 = "erro";
         num2 = "";
         operacao = "";
         return;
       }
      break;
    }//fim Switch
    setState((){
      historico.insert(
        0,HistoricoItem("$num1 $operacao $num2",res.toString()));
        if(historico.length>5){
          historico.removeAt(5);
        }
        num1=res.toString();
        num2="";
        operacao = "";
    });
  }//calcular
  @override
  Widget build(BuildContext contex){
    return Scaffold(
      appBar: AppBar(
        title: Text("calculadora"),
      ),
      body: Column(children:<Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: historico.length,
            itemBuilder: (context,index){
              return ListTile(
                title:Text(historico[index].expressao),
                trailing: Text(historico[index].resultado),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child:Text(
            "$num1 $operacao $num2",
            style: TextStyle(fontSize: 24),

          ),
        ),
        buildRow(["7","8","9","+"]),
        buildRow(["4","5","6","-"]),
        buildRow(["1","2","3","x"]),
        buildRow(["0","C","=","÷"]),
      ]
      ),
    );
  }
  Widget buildRow(List<String> buttons){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) => buildButton(button)).toList(),
    );
  }
   Widget buildButton(String buttonText){
     return Expanded(
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child:ElevatedButton(
            style: ElevatedButton styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20.0),
            )
           onPressed: (){
             switch(buttonText){
               case "0":
               case "1":
               case "2":
               case "3":
               case "4":
               case "5":
               case "6":
               case "7":
               case "8":
               case "9":
                adicionarNumero(buttonText);
                break;
                case "+":
                case "-":
                case "x":
                case "÷":
                  definirOperacao(buttonText);
                  break;
                  case "=":
                    calcular();
                    break;
                  case "c":
                  setState((){
                    num1 = "";
                    num2 = "";
                    operacao = "";
                  });
                  break;
             }
           },
           child: Text(
             buttonText,
             style: TextStyle(fontSize:20),
           )),

           ),
       );
      
   } 
}//calculadoraState
