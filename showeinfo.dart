import 'package:application/layout/todo_app/mistake.dart';
import 'package:application/moduals/bmi_screen/Bmi_screen.dart';
import 'package:application/shared/blocBmiscreen/Bmistates.dart';
import 'package:application/shared/blocBmiscreen/cubiit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class checkinfo extends StatelessWidget {

   late String name ;

   checkinfo(this.name);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitBmi(),
      child: BlocConsumer<CubitBmi,Bmistates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, state) {
          CubitBmi kool = CubitBmi.get(context);
          return Scaffold(
            appBar: AppBar(
              title:  const Text(
                '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children:  [
                      const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.0),
                      child: Text(
                        'Hello!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: CircleAvatar(radius: 80.0,
                      child: Text('${name}',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),

                      ),
                    ),
                      const SizedBox(height: 20.0,),
                    const Text('Do you want add task in future?',
                    style: TextStyle(

                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                      const SizedBox(height: 15,),
                      Container(
                        height: 40.0,
                        width: 80.0,
                        color: Colors.orange,
                        child: MaterialButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return mistake();
                          },));
                        },child: const Text('Go',style: TextStyle(fontSize: 30),),),
                      ),
                      const SizedBox(height: 20.0,),
                      const Text('Do you want Calculate body mass index for you?',
                        style: TextStyle(

                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 15,),
                      Container(
                        height: 40.0,
                        width: 85.0,
                        color: Colors.orange,
                        child: MaterialButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Bmi_screen();
                          },));
                        },child: const Text('BMI',style: TextStyle(fontSize: 25),),),
                      )
                    ],
                  ),

                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

