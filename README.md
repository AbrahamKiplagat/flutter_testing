# Todo App

A Todo application to manage tasks efficiently.

## Features

- Add, edit, update and delete tasks
- Add, edit, Update and delete Notes
- Mark tasks as completed
- Categorize tasks
- Set due dates

## Installation

```sh
# Clone the repository
git clone https://github.com/abrahamkiplagat/to-do_list_notes_app.git
cd todo-app

# Install dependencies
npm install
flutter pub get


# Start the application
npm start
flutter run
```

## Usage

1. Open the application.
2. Create a new task by providing a title and optional details.
3. Mark tasks as completed when done.
4. Delete tasks that are no longer needed.

## Entity Relationship Diagram (ERD)

```mermaid
graph TD;
    User -->|creates| Task;
    Task -->|belongs to| Category;
    User -->|manages| Category;
    Task -->|has| DueDate;
```

## Technologies Used

- Frontend: Flutter responsive design 
- Backend: Flutter (Dinamic Advanced Robotic Technologies)
- Database: MongoDB / Postgress

## Contributing

1. Fork the repository.
2. Create a new branch (`feature-branch`).
3. Commit your changes.
4. Push to the branch and create a pull request.

## License

This project is licensed under the MIT License.
