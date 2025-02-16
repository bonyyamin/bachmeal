import 'package:flutter/material.dart';

class ReferFriendCard extends StatelessWidget {
  const ReferFriendCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpecialOffer(),
      ],
    );
  }

  Widget _buildSpecialOffer() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.card_giftcard, size: 40, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Refer a Friend!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  "Invite a friend and get a free meal!",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Refer Now",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
