import 'package:bachmeal/models/order_model.dart';
import 'package:bachmeal/models/subscription_model.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // Sample data for orders and subscriptions
  List<Order> orders = [
    Order(
      id: '123',
      date: DateTime.now(),
      amount: 49.99,
      status: 'Paid',
    ),
    Order(
      id: '124',
      date: DateTime.now().subtract(Duration(days: 30)),
      amount: 99.99,
      status: 'Pending',
    ),
  ];

  List<Subscription> subscriptions = [
    Subscription(
      id: 'sub-001',
      plan: 'Premium',
      status: 'Active',
      startDate: DateTime.now().subtract(Duration(days: 60)),
      endDate: DateTime.now().add(Duration(days: 30)),
    ),
    Subscription(
      id: 'sub-002',
      plan: 'Basic',
      status: 'Expired',
      startDate: DateTime.now().subtract(Duration(days: 120)),
      endDate: DateTime.now().subtract(Duration(days: 30)),
    ),
  ];

  String filterType = 'All'; // For filtering orders

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order & Subscription History'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Filter and Sort Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value: filterType,
                items:
                    ['All', 'Paid', 'Pending', 'Cancelled'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    filterType = newValue!;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {
                  // Sort orders
                },
              ),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Fetch updated data
              },
              child: ListView(
                children: [
                  // Orders Section
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Past Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (orders.isEmpty)
                    Center(
                      child: Text('No orders found.'),
                    )
                  else
                    ...orders.map((order) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text('Order #${order.id}'),
                          subtitle: Text(
                              'Date: ${order.date.toLocal().toString().split(' ')[0]} - Amount: \$${order.amount}'),
                          trailing: Icon(Icons.download),
                          onTap: () {
                            // Navigate to order details or download
                          },
                        ),
                      );
                    }).toList(),

                  // Subscriptions Section
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Subscription History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (subscriptions.isEmpty)
                    Center(
                      child: Text('No subscriptions found.'),
                    )
                  else
                    ...subscriptions.map((subscription) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text('Plan: ${subscription.plan}'),
                          subtitle: Text(
                              'Status: ${subscription.status} - Renewal: ${subscription.endDate.toLocal().toString().split(' ')[0]}'),
                          trailing: Icon(Icons.info),
                          onTap: () {
                            // Navigate to subscription details
                          },
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
