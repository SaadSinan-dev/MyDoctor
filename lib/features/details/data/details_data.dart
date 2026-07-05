class DetailsData {
  final String name;
  final String image;
  final String specialty;
  final double rating;
  final String description;
  final int experienceYears;
  final int patientsCount;
  final String location;

  const DetailsData({
    required this.name,
    required this.image,
    required this.specialty,
    required this.rating,
    required this.description,
    this.experienceYears = 5,
    this.patientsCount = 500,
    this.location = "City Medical Center",
  });
}

final List<DetailsData> detailsDatas = [
  const DetailsData(
    name: "Dr. Ahmed",
    image: "assets/images/doc1.png",
    specialty: "Cardiologist",
    rating: 4.8,
    description:
        "Dr. Ahmed is a highly experienced cardiologist specializing in the diagnosis "
        "and treatment of heart-related conditions. He is dedicated to providing "
        "personalized care and helping patients maintain a healthy heart through "
        "advanced treatment methods and preventive care.",
    experienceYears: 12,
    patientsCount: 2300,
    location: "Al-Amal Medical Center",
  ),
  const DetailsData(
    name: "Dr. Sara",
    image: "assets/images/doc2.png",
    specialty: "Dentist",
    rating: 4.6,
    description:
        "Dr. Sara is a skilled dentist with a passion for creating healthy, "
        "confident smiles. She specializes in cosmetic dentistry, root canal "
        "treatments, and general oral health care using the latest dental technology.",
    experienceYears: 8,
    patientsCount: 1500,
    location: "Smile Dental Clinic",
  ),
];
