import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/my_impact_cubit.dart';
import '../../logic/state/my_impact_state.dart';

class MyImpactScreen extends StatelessWidget {
  const MyImpactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      appBar: AppBar(
        title: const Text("My Donations", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF0F3D35),
      ),
      body: BlocBuilder<MyImpactCubit, MyImpactState>(
        builder: (context, state) {
          if (state is MyImpactLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MyImpactLoaded) {
            if (state.impacts.isEmpty) {
              return const Center(child: Text("No donations found."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.impacts.length,
              itemBuilder: (context, index) {
                final impact = state.impacts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F3F1),
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                    title: Text(impact['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(impact['date'] ?? ''),
                    trailing: Text(
                      impact['amount'] ?? '',
                      style: const TextStyle(
                        color: Color(0xFF0F3D35),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is MyImpactError) {
            return Center(child: Text(state.errorMessage));
          }

          return const Center(child: Text("No impact data available"));
        },
      ),
    );
  }
}