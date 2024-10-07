class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
      imageUrl: 'https://cloudaiorg.com/static/assets2/images/1.jpg',
      title: 'A Cool Way to Referrence',
      description:
          'Elevate your IT career: Job support, referrals, mock interviews, and certifications – all in one app. An It Professional referrence among IT gaints to support each and grow an organisation.'),
  Slide(
      imageUrl: 'https://cloudaiorg.com/static/assets2/images/2.jpg',
      title: 'Certfications Dashboard ',
      description:
          '"Master global IT certifications: From Azure to AWS, GCP to Oracle – elevate your expertise and career potential.'),
  Slide(
      imageUrl: 'https://cloudaiorg.com/static/assets2/images/3.jpg',
      title: 'Addons Video Dashboard',
      description:
          'Comprehensive IT career support: From resume building to startup planning – your one-stop app for professional growth.'),
];
