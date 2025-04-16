import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/seller/home/models/carousel_blog_model.dart';

class BlogDetailScreen extends StatelessWidget {
  final CarouselBlogModel blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.title,
          style: kTitleStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kSecondaryColor,
              ),
              child: SvgPicture.asset(
                blog.imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              blog.title,
              style: kTitleStyle,
            ),
            const SizedBox(height: 10),
            Text(
              blog.description,
              style: kSubtitleStyle.copyWith(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            // Additional content based on the blog topic
            if (blog.title == 'Waste Segregation')
              _buildWasteSegregationContent()
            else if (blog.title == 'Impact of Waste on Environment')
              _buildWasteImpactContent()
            else if (blog.title == 'Waste Disposal Methods')
              _buildDisposalMethodsContent()
            else if (blog.title == 'Waste Management Hierarchy')
              _buildManagementHierarchyContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildWasteSegregationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Types of Waste',
          style: kTitle2Style,
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Biodegradable Waste: Food waste, garden waste, paper'),
        _buildBulletPoint('Non-biodegradable Waste: Plastic, metal, glass'),
        _buildBulletPoint('Hazardous Waste: Chemicals, batteries, electronic waste'),
        const SizedBox(height: 20),
        Text(
          'Benefits of Segregation',
          style: kTitle2Style,
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Reduces landfill waste'),
        _buildBulletPoint('Makes recycling easier'),
        _buildBulletPoint('Prevents contamination'),
        _buildBulletPoint('Reduces environmental impact'),
      ],
    );
  }

  Widget _buildWasteImpactContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Environmental Effects',
          style: kTitle2Style,
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Air pollution from burning waste'),
        _buildBulletPoint('Water contamination from landfill leachate'),
        _buildBulletPoint('Soil degradation'),
        _buildBulletPoint('Harm to wildlife'),
        const SizedBox(height: 20),
        Text(
          'Health Impacts',
          style: kTitle2Style,
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Respiratory problems'),
        _buildBulletPoint('Waterborne diseases'),
        _buildBulletPoint('Chemical exposure'),
      ],
    );
  }

  Widget _buildDisposalMethodsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modern Disposal Methods',
          style: kTitle2Style,
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Recycling: Converting waste into new products'),
        _buildBulletPoint('Composting: Organic waste decomposition'),
        _buildBulletPoint('Incineration: Controlled burning with energy recovery'),
        _buildBulletPoint('Landfilling: Safe disposal in engineered sites'),
        const SizedBox(height: 20),
        Text(
          'Best Practices',
          style: kTitle2Style,
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Reduce waste generation'),
        _buildBulletPoint('Reuse materials when possible'),
        _buildBulletPoint('Proper segregation at source'),
        _buildBulletPoint('Use authorized disposal facilities'),
      ],
    );
  }

  Widget _buildManagementHierarchyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hierarchy Levels',
          style: kTitle2Style,
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Prevention: Reduce waste generation'),
        _buildBulletPoint('Minimization: Reduce waste volume'),
        _buildBulletPoint('Reuse: Use items multiple times'),
        _buildBulletPoint('Recycling: Convert waste into new products'),
        _buildBulletPoint('Energy Recovery: Generate energy from waste'),
        _buildBulletPoint('Disposal: Safe final disposal'),
        const SizedBox(height: 20),
        Text(
          'Implementation Tips',
          style: kTitle2Style,
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Start with prevention'),
        _buildBulletPoint('Move down the hierarchy only when necessary'),
        _buildBulletPoint('Consider environmental impact at each step'),
        _buildBulletPoint('Monitor and improve continuously'),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: kSubtitleStyle),
          Expanded(
            child: Text(
              text,
              style: kSubtitleStyle,
            ),
          ),
        ],
      ),
    );
  }
} 