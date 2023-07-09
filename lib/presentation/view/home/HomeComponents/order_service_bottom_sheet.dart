import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/resources/validation_manager.dart';


import '../../../../app/routes/navigation_manager.dart';
import '../../../../app/routes/route_constants.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';
import '../category_screen.dart';

class OrderServiceBottomSheet extends StatefulWidget {
  const OrderServiceBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderServiceBottomSheet> createState() =>
      _OrderServiceBottomSheetState();
}

class _OrderServiceBottomSheetState extends State<OrderServiceBottomSheet> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int serviceCount = 1;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'طلب خدمة',
                        style: StyleManger.headline1(fontSize: 22),
                      ),
                      const CardForIconWidget(
                          icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 30,
                        right: 30),
                    child: ListView(
                      children: [
                        const LabelTextFieldWidget(text: 'التاريخ'),
                        TextFormField(
                          readOnly: true,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (date == null) return;
                            setState(() {
                              selectedDate = date;
                            });
                          },
                          validator: (value) => value!.isNotEmptyField,
                          controller: TextEditingController(
                              text: selectedDate != null
                                  ? DateFormat.yMd('en-IN')
                                      .format(selectedDate!)
                                  : null),
                          decoration: const InputDecoration(
                            hintText: 'يوم - شهر - سنة',
                            suffixIcon: Icon(
                              Icons.date_range_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const LabelTextFieldWidget(text: 'الوقت'),
                        TextFormField(
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (time == null) return;
                            setState(() {
                              selectedTime = time;
                            });
                          },
                          validator: (value) => value!.isNotEmptyField,
                          controller: TextEditingController(
                              text: selectedTime != null
                                  ? selectedTime!.format(context)
                                  : null),
                          decoration: const InputDecoration(
                            hintText: 'اضغط لاختيار الوقت المناسب',
                            suffixIcon: Icon(
                              Icons.schedule_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const LabelTextFieldWidget(text: 'العدد من هذه الخدمة'),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        minimumSize:
                                            const Size(double.infinity, 55),
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        serviceCount++;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                style: StyleManger.headline1(fontSize: 16),
                                controller: TextEditingController(
                                  text: serviceCount.toString(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        minimumSize:
                                            const Size(double.infinity, 55),
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.white),
                                    onPressed: () {
                                      if (serviceCount == 1) return;
                                      setState(() {
                                        serviceCount--;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    )))
                          ],
                        ),
                        const LabelTextFieldWidget(text: 'الموقع الجغرافي'),
                        TextFormField(
                          validator: (value) => value!.isNotEmptyField,
                          decoration: const InputDecoration(
                            hintText: 'اضغط لاختيار الموقع المناسب',
                            suffixIcon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.zero),
                            onPressed: () {},
                            child: const Text(
                              '+ اضافة عنوان جديد',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
                            )),
                        const LabelTextFieldWidget(text: 'تفاصيل إضافية'),
                        TextFormField(
                          maxLines: 54,
                          minLines: 5,
                          validator: (value) => value!.isNotEmptyField,
                          decoration: const InputDecoration(
                              hintText:
                                  'اي تفاصيل اضافية تساعدنا في فهم احتياجكم لهذه الخدمة'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 8,
                )
              ]),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          NavigationManager.goToAndRemove(
                              RouteConstants.serviceInfoRoute);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size(double.infinity, 56)),
                      child: const Text('تأكيد الطلب'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      initialValue: '80 شيكل',
                      style: StyleManger.headline1(
                          color: ColorManager.primaryMainEnableColor,
                          fontSize: 16),
                      decoration: InputDecoration(fillColor: Color(0xFFEBF1F0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LabelTextFieldWidget extends StatelessWidget {
  const LabelTextFieldWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: StyleManger.headline1(fontSize: 14),
      ),
    );
  }
}
