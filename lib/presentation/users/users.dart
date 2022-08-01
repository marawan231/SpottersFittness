import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:spotters_app_clone/business_logic/cubit/chat_cubit/chat_cubit.dart';
import 'package:spotters_app_clone/data/model/chat_users_model.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/badge.dart';
import 'package:spotters_app_clone/presentation/widgets/user_card_item.dart';

import '../resources/color_manger.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  List<ChatUsers> allUsers = [];
  List<ChatUsers> searchedForUser = [];
  bool _isSearching = false;
  String searchedText = '';

  FloatingSearchBarController floatingBarController =
      FloatingSearchBarController();
  var progressIndicator = false;

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForUser = allUsers
        .where(
          (user) => user.fname!.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.grey,
          ),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        )
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      floatingBarController.clear();
    });
  }

  Widget _buildFloatingSearchBar() {
    return FloatingSearchBar(
      controller: floatingBarController,
      automaticallyImplyBackButton: false,
      margins: const EdgeInsets.all(16),
      leadingActions: const [
        Icon(
          Icons.search,
          color: ColorManager.myPurble,
          size: 30,
        )
      ],
      height: MediaQuery.of(context).size.height * .08,
      hint: 'Search.....',
      hintStyle: const TextStyle(color: Color(0xFFDBDBDB), fontSize: 14),
      openAxisAlignment: 0.0,
      border: const BorderSide(
        color: ColorManager.myPurble,
        width: 2,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      axisAlignment: 0.0,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 20),
      elevation: 0.0,
      physics: const BouncingScrollPhysics(),
      onQueryChanged: (query) {
        //Your methods will be here
        searchedText = query;
        addSearchedForItemsToSearchedList(searchedText);
      },
      // showDrawerHamburger: false,
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: const Duration(milliseconds: 500),
      actions: [],
      builder: (context, transition) {
        return SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Material(
              color: Colors.white,
              child: Container(
                height: 600.0,
                color: Colors.white,
                child: _buildUsersList(),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildUsersList() {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is UsersLoaded) {
          allUsers = state.chatUsers;
        }
      },
      builder: (context, state) {
        return state is UsersLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .1),
                itemCount: searchedText.isEmpty
                    ? allUsers.length
                    : searchedForUser.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    chatUser: searchedText.isEmpty
                        ? allUsers[index]
                        : searchedForUser[index],
                    index: index,
                  );
                });
      },
    );
  }

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getAllChatUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorManager.appBarGradientColor,
          ),
        ),
        elevation: 0.0,

        // backgroundColor: const Color(0xFFC88AF3),
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _buildUsersList(),
          _buildFloatingSearchBar(),
        ],
      ),
    );
  }
}
