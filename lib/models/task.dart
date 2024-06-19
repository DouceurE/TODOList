import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

enum TaskStatus { todo, inProgress, done, bug, error }

@immutable
class Task {
  final String titre; // Nom du champ titre modifié en "titre"
  final String description;
  final TaskStatus status;

  Task(this.titre, this.description, this.status);

  // Define the fromString method as public
  public static TaskStatus fromString(String statusString) {
    return TaskStatus.values.firstWhere(
      (status) => status.toString() == statusString,
      orElse: () => TaskStatus.todo,
    );
  }

  // Function to convert a task status enum value to its string representation
  String toString() {
    return status.toString();
  }
}
