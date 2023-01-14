import 'package:avrod/constant/colors/colors.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sendByMe;
  const MessageTile({
    Key? key,
    required this.message,
    required this.sender,
    required this.sendByMe,
  }) : super(key: key);
  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: widget.sendByMe
          ? const EdgeInsets.only(
              top: 16,
              left: 35,
              right: 12,
            )
          : const EdgeInsets.only(
              top: 16,
              left: 12,
              right: 35,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: widget.sendByMe ? const Color(0xffE8FEDA) : Colors.white,
        borderRadius: widget.sendByMe
            ? const BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(12),
              )
            : const BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.sender.toUpperCase(),
            textAlign: TextAlign.start,
            style: const TextStyle(
              letterSpacing: -0.2,
              color: skipColor,
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            widget.message,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: titleColor,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
