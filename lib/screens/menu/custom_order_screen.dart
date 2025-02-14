import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';

class CustomOrderScreen extends StatefulWidget {
  const CustomOrderScreen({super.key});

  @override
  State<CustomOrderScreen> createState() => _CustomOrderScreenState();
}

class _CustomOrderScreenState extends State<CustomOrderScreen> {
  final List<Map<String, dynamic>> _extraItems = [
    {"name": "Extra Chicken", "price": 50, "quantity": 0},
    {"name": "Extra Fish", "price": 40, "quantity": 0},
    {"name": "Extra Egg", "price": 20, "quantity": 0},
    {"name": "Extra Rice", "price": 15, "quantity": 0},
    {"name": "Extra Dal", "price": 10, "quantity": 0},
  ];

  int _guestCount = 0;
  int _totalCost = 0;

  void _updateTotalCost() {
    int cost = 0;
    for (var item in _extraItems) {
      cost += (item["price"] as int) * (item["quantity"] as int);
    }
    cost += _guestCount * 100; // Assume guest meal costs 100 per person
    setState(() {
      _totalCost = cost;
    });
  }

  void _incrementItem(int index) {
    setState(() {
      _extraItems[index]["quantity"]++;
      _updateTotalCost();
    });
  }

  void _decrementItem(int index) {
    if (_extraItems[index]["quantity"] > 0) {
      setState(() {
        _extraItems[index]["quantity"]--;
        _updateTotalCost();
      });
    }
  }

  void _confirmOrder() {
    // Process order logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order confirmed! Total cost: $_totalCost BDT")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: Text("Custom Order", style: AppTheme.textTheme.displaySmall),
        centerTitle: true,
        backgroundColor: AppTheme.gold,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Extra Items",
              style: AppTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _extraItems.length,
                itemBuilder: (context, index) {
                  final item = _extraItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item["name"],
                              style: AppTheme.textTheme.bodyLarge),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () => _decrementItem(index),
                              ),
                              Text("${item["quantity"]}",
                                  style: AppTheme.textTheme.bodyLarge),
                              IconButton(
                                icon: const Icon(Icons.add_circle,
                                    color: Colors.green),
                                onPressed: () => _incrementItem(index),
                              ),
                            ],
                          ),
                          Text("${item["price"] * item["quantity"]} BDT",
                              style: AppTheme.textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Add Guests",
              style: AppTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Guests: $_guestCount",
                    style: AppTheme.textTheme.bodyLarge),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        if (_guestCount > 0) {
                          setState(() {
                            _guestCount--;
                            _updateTotalCost();
                          });
                        }
                      },
                    ),
                    Text("$_guestCount", style: AppTheme.textTheme.bodyLarge),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          _guestCount++;
                          _updateTotalCost();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Total Cost: $_totalCost BDT",
              style: AppTheme.textTheme.headlineMedium!
                  .copyWith(color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _confirmOrder,
              child: const Center(child: Text("Confirm Order")),
            ),
          ],
        ),
      ),
    );
  }
}
