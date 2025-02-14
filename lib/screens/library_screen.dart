import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> allBooks = [
    Book(title: "The Lean Startup", author: "Eric Ries", overdueDays: 5, dueDate: "2025/01/15"),
    Book(title: "Sapiens", author: "Yuval Noah Harari", overdueDays: 12, dueDate: "2025/01/10"),
    Book(title: "Atomic Habits", author: "James Clear", overdueDays: 33, dueDate: "2024/12/04"),
    Book(title: "Deep Work", author: "Cal Newport", overdueDays: 45, dueDate: "2024/12/19"),
  ];

  List<Book> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = allBooks; // Initially, display all books.
    _searchController.addListener(_filterBooks);
  }

  void _filterBooks() {
    setState(() {
      filteredBooks = allBooks
          .where((book) =>
              book.title.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBooks);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Library",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
      ),
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Books',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const TabBar(
              indicatorColor: Colors.teal,
              tabs: [
                Tab(child: Text("My Books", style: TextStyle(color: Colors.teal))),
                Tab(child: Text("All Books", style: TextStyle(color: Colors.teal))),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // First Tab: My Books
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: const [
                      BookTile(
                        title: "Atomic Habits",
                        author: "James Clear",
                        overdueDays: 33,
                        dueDate: "2024/12/04",
                      ),
                      BookTile(
                        title: "Deep Work",
                        author: "Cal Newport",
                        overdueDays: 45,
                        dueDate: "2024/12/19",
                      ),
                    ],
                  ),
                  // Second Tab: All Books with Search Filter
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return BookTile(
                        title: book.title,
                        author: book.author,
                        overdueDays: book.overdueDays,
                        dueDate: book.dueDate,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
    );
  }
}

class Book {
  final String title;
  final String author;
  final int overdueDays;
  final String dueDate;

  Book({
    required this.title,
    required this.author,
    required this.overdueDays,
    required this.dueDate,
  });
}

class BookTile extends StatelessWidget {
  final String title;
  final String author;
  final int overdueDays;
  final String dueDate;

  const BookTile({super.key, required this.title, required this.author, required this.overdueDays, required this.dueDate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.book, size: 40, color: Colors.teal),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("By $author\nOverdue by $overdueDays Days"),
        trailing: Text(dueDate, style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
