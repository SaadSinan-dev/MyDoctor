class Doctor {
  final String name;
  final String image;
  final String specialty;
  final double rating;

  const Doctor({
    required this.name,
    required this.image,
    required this.specialty,
    required this.rating,
  });
}

final List<Doctor> doctors = [
  const Doctor(
    name: "Dr. Ahmed",
    image: "assets/images/doc1.png",
    specialty: "Cardiologist",
    rating: 4.8,
  ),
  const Doctor(
    name: "Dr. Sara",
    image: "assets/images/doc2.png",
    specialty: "Dentist",
    rating: 4.6,
  ),
];
