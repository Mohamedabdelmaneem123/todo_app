

import 'package:bloc/bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import '../Bloc/Cubit.dart';

Widget defultbutton({

   double width = double.infinity,
  Color background = Colors.blue,
  bool isuppercase =true,
  double Redius=20.0,
  required Function function,
  required String text,
}) => Container(
  width: width,
   height: 45.0,
   decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(Redius),
    color: background
  ) ,
  child: MaterialButton(
    onPressed: function(),
    child:
    Text( isuppercase ? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),



  ),
);

Widget defulttextfrom({
  required TextEditingController controller,
  required TextInputType type,
   required Function validator,
   Function? onFieldSubmitted,
   Function? onChanged,
   required IconData PerfixIcon,
  required String lable



}) => TextFormField(
controller: controller,

keyboardType: type,
obscureText: true,
validator: validator(),
decoration: const InputDecoration(
  labelText: 'email address',
  prefixIcon:Icon(
  Icons.email_outlined,
  ),
suffixIcon:  Icon(Icons.remove_red_eye),
  border: OutlineInputBorder(),

),
onFieldSubmitted: onFieldSubmitted!(),
onChanged: onChanged!(),

);

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction) {
    Cuebit.get(context).deleteData(id: model['id']);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text('${model['time']}'),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              Cuebit.get(context).updateData(status: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            )),
        IconButton(
          onPressed: () {
            Cuebit.get(context).updateData(status: 'archive', id: model['id']);
          },
          icon: Icon(Icons.archive),
          color: Colors.black45,
        ),
      ],
    ),
  ),
);

Widget tasksBuilder(List<Map> tasks) => ConditionalBuilder(
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context, index) => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ),
    itemCount: tasks.length,
  ),
  condition: tasks.length > 0,
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        )
      ],
    ),
  ),
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onChanged: onChange as void Function(String)?,
      onTap: onTap as void Function()?,
      validator: validate as String? Function(String?)?,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed as void Function()?,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );


