### Project Overview

This project is a Flutter-based mobile application designed to display a list of posts, with features for creating, updating, and deleting posts. The application fetches data from a RESTful API and provides a user-friendly interface with a modern, aesthetically pleasing design. Key features include:

- **List of Posts**: A scrollable list displaying all posts with support for pagination (load more as you scroll).
- **Post Details**: A detailed view of each post with an enhanced UI.
- **Create/Update Post**: A bottom sheet form for creating or updating posts, with user input fields and smooth UI transitions.
- **Delete Post**: A confirmation dialog for deleting posts.
- **Pull to Refresh**: Allows users to refresh the post list by pulling down.

### Demo

![Demo of the App](assets/demo.gif)

### Sample API

The application interacts with the following API routes provided by [JSONPlaceholder](https://jsonplaceholder.typicode.com/):

- **GET List of Posts**: Retrieves a list of posts.
    - Endpoint: `GET https://jsonplaceholder.typicode.com/posts`
- **GET Post by ID**: Retrieves the details of a specific post by its ID.
    - Endpoint: `GET https://jsonplaceholder.typicode.com/posts/1`
- **Create Post**: Creates a new post.
    - Endpoint: `POST https://jsonplaceholder.typicode.com/posts`
- **Delete Post**: Deletes a specific post by its ID.
    - Endpoint: `DELETE https://jsonplaceholder.typicode.com/posts/1`
- **Update Post**: Updates a specific post by its ID.
    - Endpoint: `PUT https://jsonplaceholder.typicode.com/posts/1`

### Dependencies

The project uses the following dependencies:

- **`dio`** (`^5.3.3`): A powerful HTTP client for Dart, which is used to make network requests to the API. It's easy to use and supports interceptors, global configuration, and more.
- **`pretty_dio_logger`** (`^1.3.1`): A logging interceptor for Dio, which is used to log network requests and responses for debugging purposes.
- **`provider`** (`^6.0.0`): A state management library used to manage the application's state in a clean and scalable way.
- **`flutter_dotenv`** (`^5.1.0`): A library to load environment variables from a `.env` file, useful for configuring API endpoints or other environment-specific settings.
- **`equatable`** (`^2.0.5`): A helper library that makes it easier to compare objects in Dart, particularly useful for state management in Flutter.
- **`dartz`** (`^0.10.1`): A functional programming library for Dart, used in the project for handling operations like error handling, option types, etc.
- **`get_it`** (`^7.6.4`): A service locator for dependency injection, used to manage dependencies and make the code more modular and testable.
- **`chucker_flutter`**  (`^1.0.1`): An HTTP inspector for Flutter, integrated with Dio to log and visualize HTTP requests and responses directly within your app.
---

### How to Run the Project

Follow these steps to set up and run the project on your local machine:

1. **Clone the Repository**:
    - First, clone the repository to your local machine using the following command:
      ```sh
      git clone https://github.com/yourusername/yourproject.git
      ```
    - Navigate to the project directory:
      ```sh
      cd yourproject
      ```

2. **Install Dependencies**:
    - Ensure that you have Flutter installed on your machine. If not, follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
    - Install the necessary dependencies by running:
      ```sh
      flutter pub get
      ```

3. **Create the `.env` File**:
    - Create a `.env` file in the root directory of your project. This file is used to store environment variables like API URLs.
    - Example content for the `.env` file:
      ```sh
      API_BASE_URL=https://jsonplaceholder.typicode.com/
      ```
    - Ensure that the `.env` file is included in your `.gitignore` to avoid committing sensitive information.

4. **Run the Application**:
    - To run the application on an emulator or a physical device, execute the following command:
      ```sh
      flutter run
      ```
    - Ensure that you have an emulator running or a physical device connected. You can check connected devices by running:
      ```sh
      flutter devices
      ```
