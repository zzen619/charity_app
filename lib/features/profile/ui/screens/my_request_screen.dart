import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/my_request_cubit.dart';
import '../../logic/state/my_request_state.dart';

class MyRequestScreen extends StatelessWidget {
  const MyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      appBar: AppBar(
        title: const Text("My Requests", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF0F3D35),
      ),
      body: BlocBuilder<MyRequestCubit, MyRequestState>(
        builder: (context, state) {
          if (state is MyRequestLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MyRequestLoaded) {
            if (state.requests.isEmpty) {
              return const Center(child: Text("No requests submitted yet."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                final request = state.requests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFF3E0),
                      child: Icon(Icons.description, color: Colors.orange),
                    ),
                    title: Text(request['type'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Submitted on: ${request['date'] ?? ''}"),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: request['status'] == "Approved" ? Colors.green.shade50 : Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        request['status'] ?? '',
                        style: TextStyle(
                          color: request['status'] == "Approved" ? Colors.green : Colors.amber.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is MyRequestError) {
            return Center(child: Text(state.errorMessage));
          }

          return const Center(child: Text("No requests found."));
        },
      ),
    );
  }
}