import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;  // Add an onTap callback

  const GridItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,  // Allow onTap to be null
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // Handle tap event
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffede1dede),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff33000000),
              
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color.fromARGB(255, 24, 24, 23)),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
