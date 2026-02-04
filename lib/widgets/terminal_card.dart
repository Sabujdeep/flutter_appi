import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class TerminalCard extends StatelessWidget {
  final String name;
  final String email;

  const TerminalCard({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF8B1F9C),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.white),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
