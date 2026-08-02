import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  NoInternet({super.key, required this.isNetworkError, required this.refetch});

  final bool isNetworkError;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () => refetch?.call(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    isNetworkError ? 'No internet.' : 'An error occurred; try again.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}