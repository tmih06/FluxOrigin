import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class HistoryItem {
  final String fileName;
  final String timeRange;

  const HistoryItem({
    required this.fileName,
    required this.timeRange,
  });
}

const List<HistoryItem> MOCK_HISTORY = [
  HistoryItem(
    fileName: "Business_Proposal_v2.docx",
    timeRange: "14:20 - 14:25",
  ),
  HistoryItem(
    fileName: "User_Manual_JP.pdf",
    timeRange: "10:00 - 10:15",
  ),
  HistoryItem(
    fileName: "Marketing_Strategy_2025.pptx",
    timeRange: "09:30 - 09:45",
  ),
  HistoryItem(
    fileName: "Financial_Report_Q4.xlsx",
    timeRange: "16:00 - 16:30",
  ),
  HistoryItem(
    fileName: "Project_Specs_2025.pdf",
    timeRange: "09:30 - 09:35",
  ),
  HistoryItem(
    fileName: "Meeting_Notes_Dec.txt",
    timeRange: "11:15 - 11:20",
  ),
];

class HistoryScreen extends StatefulWidget {
  final bool isDark;

  const HistoryScreen({super.key, required this.isDark});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Lịch sử dịch thuật',
            style: GoogleFonts.merriweather(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: widget.isDark ? Colors.white : AppColors.lightPrimary,
            ),
          ),

          const SizedBox(height: 24),

          // List of history items
          Expanded(
            child: ListView.separated(
              itemCount: MOCK_HISTORY.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _HistoryCard(
                isDark: widget.isDark,
                item: MOCK_HISTORY[index],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}

class _HistoryCard extends StatefulWidget {
  final bool isDark;
  final HistoryItem item;

  const _HistoryCard({
    required this.isDark,
    required this.item,
  });

  @override
  State<_HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<_HistoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? (widget.isDark
                    ? Colors.white.withOpacity(0.5)
                    : AppColors.lightPrimary.withOpacity(0.5))
                : (widget.isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(widget.isDark ? 0.3 : 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Icon (Left)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.isDark
                    ? Colors.white.withOpacity(0.1)
                    : AppColors.lightPrimary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.fileLines,
                  size: 18,
                  color: widget.isDark ? Colors.white : AppColors.lightPrimary,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Filename (Middle - Expanded)
            Expanded(
              child: Text(
                widget.item.fileName,
                style: GoogleFonts.merriweather(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: widget.isDark ? Colors.white : AppColors.lightPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(width: 16),

            // Time Range (Right)
            Text(
              widget.item.timeRange,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: widget.isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
