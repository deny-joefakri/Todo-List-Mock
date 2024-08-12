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

### Key Components

1. **PostListPage**:
    - Displays a list of posts.
    - Supports loading more posts as the user scrolls to the bottom.
    - Provides a floating action button to add new posts.
    - Each post item is styled with a card layout and includes options to update or delete the post.

2. **PostListItem**:
    - Represents an individual post in the list.
    - Styled with a `Card` widget with a teal background at 20% opacity.
    - Includes a popup menu for update and delete actions.
    - Handles user interactions such as tapping to view details or perform actions.

3. **DetailPostPage**:
    - Shows the details of a selected post in a structured and visually appealing layout.
    - Utilizes a header with the post title and a card to display the post content.

4. **CreateScreen**:
    - A bottom sheet form used for creating or updating posts.
    - Includes text fields for the title and body of the post.
    - The UI is styled with rounded corners, input field decorations, and a teal color scheme.

5. **ViewModels**:
    - **PostListViewModel**: Manages the state of the post list, including fetching posts, handling pagination, and managing loading states.
    - **DetailPostViewModel**: Manages the state of the post detail page, including fetching the details of a specific post.
    - **CreateViewModel**: Manages the state for creating or updating a post, including form submission and handling loading states.

### Design and Styling

- **Teal Color Scheme**: The application uses a consistent teal color scheme with various elements such as buttons, app bars, and backgrounds using different shades of teal.
- **Cards and Shadows**: Posts are displayed in `Card` widgets with rounded corners and shadows to create a clean, modern look.
- **Responsive UI**: The layout is responsive, with bottom sheets and dialogs that adjust based on the device’s screen size and keyboard visibility.

### How to Run the Project

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/yourusername/yourproject.git
2.	**Install Dependencies**:
Navigate to the project directory and run:
    ```sh
   flutter pub get

3.	**Create .env File**:
Create a .env file in the root of your project to store environment variables like API URLs.
Example .env:
API_BASE_URL=https://jsonplaceholder.typicode.com/

4.	Run the Application:
      To run the application on an emulator or a physical device, use:
      flutter run