import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaveNoteScreen extends StatefulWidget {
  const LeaveNoteScreen({super.key});

  @override
  _LeaveNoteScreenState createState() => _LeaveNoteScreenState();
}

class _LeaveNoteScreenState extends State<LeaveNoteScreen> {
  String subject = '';
  String message = '';
  DateTime? fromDate;
  DateTime? toDate;
  String leaveType = 'Sick Leave';
  String additionalNotes = '';
  bool isSubmitting = false; // Loading indicator

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Request',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0))),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildRequestDetailsSection(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, spreadRadius: 2, blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Request Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
          const SizedBox(height: 16),
          _buildTextField('Subject', (value) => subject = value),
          const SizedBox(height: 16),
          _buildTextField('Message', (value) => message = value, maxLines: 3),
          const SizedBox(height: 16),
          _buildDatePickerRow(),
          const SizedBox(height: 16),
          _buildLeaveTypeDropdown(),
          if (leaveType == 'Other') ...[
            const SizedBox(height: 16),
            _buildTextField('Additional Notes', (value) => additionalNotes = value, maxLines: 3),
          ],
        ],
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged, {int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF60B8AF)),
        ),
      ),
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }

  Widget _buildDatePickerRow() {
    return Row(
      children: [
        _buildDatePicker('From Date', fromDate, true),
        const SizedBox(width: 16),
        _buildDatePicker('To Date', toDate, false),
      ],
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate, bool isFromDate) {
    return Expanded(
      child: InkWell(
        onTap: () => _selectDate(context, isFromDate),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate) : label,
                style: TextStyle(color: selectedDate != null ? Colors.black : Colors.grey),
              ),
              const Icon(Icons.calendar_today, color: Color(0xFF60B8AF)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: leaveType,
      decoration: const InputDecoration(
        labelText: 'Leave Type',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF60B8AF)),
        ),
      ),
      items: ['Sick Leave', 'Personal Leave', 'Vacation', 'Other']
          .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value)))
          .toList(),
      onChanged: (newValue) {
        setState(() {
          leaveType = newValue!;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: isSubmitting ? null : _submitLeaveRequest,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          backgroundColor: const Color(0xFF60B8AF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: isSubmitting
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Submit', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Future<void> _submitLeaveRequest() async {
    if (subject.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subject and Message are required')),
      );
      return;
    }

    if (fromDate == null || toDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both dates')),
      );
      return;
    }

    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      await Supabase.instance.client.from('leave_requests').insert({
        'user_id': currentUser.id,
        'subject': subject,
        'message': message,
        'from_date': fromDate!.toIso8601String(),
        'to_date': toDate!.toIso8601String(),
        'leave_type': leaveType,
        'additional_notes': additionalNotes,
        'created_at': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Leave request submitted successfully')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }
}
