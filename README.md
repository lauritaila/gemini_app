# 📱 Gemini AI Flutter App

This is a modern Flutter application that serves as a frontend to the Gemini AI backend (NestJS). It leverages Google's Gemini AI to provide advanced features such as streaming chat, multimodal interactions (text + images), and a playground for image generation and editing.

The app uses Riverpod with code generation for robust state management and follows a clean architecture pattern.

## Features

- **Basic Prompt:** Simple interactions with the Gemini Flash model.
- **Contextual Chat:** Full chat experience that preserves conversation history and context, using `flutter_chat_ui` for a premium interface.
- **Image Playground:** Generate and edit images with a grid-based history of generated content.
- **Multimodal Support:** Pick images from gallery or camera to be used as context in AI requests.
- **Realtime Feedback:** Visual indicators (typing effects and loading states) while the AI processes requests.

## Requirements

- **Flutter SDK:** ^3.8.1
- **Gemini Backend (NestJS):** Make sure the backend is running. The backend repository is available at: https://github.com/lauritaila/gemini-backend
- **API URL:** Access to your backend endpoint (local or hosted).

## Installation

1. Clone the repository:

```bash
git clone https://github.com/lauritaila/gemini_app.git
cd gemini_app
```

2. Environment configuration:

- Create a `.env` file in the project root (ensure it matches the assets definition in `pubspec.yaml`):

```
ENDPOINT_API=http://your-backend-ip:3000/api
```

3. Install dependencies:

```bash
flutter pub get
```

4. Generate Riverpod classes (build runner):

```bash
dart run build_runner build --delete-conflicting-outputs
# Or to watch for changes during development:
dart run build_runner watch
```

5. Run the app:

```bash
flutter run
```

## Project Structure

The project is organized in layers to separate configuration, business logic (providers), and UI:

```
lib/
 ┣ config/
 ┃ ┣ gemini_impl.dart      # API implementation and Dio configuration
 ┃ ┣ app_router.dart       # GoRouter definitions
 ┃ ┗ app_theme.dart        # Material 3 theme configuration
 ┣ presentation/
 ┃ ┣ providers/            # Riverpod providers (state management)
 ┃ ┃ ┣ chat/               # Chat state and message logic
 ┃ ┃ ┣ image/              # Image generation and history state
 ┃ ┃ ┗ users/              # User identity management
 ┃ ┣ screens/              # Main UI screens
 ┃ ┗ widgets/              # Reusable UI components
 ┗ main.dart               # Entry point with ProviderScope
```

## Key Dependencies

- **State:** `flutter_riverpod`, `riverpod_annotation`
- **Navigation:** `go_router`
- **Network:** `dio` (for HTTP requests to the NestJS backend)
- **Chat UI:** `flutter_chat_ui`, `flutter_chat_types`
- **Utilities:** `uuid`, `image_picker`, `flutter_dotenv`, `path_provider`

## Contributing

Contributions are welcome! If you find a bug or have a suggestion for a new Gemini use case, please open an issue or submit a pull request.

