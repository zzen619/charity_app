import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/my_activity_cubit.dart';
import '../../logic/state/my_activity_state.dart';

class MyActivityScreen extends StatelessWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      appBar: AppBar(
        title: const Text("My Activities", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF0F3D35),
      ),
      body: BlocBuilder<MyActivityCubit, MyActivityState>(
        builder: (context, state) {
          if (state is MyActivityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MyActivityLoaded) {
            if (state.activities.isEmpty) {
              return const Center(child: Text("No activities found."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.activities.length,
              itemBuilder: (context, index) {
                final activity = state.activities[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F3F1),
                      child: Icon(Icons.run_circle, color: Color(0xFF0F3D35)),
                    ),
                    title: Text(activity['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(activity['date'] ?? ''),
                    trailing: Text(
                      activity['status'] ?? '',
                      style: TextStyle(
                        color: activity['status'] == "Completed" ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is MyActivityError) {
            return Center(child: Text(state.errorMessage));
          }

          return const Center(child: Text("Start exploring activities!"));
        },
      ),
    );
  }
}