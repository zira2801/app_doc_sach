
import 'package:app_doc_sach/util/responsive.dart';
import 'package:app_doc_sach/widgets/activity_details_card.dart';
import 'package:app_doc_sach/widgets/bad_graph_widget.dart';
import 'package:app_doc_sach/widgets/header_widget.dart';
import 'package:app_doc_sach/widgets/line_chart_card.dart';
import 'package:app_doc_sach/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SingleChildScrollView(child:Column(
          children: [
            const SizedBox(height: 18),
            const  HeaderWidget(),
            const SizedBox(height: 18),
            const ActivityDetailsCard(),
            const SizedBox(height: 18),
            const LineChartCard(),
            const SizedBox(height: 18),
            const BarGraphCard(),
            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const SummaryWidget(),
          ],
        ), 
      ),
    );
  }
}
