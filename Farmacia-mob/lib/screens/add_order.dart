import 'package:farmacia/models/all_med_mod.dart';
import 'package:farmacia/screens/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';

class Cart extends GetView<CartControllerImp> {
  const Cart({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CartControllerImp());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation:0.0,
        iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
        surfaceTintColor: Colors.transparent,
        title:  Text('54'.tr,style:TextStyle(color:Colors.black),),
        centerTitle: true,
        actions: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () => controller.createOrder(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.add_shopping_cart_rounded),
            ),
          )
        ],
      ),
      body: GetBuilder<CartControllerImp>(
        builder: (controller) {
          return controller.listMedication.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: controller.listMedication.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      controller: controller.listTextController[index],
                      model: controller.listMedication[index],
                    );
                  },
                );
        },
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.model,
    required this.controller,
  });
  final all_med_model model;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromARGB(255, 244, 255, 252),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
            )
          ],
          border: Border.all(width: 0.5, color: Colors.grey.shade200)),
      child: Row(
        children: [
          ShaderMask(
            blendMode:BlendMode.srcIn,
              shaderCallback: (Rect bounds){
              return LinearGradient(
                  colors:[
                    Color.fromARGB(196, 41, 185, 114), //green
                    Color.fromARGB(255, 109, 161, 245), //blue
                  ]).createShader(bounds);
              },
          child:Icon(Icons.medication_outlined,size:35,),),
          const SizedBox(width: 8),
          AutoSizeText(
              model.name,
            group: AutoSizeGroup(),
            maxLines: 2,
            maxFontSize: 20,
            minFontSize: 17,
            overflow: TextOverflow.clip,
            style: const TextStyle(//fontSize: 18,
              color:Colors.black//
              // fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 100,
            height: 40,
            child: TextFormField(
              cursorColor:Colors.grey,
              controller: controller,
              style: const TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'^0')),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(7),
              ],
              decoration: InputDecoration(
                hintText: '55'.tr,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: const BorderSide(
                      color: Colors.black, width: 1.5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Colors.blueGrey,
                        width: 2.5,
                        style: BorderStyle.solid)),
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
