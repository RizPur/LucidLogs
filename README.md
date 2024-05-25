# Lucid Logs

Lucid Logs is a Flutter application designed to help users track their dreams, analyze them using AI, and create visual representations of the dreams. This README outlines the current state of the project, including setup instructions, features, and future goals.

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

Lucid Logs aims to provide a platform for users to log their dreams, receive AI-driven analyses, and generate visual images of their dreams. The project is currently in its early stages, with Firebase integration and user authentication as the primary features implemented so far.

## Features

- **User Authentication**: Users can register and log in to their accounts.
- **Firebase Integration**: The app uses Firebase for backend services.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A code editor, such as [Visual Studio Code](https://code.visualstudio.com/)

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/lucidlogs.git
   cd lucidlogs

2. **Install dependencies**
    ```bash
    flutter pub get

3. **Set up Firebase**

- Create a new Firebase project in the Firebase Console.
- Add an Android app to your Firebase project.
- Download the google-services.json file and place it in the android/app directory.
- Enable Firebase Authentication in the Firebase Console.

## Future Goals

- Dream Logging: Allow users to log their dreams with detailed descriptions.
- AI Analysis: Integrate AI services to analyze the logged dreams and provide insights.
- Image Generation: Use AI to generate visual representations of the dreams based on user descriptions.
- Enhanced User Interface: Improve the UI/UX for a seamless user experience.
- Dream Sharing: Enable users to share their dreams and analyses with others.

## License

This project is licensed under the MIT License.