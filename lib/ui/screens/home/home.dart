import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/enums.dart';
import '../../../providers/chat/chat_provider.dart';

class AmirChatApp extends StatelessWidget {
   AmirChatApp({Key? key}) : super(key: key);


  final keyScaffold  = GlobalKey<ScaffoldState>() ;

  @override
  Widget build(BuildContext context) {

    final myDataCubit= context.read<ChatProvider>()..getMyData();

    return Scaffold(
      key: keyScaffold,
      drawer: Drawer(
        child: Provider.of<ChatProvider>(context).getMyDataState ==States.loading? const CircularProgressIndicator() : Column(
          children: [
            if(myDataCubit.userChat!=null)

              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage( myDataCubit.userChat!.photoUrl,
                  ),),
                  accountName:Text(myDataCubit.userChat!.name),
                  accountEmail: Text(myDataCubit.userChat!.email)
              ),



          ],
        ),
      ),
      appBar: AppBar(
          elevation: 0,
          actions: [
          IconButton(onPressed: ( ) {
    myDataCubit.changeSearchEnabled();
    } , icon:
    Icon(
        myDataCubit.searchEnabled?
        Icons.clear:Icons.search)
    )],
          automaticallyImplyLeading: false,
          title:    myDataCubit.searchEnabled?

      TextField(
      onChanged: (q) {
    myDataCubit.searchAboutUser(q: q.trim());
    } ,
      style: TextStyle(
          color: Colors.white
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search about user........",
          hintStyle: TextStyle(
              color: Colors.white
          )
      ),
    ) :GestureDetector(

    onTap: ( ) {
    keyScaffold.currentState!.openDrawer();
    } ,
    child: Text("Users Screen")
          )
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProv= context.read<ChatProvider>()..getUsers();
    return      Provider.of<ChatProvider>(context).usersState == States.loading ?
        CircularProgressIndicator()
        :    ListView.builder(
        itemCount: userProv.filteredUsers.isEmpty?
        userProv.users.length:userProv.filteredUsers.length,
        itemBuilder: (ctx,index) {

          return ListTile(
            title: Text (
                userProv.filteredUsers.isNotEmpty?
                userProv.filteredUsers[index].name:userProv.users[index].name),
            leading:CircleAvatar(
              backgroundImage:  NetworkImage(
                userProv.filteredUsers.isNotEmpty?
                userProv.filteredUsers[index].photoUrl:
                userProv.users[index].photoUrl,
              ),
            ),
          );

        } ) ;
  }
}
