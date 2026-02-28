/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:flutter/material.dart';

class TrAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool showBackButton;

  const TrAppBar(
      {super.key,
      required this.title,
      this.showBackButton = true,
      this.actions,
      this.backgroundColor});

  @override
  State<TrAppBar> createState() => _TrAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TrAppBarState extends State<TrAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: widget.backgroundColor ?? Theme.of(context).colorScheme.primary,
        width: double.infinity,
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (widget.showBackButton)
                IconButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 22,
                      color: Colors.white,
                    ))
              else
                const SizedBox(),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              if (widget.actions != null && widget.actions!.isNotEmpty)
                Row(
                  children: widget.actions!,
                )
            ],
          ),
        ),
      ),
    );
  }
}
