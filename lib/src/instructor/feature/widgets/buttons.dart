import 'package:flutter/material.dart';

class PrimaryButtonWithLoader extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool loading;
  const PrimaryButtonWithLoader({
    super.key,
    this.onTap,
    required this.title,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Material(
        color: Colors.grey,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: loading ? null : onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 16.0,
                          height: 16.0,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
