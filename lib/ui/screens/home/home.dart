// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../constants/enums.dart';
//
//
// class AmirChatApp extends StatelessWidget {
//    AmirChatApp({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Home();
//
//   }
// }
//
// class Home extends StatefulWidget {
//    Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () async {
//       Provider.of<ChatProvider>(context, listen: false).getMyData();
//     });
//   }
//   final keyScaffold  = GlobalKey<ScaffoldState>() ;
//
//   @override
//   Widget build(BuildContext context) {
//     final myDataCubit= context.read<ChatProvider>();
//
//     return Scaffold(
//     key: keyScaffold,
//     drawer: Drawer(
//       child: Provider.of<ChatProvider>(context).getMyDataState ==States.loading? const Center(child: CircularProgressIndicator(
//         color:  Colors.yellow,
//
//       )) : Column(
//         children: [
//           if(myDataCubit.userChat!=null)
//
//             UserAccountsDrawerHeader(
//                 currentAccountPicture: CircleAvatar(
//                   radius: 40,
//                   backgroundImage: NetworkImage( myDataCubit.userChat!.photoUrl,
//                   ),),
//                 accountName:Text(myDataCubit.userChat!.name),
//                 accountEmail: Text(myDataCubit.userChat!.email)
//             ),
//         ],
//       ),
//     ),
//     appBar: AppBar(
//         elevation: 0,
//         actions: [
//           IconButton(onPressed: ( ) {
//             Provider.of<ChatProvider>(context,listen: false).changeSearchEnabled();
//           } , icon:
//           Icon(
//               myDataCubit.searchEnabled?
//               Icons.clear:Icons.search)
//           )],
//         automaticallyImplyLeading: false,
//         title:    myDataCubit.searchEnabled?
//
//         TextField(
//           onChanged: (q) {
//             Provider.of<ChatProvider>(context,listen: false).searchAboutUser(q: q.trim());
//           } ,
//           style: const TextStyle(
//               color: Colors.white
//           ),
//           decoration: const InputDecoration(
//               border: InputBorder.none,
//               hintText: "Search about user........",
//               hintStyle: TextStyle(
//                   color: Colors.white
//               )
//           ),
//         ) :GestureDetector(
//
//             onTap: ( ) {
//               keyScaffold.currentState!.openDrawer();
//             } ,
//             child: Text("Users Screen")
//         )
//     ),
//     body: const HomeBody(),
//   );
//   }
// }
//
//
// class HomeBody extends StatefulWidget {
//   const HomeBody({Key? key}) : super(key: key);
//
//   @override
//   State<HomeBody> createState() => _HomeBodyState();
// }
//
// class _HomeBodyState extends State<HomeBody> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () async {
//       Provider.of<ChatProvider>(context, listen: false).getUsers();
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final userProv= context.read<ChatProvider>();
//     return
//
//       Provider.of<ChatProvider>(context).usersState == States.loading ?
//         const Center(child: CircularProgressIndicator(
//           color: Colors.yellow,
//
//         ))
//         :
//     ListView.builder(
//         itemCount:userProv.filteredUsers==[] || userProv.filteredUsers.isEmpty?
//         userProv.users.length:userProv.filteredUsers.length,
//         itemBuilder: (ctx,index) {
//
//           return ListTile(
//             title: Text (
//                 userProv.filteredUsers==[] ||  userProv.filteredUsers.isNotEmpty?
//                 userProv.filteredUsers[index].name:userProv.users[index].name),
//             leading:CircleAvatar(
//               backgroundImage:  NetworkImage(
//                 userProv.filteredUsers==[] ||    userProv.filteredUsers.isNotEmpty?
//                 userProv.filteredUsers[index].photoUrl:
//                 userProv.users[index].photoUrl,
//               ),
//             ),
//           );
//
//         } ) ;
//   }
// }
