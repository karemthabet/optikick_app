class InfoCardModel {
  final String imagePath;
  final String title;
  final String description;

  InfoCardModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

final List<InfoCardModel> infoCards = [
  InfoCardModel(
    imagePath: 'assets/images/hand.png',
    title: 'Handwashing Can\nProtect Your Health',
    description: 'Why it matters and tips for how to do it well.',
  ),
  InfoCardModel(
    imagePath: 'assets/images/mental.png',
    title: 'Common Concerns\nAbout Mental Health',
    description: 'Learn about common mental health conditions.',
  ),
  InfoCardModel(
    imagePath: 'assets/images/vits.png',
    title: 'Understanding Your Vitals',
    description:
        'Certain metrics can give you a sense of how the body is doing.',
  ),
  InfoCardModel(
    imagePath: 'assets/images/sleep.png',
    title: 'Why Sleep Is So Important',
    description: 'Learn about how sleep helps the body.',
  ),
];
