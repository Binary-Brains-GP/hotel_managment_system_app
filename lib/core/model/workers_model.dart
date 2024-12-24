class Worker {
   String workerId; // Unique ID for the worker
   String name; // Full name of the worker
   String role; // Role or position (e.g., Manager, Receptionist)
   double salary; // Monthly salary of the worker
   String contactNumber; // Contact number
   bool isAvailable; // Availability status (e.g., on duty or off duty)

  Worker({
    required this.workerId,
    required this.name,
    required this.role,
    required this.salary,
    required this.contactNumber,
    required this.isAvailable,
  });

  // Static method to get a list of predefined workers
  static List<Worker> getPredefinedWorkers() {
    return [
      Worker(
        workerId: 'W101',
        name: 'John Smith',
        role: 'Manager',
        salary: 5.0,
        contactNumber: '555-1234',
        isAvailable: true,
      ),
      Worker(
        workerId: 'W102',
        name: 'Sarah Johnson',
        role: 'Receptionist',
        salary: 2.0,
        contactNumber: '555-5678',
        isAvailable: true,
      ),
      Worker(
        workerId: 'W103',
        name: 'Michael Brown',
        role: 'Chef',
        salary: 3.0,
        contactNumber: '555-9101',
        isAvailable: true,
      ),
      Worker(
        workerId: 'W104',
        name: 'Emily Davis',
        role: 'Housekeeper',
        salary: 2.0,
        contactNumber: '555-1122',
        isAvailable: false,
      ),
      Worker(
        workerId: 'W105',
        name: 'David Wilson',
        role: 'Security Guard',
        salary: 2.0,
        contactNumber: '555-3344',
        isAvailable: true,
      ),
      Worker(
        workerId: 'W106',
        name: 'Olivia Miller',
        role: 'Receptionist',
        salary: 3.0,
        contactNumber: '555-5566',
        isAvailable: false,
      ),
    ];
  }
}
