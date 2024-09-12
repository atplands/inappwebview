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
      imageUrl: 'https://itrefaicloud.onrender.com/static/assets2/images/1.jpg',
      title: 'A Cool Way to Referrence',
      description:
          'Business Transction Receipts, Supplier Invoices, Customer Bills, Credit and Cash details could be stored in his Google Accounts. DashBoard shows entire business data. Purchases and Sales transaction details can be displayed by the filter based on daily or date range. Sales Price List, Purchase Orders List and Sales Orders List.'),
  Slide(
      imageUrl: 'https://itrefaicloud.onrender.com/static/assets2/images/2.jpg',
      title: 'Certfications Dashboard ',
      description:
          'Customers Transction Bills could be Managed. Suppliers Credit and Cash GUI Dashboard. Suppliers Photos, Contacts and Its Transaction Invoices could be Manged. Display the details with Filter based on the Name, Type and Daterange.'),
  Slide(
      imageUrl: 'https://itrefaicloud.onrender.com/static/assets2/images/3.jpg',
      title: 'Addons Video Dashboard',
      description:
          'Suppliers Transction Bills could be Managed. Suppliers Credit and Cash GUI Dashboard. Suppliers Photos, Contacts and Its Transaction Invoices could be Manged. Display the details with Filter based on the Name, Type and Daterange.'),
];
