import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_rates/app_colors.dart';
import 'package:exchange_rates/home_page/store/home_store.dart';
import 'package:exchange_rates/widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import "package:flutter_mobx/flutter_mobx.dart";
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = getHomeStore;

  @override
  void initState() {
    store.getRation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => store.amount.isEmpty
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 25.0),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 160),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  store.from,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: AppColors.grey.withOpacity(0.7),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right_alt_outlined,
                                  color: AppColors.grey.withOpacity(0.7),
                                ),
                                Text(
                                  store.to,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: AppColors.grey.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 100,
                              width: double.maxFinite,
                              child: store.isLoading
                                  ? const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : Text(
                                      store.amount,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 80.0,
                                        color: AppColors.grey,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: double.maxFinite,
                              child: store.isLoading
                                  ? Text(
                                      "loading".tr(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      store.percent,
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontStyle: FontStyle.italic,
                                        color: store.growing != -1
                                            ? AppColors.green
                                            : AppColors.red,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: InkWell(
                          onTap: store.isLoading
                              ? null
                              : () {
                                  modalBottomSheet();
                                },
                          child: SvgPicture.asset("assets/icons/menu.svg"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "update".tr(
                            args: [DateFormat('kk:mm').format(DateTime.now())],
                          ),
                          style: TextStyle(
                            color: AppColors.grey.withOpacity(0.4),
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void modalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: AppColors.grey,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: DraggableScrollableSheet(
            initialChildSize: 1.0,
            expand: false,
            builder: (context, scrollController) => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              controller: scrollController,
              shrinkWrap: false,
              itemCount: store.couples.length,
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.black,
              ),
              itemBuilder: (context, index) => SizedBox(
                height: 45.0,
                width: double.infinity,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        store.getCurrency(store.couples[index])[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: store.currency == store.couples[index]
                              ? AppColors.white
                              : AppColors.white.withOpacity(0.7),
                          fontWeight: store.currency == store.couples[index]
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt_outlined,
                        color: store.currency == store.couples[index]
                            ? AppColors.white
                            : AppColors.white.withOpacity(0.7),
                      ),
                      Text(
                        store.getCurrency(store.couples[index])[1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: store.currency == store.couples[index]
                              ? AppColors.white
                              : AppColors.white.withOpacity(0.7),
                          fontWeight: store.currency == store.couples[index]
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    store.setCurrency(store.couples[index]);
                    Navigator.pop(context);
                    await store.getRation();
                    if (!store.isSuccess) _showDialog();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDialog() async {
    await AlertDialogWidget.showErrorDialog(
      context,
      onRefresh: store.getRation,
    );
  }
}
