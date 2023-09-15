# Agino: Crop Cutting Date Estimation App

## Overview

Agino is a mobile application that assists farmers in knowing the cutting date of a crop based on Growing Degree Degree (GDD) calculations. The project uses mock sensor data for testing purposes and fetches weather data from the Met API for accurate GDD calculations. By providing valuable insights, Agino empowers farmers to optimize crop harvesting and improve their overall yield and quality. Clean Architecture is used both for the backend and the frontend.

## Features

- **User Authentication**: Users can securely create accounts and log in to access the app's features.

- **Location-Based Weather Data**: Agino utilizes the Met API to retrieve location-specific weather data for precise GDD calculations.

- **GDD Calculation**: The app calculates the Growing Degree Days (GDD) required based on the base temperature provided.

- **Cutting Date Estimation**: Based on GDD calculations, Agino estimates the ideal cutting date.

- **Mock Sensor Data**: For testing and development, Agino offers an option to use mock sensor data.

## Getting Started

### Prerequisites

Before getting started, make sure you have the following prerequisites installed:

- [.NET Core](https://dotnet.microsoft.com/download) for running the backend.
- [Flutter](https://flutter.dev/docs/get-started/install) for running the mobile app.

### Installation

1. **Clone the Repository**:

  ```bash
     git clone https://github.com/se348/AgiHelper.git
  ```

2. **Navigate to the Project Folder**:

  ```bash
    cd AgriHelper
  ```
3. **Set Up the Backend**:

   - Go to the backend directory:

  ```bash
    cd AgriHelper.Api
  ```
   - Restore the dependencies:

  ```bash
    dotnet restore
  ```
   - Run the backend server:

  ```bash
    dotnet run
  ```
3. **Set Up the Flutter App**:

   - Go to the flutter directory:

  ```bash
    cd ../agino_mobile
  ```
   - Install the Flutter packages:

  ```bash
    flutter pub get
  ```
   - Run the Flutter app:

  ```bash
    flutter run
  ```
4. **Open Agino**:
  Launch the Agino app on your device or simulator.

### Usage
1. **User Registration/Login**
2. **Create Farm**
3. **Create Field**
4. **Create Sensors**
5. **Send request to the Mock Data Recieved endpoint**


### Contributing
Contributions to Agino are encouraged and welcome! If you would like to contribute, please follow these guidelines:

  - Fork the repository.
  - Create a new branch for your feature or bug fix.
  - Implement your changes, ensuring that all tests pass.
  - Submit a pull request with a clear description of your changes.


### Contact
If you have any questions, suggestions, or feedback, please feel free to reach out to us at semir2578@gmail.com.

<div>
  <img src="https://github.com/se348/AgriHelper/assets/66954610/5c76c153-ac42-4c3e-9c3d-dbb2312416f7" width=250>
  <img src="https://github.com/se348/AgriHelper/assets/66954610/772e6b48-53f1-4f2d-9a0c-01967dd161c3" width=250>  
</div>

<div>
  <img src="https://github.com/se348/AgriHelper/assets/66954610/2fda469f-6f81-4bff-bba2-229a248461c3" width=250>
  <img src="https://github.com/se348/AgriHelper/assets/66954610/bb7179cd-b190-4e4d-a4ae-6caa437ccb97" width=250>
</div>

<div>
  <img src="https://github.com/se348/AgriHelper/assets/66954610/56d48387-435f-46ba-bac8-e310196f3d0d" width=250>
  <img src="https://github.com/se348/AgriHelper/assets/66954610/141e7c48-424b-48fd-b705-6651c1b53c37" width=250>
</div>
Happy farming with Agino! 🌱🚜
