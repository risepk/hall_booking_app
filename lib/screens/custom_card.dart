import 'package:flutter/material.dart';

class CustomEventCard extends StatelessWidget {
  late final String hallName;
  late final String address;
  late final int capacity;
  late final String contactNo;
  late final String picture;

  CustomEventCard({
    required this.hallName,
    required this.address,
    required this.capacity,
    required this.contactNo,
    required this.picture,
});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lime[200],
      elevation: 5,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green),
            child: Image.asset(picture),
          ),
          Text(
            hallName,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.green,
              ),
              Text(
                address,
                style: TextStyle(
                    fontSize: 18, color: Colors.green),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.reduce_capacity,
                color: Colors.blue,
              ),
              Text(
                capacity.toString(),
                style:
                TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Book"),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text("More Details")),
            ],
          )
        ],
      ),
    );
  }
}