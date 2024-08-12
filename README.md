# Lucid Logs

Lucid Logs is a Flutter-based dream journaling application that allows users to log and analyze their dreams. It integrates with an AI backend to provide insightful analyses of logged dreams, helping users understand patterns, feelings, and other aspects of their dreams. The app also includes a statistics page to visualize dream patterns and trends.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
- [Usage](#usage)
- [Future Goals](#future-goals)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Lucid Logs is designed to help users track, analyze, and gain insights into their dreams. The application leverages AI to provide analyses of dream content and includes features such as tagging, categorizing, and visualizing dream data through a comprehensive statistics page.

## Features

- **Dream Logging**: Easily log your dreams with descriptions, tags, feelings, and more.
- **AI Analysis**: Get AI-driven insights and analyses on your dreams directly within the app.
- **Lucid Dream Tracking**: Mark dreams as lucid and analyze patterns related to lucid dreaming.
- **Tags and Categories**: Organize your dreams with tags and categories for better tracking.
- **Statistics Page**: Visualize dream patterns, most common feelings, tag usage, and more with charts and graphs.
- **Themes**: Supports light and dark themes with a modern, clean UI.
- **Offline Storage**: Dreams are stored locally on your device using the Isar database.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.22.3 or higher)
- [Dart SDK](https://dart.dev/get-dart) (version 3.4.4 or higher)
- A code editor, such as [Visual Studio Code](https://code.visualstudio.com/)

### Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/yourusername/lucidlogs.git
    cd lucidlogs
    ```

2. **Install dependencies:**
    ```sh
    flutter pub get
    ```

3. **Set up environment variables:**

    Create a `.env` file in the root directory of your project and add your API keys and backend URL:

    ```env
    API_KEY=your_api_key_here
    BACKEND_URL=https://your-backend-url.com/chat/completions
    ```

4. **Run the application:**
    ```sh
    flutter run
    ```

## Usage

1. **Log a Dream**: Tap on the floating action button to log a new dream. You can provide a description, tags, feelings, and mark it as a lucid dream.
2. **Analyze a Dream**: Use the "Analyze Dream with AI" button to get an AI analysis of your dream.
3. **View Dream Details**: Tap on any dream in the list to view its details, including AI analysis, tags, and other metadata.
4. **View Dream Stats**: Access the statistics page to visualize patterns and trends in your dream data, such as the most common feelings, tag usage, and the number of dreams per day.

## Project Structure

```plaintext
lib/
│
├── components/
│   ├── drawer.dart        # Custom drawer component
│   └── dream_tile.dart    # Dream list tile widget
├── models/
│   ├── dream.dart         # Dream model class
│   └── dream_db.dart      # Database management using Isar
├── screens/
│   ├── create_dream.dart  # Screen for creating and logging dreams
│   ├── dreams_page.dart   # Main screen listing all dreams
│   └── one_dream.dart     # Screen showing detailed information about a dream .. other screens listed in folder
├── theme/
│   ├── theme.dart         # Custom themes for the application
│   └── theme_provider.dart # Theme provider for managing light and dark modes
└── main.dart              # Entry point of the application