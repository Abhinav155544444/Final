import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final RentalItem item;
  final String transactionId;

  const PaymentConfirmationScreen({
    Key? key,
    required this.item,
    required this.transactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Encode item name in QR data
    final qrData = "RentAll:${item.name}:$transactionId:${DateTime.now().millisecondsSinceEpoch}";

    return Scaffold(
      appBar: AppBar(title: Text("Payment Confirmation"), automaticallyImplyLeading: false),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 64),
              SizedBox(height: 16),
              Text("Payment Successful!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("Your ${item.category} rental has been confirmed", style: TextStyle(fontSize: 16)),
              SizedBox(height: 24),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
                ),
                child: Column(
                  children: [
                    Text("Scan QR Code to Confirm Pickup", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    SizedBox(height: 8),
                    Text("Transaction ID: $transactionId", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),

              SizedBox(height: 24),
              Text("Item: ${item.name}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Price: ₹${item.price.toStringAsFixed(2)}/day", style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: qrData));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Booking details copied to clipboard")),
                  );
                },
                child: Text("Copy Booking Details"),
              ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Text("Back to Home"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}