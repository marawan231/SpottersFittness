import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotters_app_clone/business_logic/cubit/chat_cubit/chat_cubit.dart';
import 'package:spotters_app_clone/data/model/chat_users_model.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/circle_container_with_green_on_top.dart';
import 'package:spotters_app_clone/presentation/widgets/custom_textfield_personal.dart';

import '../resources/color_manger.dart';
import '../resources/styles_manager.dart';
import 'package:path/path.dart' show basename;

import '../widgets/full_photo_page.dart';

class ChatView extends StatefulWidget {
  ChatView({
    Key? key,
    required this.selectedUserToChatWithToken,
  }) : super(key: key);
  String? selectedUserToChatWithToken;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  String _enteredMessage = '';
  TextEditingController messageController = TextEditingController();
  int selectedIndex = -1;
  File? imageFile;
  String currentId = '';
  var imageName;
  String currentUrl = '';
  bool isLoader = false;
  PickedFile? _imageFile;
  var imageUrl;

  final ImagePicker _picker = ImagePicker();
  var source;

  _buildBody(context) {
    return Column(
      children: [
        _bulildUsersOnline(context),
        _buildChatting(),
        if (widget.selectedUserToChatWithToken != null) _buildBottomContainer(),
      ],
    );
  }

  _bulildUsersOnline(context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.grey.shade100,
        child: ListView.builder(
          itemCount: BlocProvider.of<ChatCubit>(context).allUsers.length,
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 8, left: 8),
                child: Stack(
                  alignment: Alignment.topRight,
                  // fit: StackFit.loose,
                  children: [
                    _buildCircleAvatar(
                        BlocProvider.of<ChatCubit>(context).allUsers[index],
                        index),
                    _buildOnlineCircle(context),
                  ],
                ),
              )),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  _buildOnlineCircle(context) {
    return Positioned(
      // right: MediaQuery.of(context).size.width * .14,
      //top: MediaQuery.of(context).size.height * .01,
      child: Container(
        height: MediaQuery.of(context).size.height * .02,
        width: MediaQuery.of(context).size.width * .04,
        // padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
        ),
      ),
    );
  }

  _buildCircleAvatar(ChatUsers chatUser, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.selectedUserToChatWithToken = chatUser.usrToken;

          selectedIndex = index;
          chatUser.isSelected = true;
        });
        // Set Index to note the Selected Item
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        width: 65.0,
        height: 65.0,
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
            image: NetworkImage(
              chatUser.usrPic!,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(
            color: (chatUser.isSelected && selectedIndex == index)
                ? Colors.green
                : Colors.grey,
            width: 3.0,
          ),
        ),
      ),
      // child: Container(
      //   padding: const EdgeInsets.all(8.0),
      //   decoration: BoxDecoration(
      //       border: Border.all(color: Colors.amber, width: 4),
      //       borderRadius: BorderRadius.all(Radius.circular(50))),
      //   child: CircleAvatar(
      //     radius: 40,
      //     child: ClipOval(
      //       child: Image.network(
      //         chatUser.usrPic!,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  _buildChatting() {
    return Expanded(
      flex: 6,
      child: widget.selectedUserToChatWithToken == null
          ? const Center(
              child: Text(
                'Please SelectChat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(widget.selectedUserToChatWithToken!)
                  .orderBy(
                    'createdAt',
                    descending: true,
                  )
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                if (!chatSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final chatDocs = chatSnapshot.data!.docs;
                return ListView.builder(
                    reverse: true,
                    itemCount: chatDocs.length,
                    itemBuilder: (ctx, index) {
                      if (chatDocs[index]['content'] == 'text') {
                        return MessageBubble(
                          text: chatDocs[index]['text'],
                          isMe: chatDocs[index]['userId'] == userId,
                          messageSendedTime: chatDocs[index]['createdAt'],
                          key: ValueKey(chatDocs[index].id),
                        );
                      } else if (chatDocs[index]['content'] == 'image') {
                        return ImageContainer(
                          url: chatDocs[index]['image_url'],
                          isMe: chatDocs[index]['userId'] == userId,
                          key: ValueKey(chatDocs[index].id),
                        );
                      } else if (chatDocs[index]['image_url'] == 'loading') {
                        print('koa');
                        return _loadingWidget(
                          isMe: chatDocs[index]['userId'] == userId,
                        );
                      } else {
                        return Text('asdasdasd');
                      }
                    });
              },
            ),
    );
  }

  _loadingWidget({bool? isMe}) {
    return Column(
      crossAxisAlignment:
          isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: isMe ? 20 : 10, right: 10),
          child: OutlinedButton(
            onPressed: () {},
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0))),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: 200,
                height: 200,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.myPink,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildBottomContainer() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildButton(),
        _buildTextField(),
      ],
    );
  }

  _buildButton() {
    return Padding(
      padding:
          const EdgeInsets.only(right: 12.0, left: 16.0, bottom: 12.0, top: 8),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: ColorManager.myPink,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
          color: Colors.white,
        ),
        child: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.plus,
            color: ColorManager.myPink,
          ),
          onPressed: () {
            _pickImageFromGallary();
          },
        ),
      ),
    );
  }

  Future _pickImageFromGallary() async {
    await showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => _buildSheet());
    print(source.toString());
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );

      setState(() {
        _imageFile = pickedFile;
        imageFile = File(_imageFile!.path);
      });

      await uploadImage(imageFile!);
    } catch (e) {
      print("Image picker error + ${e.toString()}");
    }
  }

  Future<void> uploadImage(File image) async {
    await FirebaseFirestore.instance
        .collection(widget.selectedUserToChatWithToken!)
        .add({
      'image_url': 'loading',
      'createdAt': Timestamp.now().toString(),
      'userId': userId,
      'content': 'loading'
    });
    await FirebaseFirestore.instance
        .collection(widget.selectedUserToChatWithToken!)
        .where('content', isEqualTo: 'loading')
        .get()
        .then((value) {
      currentId = value.docs.first.id;
    });

    final bytess = image
        .readAsBytesSync(); //"_image" is your selected image or any other which you need to upload
    var timeStamp = DateTime.now();
    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/jpeg');
    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        // ignore: prefer_interpolation_to_compose_strings
        .ref('users_images/${widget.selectedUserToChatWithToken!}' +
            timeStamp.toString() +
            '.png')
        .putData(bytess, metadata);
    firebase_storage.TaskSnapshot downloadUrl = (await task);

    String url = (await downloadUrl.ref
        .getDownloadURL()); //this is the url of uploaded image
    currentUrl = url;
    await FirebaseFirestore.instance
        .collection(widget.selectedUserToChatWithToken!)
        .doc(currentId)
        .update({
      'image_url': currentUrl,
      'createdAt': Timestamp.now().toString(),
      'userId': userId,
      'content': 'image'
    }) // <-- Doc ID where data should be updated.
        .catchError((error) => print('Update failed: $error'));
  }

  // uploadImage() async {
  //   try {
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child('user_image/${widget.selectedUserToChatWithToken!.toString()}')
  //         .child(" ${Random().nextInt(10000000)}.jpg");

  //     await ref.putFile(imageFile!);
  //     final url = await ref.getDownloadURL();

  //   } catch (err) {
  //     print(err);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(err.toString()),
  //         backgroundColor: Colors.redAccent,
  //       ),
  //     );
  //   }
  // }

  Widget _buildSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              source = ImageSource.camera;
            });
            Navigator.pop(context);
          },
          child: const Text('CAMERA'),
        ),
        TextButton(
          onPressed: () {
            print('object 2');
            setState(() {
              source = ImageSource.gallery;
            });
            Navigator.pop(context);
          },
          child: const Text('GALLERY'),
        ),
      ],
    );
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance
        .collection(widget.selectedUserToChatWithToken!)
        .add(
      {
        'text': _enteredMessage,
        'createdAt': Timestamp.now().toString(),
        'userId': userId,
        'content': 'text'
      },
    );
    messageController.clear();
    _enteredMessage = '';
  }

  _buildTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: PersonalTextField(
          onChanged: (value) {
            setState(() {
              _enteredMessage = value;
            });
          },
          controller: messageController,
          borderColore: Colors.black,
          hintText: 'Type here ..',
          widget: Container(),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: ColorManager.myPink,
              child: IconButton(
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
                icon: const Icon(
                  FontAwesomeIcons.arrowRight,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorManager.appBarGradientColor,
          ),
        ),
        //   backgroundColor: const Color(0xFFC98CF3),
        centerTitle: true,
        title: const Text("Chat"),
      ),
      body: _buildBody(context),
    );
  }
}

