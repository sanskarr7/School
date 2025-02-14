import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  // Method to calculate total percentage for each term
  double calculateTotal(List<double> percentages) {
    double total = percentages.reduce((a, b) => a + b);
    return total / percentages.length;  // Return average percentage
  }

  @override
  Widget build(BuildContext context) {
    // Example percentages for each term
    List<double> firstTermPercentages = [67.5, 82, 57, 55, 75, 61, 45, 67];
    List<double> secondTermPercentages = [70, 80, 65, 60, 72, 65, 50, 70];
    List<double> thirdTermPercentages = [75, 85, 60, 58, 78, 72, 48, 74];
    List<double> finalPercentages = [80, 88, 70, 65, 80, 75, 55, 80];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Results",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),  // Corrected color format
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: DefaultTabController(
        length: 4, // Number of tabs
        child: Column(
          children: [
            // TabBar for selecting different terms
            const TabBar(
              indicatorColor: Colors.tealAccent,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(child: Text("1st Term")),
                Tab(child: Text("2nd Term")),
                Tab(child: Text("3rd Term")),
                Tab(child: Text("Final")),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Display 1st Term Results
                  ResultsForTerm(percentages: firstTermPercentages),
                  // Display 2nd Term Results
                  ResultsForTerm(percentages: secondTermPercentages),
                  // Display 3rd Term Results
                  ResultsForTerm(percentages: thirdTermPercentages),
                  // Display Final Term Results
                  ResultsForTerm(percentages: finalPercentages),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFf3f4f6),
    );
  }
}

class ResultsForTerm extends StatelessWidget {
  final List<double> percentages;

  const ResultsForTerm({super.key, required this.percentages});

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal(percentages);  // Calculate total for the term

    return Column(
      children: [
        // Display Total for the Term
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total: ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              Text(
                "${total.toStringAsFixed(2)}%",  // Display total as percentage
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
        // List of Results for the Subjects in the Term
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ResultTile(subject: "Math", percentage: percentages[0], grade: "B"),
              ResultTile(subject: "English", percentage: percentages[1], grade: "A"),
              ResultTile(subject: "Science", percentage: percentages[2], grade: "C+"),
              ResultTile(subject: "Nepali", percentage: percentages[3], grade: "C"),
              ResultTile(subject: "Computer", percentage: percentages[4], grade: "B+"),
              ResultTile(subject: "Social Study", percentage: percentages[5], grade: "B"),
              ResultTile(subject: "Health", percentage: percentages[6], grade: "C"),
              ResultTile(subject: "Economics", percentage: percentages[7], grade: "B"),
            ],
          ),
        ),
      ],
    );
  }

  double calculateTotal(List<double> percentages) {
    double total = percentages.reduce((a, b) => a + b);
    return total / percentages.length;  // Calculate and return average percentage
  }
}

class ResultTile extends StatelessWidget {
  final String subject;
  final double percentage;
  final String grade;

  const ResultTile({super.key, required this.subject, required this.percentage, required this.grade});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        leading: const Icon(Icons.school, size: 40, color: Colors.teal),
        title: Text(
          subject,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          "Percentage: $percentage%",
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Text(
          "Grade: $grade",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 16),
        ),
      ),
    );
  }
}
