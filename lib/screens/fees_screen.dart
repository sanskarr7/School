import 'package:edu360/function/esewa.dart';
import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fees App',
      theme: ThemeData(
        fontFamily: 'Arial',
        primarySwatch: Colors.orange,
      ),
      home: const FeesScreen(),
    );
  }
}

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  _FeesScreenState createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  final List<FeeSection> feeSections = [
    FeeSection(
      month: 'Poush',
      date: '2081/09/8',
      details: [
        FeeDetail(description: 'Bill Amount', amount: 'Rs. 5,000/-'),
        FeeDetail(description: 'Previous Advance', amount: 'Rs. 1,000/-'),
        FeeDetail(description: 'Previous Due', amount: 'Rs. 500/-'),
      ],
    ),
    FeeSection(
      month: 'Mangsir',
      date: '2081/08/15',
      details: [
        FeeDetail(description: 'Bill Amount', amount: 'Rs. 5,000/-'),
        FeeDetail(description: 'Previous Balance', amount: 'Rs. 500/-'),
        FeeDetail(description: 'Previous Due', amount: 'Rs. 300/-'),
      ],
    ),
    FeeSection(
      month: 'Bill - Paid',
      date: '2081/07/18',
      details: [
        FeeDetail(description: 'Previous Advance', amount: 'Rs. 2,000/-'),
        FeeDetail(description: 'Previous Due', amount: 'Rs. 0/-'),
        FeeDetail(description: 'Total Paid', amount: 'Rs. 5,000/-'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fees',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: feeSections.length,
        itemBuilder: (context, index) {
          return FeeSectionWidget(feeSection: feeSections[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _payWithEsewa(); // Call function to initiate eSewa payment
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.payment),
      ),
    );
  }

  // Function to trigger eSewa payment
  Future<void> _payWithEsewa() async {
    try {
      Esewa esewa = Esewa();
      // Add additional configurations if required by eSewa API
      esewa.pay();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    }
  }
}

class FeeSection {
  final String month;
  final String date;
  final List<FeeDetail> details;

  FeeSection({required this.month, required this.date, required this.details});
}

class FeeDetail {
  final String description;
  final String amount;

  FeeDetail({required this.description, required this.amount});
}

class FeeSectionWidget extends StatelessWidget {
  final FeeSection feeSection;

  const FeeSectionWidget({super.key, required this.feeSection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: _getFeeSectionColor(feeSection.month),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(feeSection.month,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                Text(feeSection.date,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(color: Colors.grey),
            ...feeSection.details.map((detail) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(detail.description,
                          style: const TextStyle(color: Colors.black)),
                      Text(detail.amount,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ],
                  ),
                )),
            const Divider(color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Due Amount',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                Text('Rs. XXXX', // Replace XXXX with actual due amount
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getFeeSectionColor(String month) {
    if (month == 'Bill - Paid') {
      return const Color(0xFF60B8AF);
    } else {
      return Colors.white;
    }
  }
}
