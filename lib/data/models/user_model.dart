class User {
    final String id;
    final String phoneNumber;
    // Add other relevant fields

    User({required this.id, required this.phoneNumber});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            id: json['id'],
            phoneNumber: json['phone_number'],
            // Map other fields
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'id': id,
            'phone_number': phoneNumber,
            // Other fields
        };
    }
}