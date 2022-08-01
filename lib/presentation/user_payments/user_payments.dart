import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spotters_app_clone/business_logic/cubit/user_payment/user_payment_info_cubit.dart';
import 'package:spotters_app_clone/data/model/user_payment_model.dart';
import 'package:spotters_app_clone/presentation/widgets/user_row.dart';

import '../resources/color_manger.dart';
import '../resources/constants_manager.dart';
import '../widgets/custom_textfield_personal.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

DateTime date = DateTime(2022, 7, 1);

class UserPaymentsView extends StatefulWidget {
  const UserPaymentsView({Key? key}) : super(key: key);

  @override
  State<UserPaymentsView> createState() => _UserPaymentsViewState();
}

class _UserPaymentsViewState extends State<UserPaymentsView> {
  List<UserPaymentInfo> usersPayInfo = [];

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  var fromDate;
  var toDate;
  _buildBody(context) {
    return BlocConsumer<UserPaymentInfoCubit, UserPaymentInfoState>(
      listener: (context, state) {
        if (state is PaymentsLoading) {}
        if (state is PaymentSuccedded) {
          usersPayInfo = state.userPaymentInfo;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            _buildFromToDate(context),
            _buildTableHeader(),
            _buildTable(),
          ],
        );
      },
    );
  }

  _buildTableHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * .06,
      color: ColorManager.myPurble,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            'Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            'OrderId',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            'Date',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            'Amount',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  _buildTable() {
    return Expanded(
      flex: 4,
      child: ListView.builder(
          itemCount: usersPayInfo.length,
          itemBuilder: (context, index) {
            return UserRaw(
              userName: usersPayInfo[index].userID,
              orderId: usersPayInfo[index].orderid,
              date: usersPayInfo[index].dt,
              amount: usersPayInfo[index].amountPaid,
            );
          }),
      // titleColumn - List<String> (title column)
// titleColumn - List<String> (title row)
// titleColumn - List<List<String>> (data)
    );
  }

  _buildFromToDate(context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.only(top: 16.0, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PersonalTextField(
                controller: fromDateController,
                widget: const Text(
                  'From date',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                hintText: 'DD-MM-YYYY',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: ColorManager.myPink,
                  ),
                  onPressed: () async {
                    DateTime? frromDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1940),
                      lastDate: DateTime(2030),
                    );

                    setState(() {
                      fromDateController.clear();
                      fromDateController.text =
                          '${frromDate!.year}/${frromDate.month}/${frromDate.day}';
                    });
                    fromDate = frromDate;

                    if (frromDate == null) {
                      return showScaffold(
                        text: 'chosse date correct',
                        context: context,
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .05,
            ),
            Expanded(
              child: PersonalTextField(
                controller: toDateController,
                widget: const Text(
                  'To Date',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                hintText: 'DD-MM-YYYY',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: ColorManager.myPink,
                  ),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1940),
                      lastDate: DateTime(2030),
                    );

                    setState(() {
                      toDateController.clear();
                      toDateController.text =
                          '${newDate!.year}/${newDate.month}/${newDate.day}';
                    });
                    if (newDate != null) {
                      BlocProvider.of<UserPaymentInfoCubit>(context)
                          .getUserPaymentsInfoByDate(
                        DateFormat('yyyy-MM-dd').format(fromDate),
                        DateFormat('yyyy-MM-dd').format(newDate),
                      );
                    }

                    if (newDate == null) {
                      return showScaffold(
                        text: 'chosse date correct',
                        context: context,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<UserPaymentInfoCubit>(context).getUserPaymentsInfo();
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
        centerTitle: true,
        // backgroundColor: const Color(0xFFC98CF3),
        title: const Text('User Payments'),
      ),
      body: _buildBody(context),
    );
  }
}
