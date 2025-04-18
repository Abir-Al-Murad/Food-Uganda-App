import 'package:flutter/material.dart';

class OrderStatusIcon extends StatefulWidget {
  const OrderStatusIcon({super.key});

  @override
  State<OrderStatusIcon> createState() => _OrderStatusIconState();
}

class _OrderStatusIconState extends State<OrderStatusIcon> with AutomaticKeepAliveClientMixin {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Needed when using AutomaticKeepAliveClientMixin
    return isLoading
        ? CircularProgressIndicator()
        : Icon(Icons.check_circle, color: Colors.green);
  }

  @override
  bool get wantKeepAlive => true;
}
