/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool showBackButton;

  const CustomAppBar(
      {Key? key,
      required this.title,
      this.showBackButton = true,
      this.actions,
      this.backgroundColor})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ??
          Theme.of(context).colorScheme.inversePrimary,
      width: double.infinity,
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 4),
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
                  )),
            if (!widget.showBackButton)
              const SizedBox(
                width: 8,
              ),
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
    );
  }
}
