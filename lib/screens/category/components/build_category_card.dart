// import 'package:flutter/material.dart';
// // import 'package:lomaysowdamuckup/constraints.dart';
// import 'package:lomaysowdamuckup/model/kategory.dart';

// class BuildCategoryCard extends StatelessWidget {
//   final Kategory category;
//   BuildCategoryCard({this.category});
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         padding: EdgeInsets.all(10.0),
//         margin: EdgeInsets.all(5.0),
//         width: MediaQuery.of(context).size.width * 0.3,
//         height: MediaQuery.of(context).size.height * 0.17,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.0),
//             border: Border.all(color: Colors.black45)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Icon(
//               category.icon,
//               size: 40.0,
//             ),
//             Text(
//               category.title,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
