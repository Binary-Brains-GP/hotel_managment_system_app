import 'package:design_pattern/core/theming/colors.dart';
import 'package:design_pattern/core/theming/styles.dart';
import 'package:flutter/material.dart';

import '../../core/model/workers_model.dart';

class WorkersScreen extends StatefulWidget {
  @override
  _WorkersScreenState createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  List<Worker> workers = Worker.getPredefinedWorkers(); // List of workers
  List<Worker> filteredWorkers = []; // List for searching functionality
  String searchQuery = ''; // Query for the search functionality

  @override
  void initState() {
    super.initState();
    filteredWorkers = workers;
  }

  // Function to filter workers by name
  void _filterWorkers(String query) {
    setState(() {
      searchQuery = query;
      filteredWorkers = workers
          .where((worker) =>
          worker.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void _showWorkerDetailsDialog(BuildContext context, Worker worker) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(worker.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${worker.name}"),
            Text("Job Title: ${worker.role}"),
            Text("Salary: \$${worker.salary}"),
            Text("ContactNumber: \$${worker.contactNumber}"),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
  // Function to add a worker
  void _addWorker() {
    setState(() {
      workers.add(
        Worker(
          workerId: 'W107',
          name: 'New Worker',
          role: 'New Role',
          salary: 2000.0,
          contactNumber: '555-9999',
          isAvailable: true,
        ),
      );
      _filterWorkers(searchQuery); // Refresh the filtered list
    });
  }

  // Function to open the modal bottom sheet for editing the worker
  void _editWorker(Worker worker) {
    TextEditingController nameController = TextEditingController(text: worker.name);
    TextEditingController roleController = TextEditingController(text: worker.role);
    TextEditingController salaryController = TextEditingController(text: worker.salary.toString());
    TextEditingController contactNumberController = TextEditingController(text: worker.contactNumber.toString());


    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Edit Worker", style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Worker Name'),
              ),
              TextField(
                controller: roleController,
                decoration: InputDecoration(labelText: 'Role'),
              ),
              TextField(
                controller: salaryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Salary'),
              ),
              TextField(
                controller: contactNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'phonenumber'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Update the worker's details
                        worker.name = nameController.text;
                        worker.role = roleController.text;
                        worker.salary = double.tryParse(salaryController.text) ?? worker.salary;
                        _filterWorkers(searchQuery); // Refresh the filtered list
                      });
                      Navigator.pop(context); // Close the modal
                    },
                    child: Text("Save Changes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal without saving
                    },
                    child: Text("Cancel"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // Function to delete a worker
  void _deleteWorker(Worker worker) {
    setState(() {
      workers.remove(worker);
      _filterWorkers(searchQuery); // Refresh the filtered list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterWorkers,
              decoration: InputDecoration(
                labelText: 'Search by Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredWorkers.length,
              itemBuilder: (context, index) {
                final worker = filteredWorkers[index];
                return ListTile(
                  onLongPress: ()=> _showWorkerDetailsDialog(context,worker),
                  title: Text(worker.name,style: MyTextStyle.font20MainBrownRegular,),
                  subtitle: Text(worker.role),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.mode_edit_outline,color: MyColors.myBlack,),
                        onPressed: () => _editWorker(worker),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,color: Colors.red[700],),
                        onPressed: () => _deleteWorker(worker),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "da",
        onPressed: _addWorker,
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: MyColors.myLightBrown,
      ),
    );
  }
}