// ignore: unused_element

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, this.url, this.isMe}) : super(key: key);

  final url;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: isMe! ? 20 : 10, right: 10),
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullPhotoPage(
                    url: url,
                  ),
                ),
              );
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0))),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                url,
                // loadingBuilder: (BuildContext context, Widget child,
                //     ImageChunkEvent? loadingProgress) {
                //   if (loadingProgress == null) return child;
                //   return Container(
                //     decoration: const BoxDecoration(
                //       color: Colors.grey,
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(8),
                //       ),
                //     ),
                //     width: 200,
                //     height: 200,
                //     child: Center(
                //       child: CircularProgressIndicator(
                //         color: Colors.white,
                //         value: loadingProgress.expectedTotalBytes != null
                //             ? loadingProgress.cumulativeBytesLoaded /
                //                 loadingProgress.expectedTotalBytes!
                //             : null,
                //       ),
                //     ),
                //   );
                //    },
                // errorBuilder: (context, object, stackTrace) {
                //   return Material(
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(8),
                //     ),
                //     clipBehavior: Clip.hardEdge,
                //     child: Image.asset(
                //       'assets/images/img_not_available.jpeg',
                //       width: 200,
                //       height: 200,
                //       fit: BoxFit.cover,
                //     ),
                //   );
                // },
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String? text;
  final messageSendedTime;
  final bool? isMe;

  const MessageBubble({
    super.key,
    this.text,
    this.messageSendedTime,
    this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            elevation: 10.0,
            color: isMe! ? Colors.grey.shade700 : ColorManager.myPurble,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                text!,
                style: const TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),

          // Container(
          //   padding: const EdgeInsets.only(top: 8),
          //   child: Text(
          //     messageSendedTime!,
          //     style: const TextStyle(color: Colors.black45, fontSize: 12.0),
          //   ),
          // ),
        ],
      ),
    );
  }
}
