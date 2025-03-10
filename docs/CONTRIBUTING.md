# 📝 How to Contribute

### 1. Open an Issue:

- Before contributing, please open an issue to discuss your proposed changes or feature implementation. This step ensures that your contribution aligns with the project’s goals and that your efforts are necessary and valued.

### 2. Branching Strategy:

- Development occurs on the `dev` branch. Please fork the repository and create your branch from `dev`.

### 3. Make Changes:

- Implement your changes and commit them to your branch.

### 4. Submit a Pull Request:

- Once your changes are ready, submit a pull request to the `dev` branch of the repository. Be sure to reference any issues that your pull request addresses in the description.

### 5. Review and Merge:

- Your pull request will be reviewed, and feedback will be provided. Upon approval, your pull request will be merged into the `dev` branch and included in the next release of Mindful.

---

# 🛠️ Building from Source

Learn how to build Mindful from source.

## Prerequisites

1. **Set Up Flutter Environment**:

   - Follow the official Flutter installation guide for your platform: [Flutter Installation Guide](https://docs.flutter.dev/get-started/install).

2. **Update Flutter JDK to Version 17**:

   - Flutter requires JDK 17 for Android development. Set the JDK path using the following command:
     ```bash
     flutter config --jdk-dir=<path/to/jdk17>
     ```
   - Example for Linux:
     ```bash
     flutter config --jdk-dir=/usr/lib/jvm/java-17-openjdk
     ```
   - Example for Windows:
     ```bash
     flutter config --jdk-dir="C:\Program Files\Java\jdk-17"
     ```

3. **Clone the Repository**:

   ```bash
   git clone https://github.com/akaMrNagar/Mindful.git && cd Mindful
   ```

4. **Get Dependencies**:

   ```bash
   flutter pub get
   ```

5. **Generate Temporary Files**:
   ```bash
   dart run build_runner build -d
   ```

---

## Generating a Keystore

To build the app in release mode, you need a keystore. Follow these steps to generate one:

### For Linux/macOS:

1. Create a temporary directory inside the project:

   ```bash
   mkdir -p temp
   ```

2. Generate the keystore inside the `temp` folder:

   ```bash
   keytool -genkey -v -keystore temp/mindful.jks -keyalg RSA -keysize 2048 -validity 10000 -alias mindful
   ```

   - You will be prompted to enter a **keystore password**, **key password**, and other details.

3. Set the keystore file permissions:
   ```bash
   chmod 600 temp/mindful.jks
   ```

### For Windows:

1. Create a temporary folder inside the project:

   ```batch
   mkdir temp
   ```

2. Generate the keystore inside the `temp` folder:
   ```batch
   keytool -genkey -v -keystore temp\mindful.jks -keyalg RSA -keysize 2048 -validity 10000 -alias mindful
   ```
   - You will be prompted to enter a **keystore password**, **key password**, and other details.

---

## Setting Environment Variables

To use the keystore during the build process, set the following environment variables:

### For Linux/macOS:

1. Create a script file in `temp` (e.g., `temp/keystore.sh`):

   ```bash
   #!/bin/bash

   export KEYSTORE_FILE="$(pwd)/temp/mindful.jks"
   export STORE_PASSWORD="your_keystore_password"
   export KEY_ALIAS="mindful"
   export KEY_PASSWORD="your_key_password"

   echo "KEYSTORE_FILE: $KEYSTORE_FILE"
   echo "STORE_PASSWORD: $STORE_PASSWORD"
   echo "KEY_ALIAS: $KEY_ALIAS"
   echo "KEY_PASSWORD: $KEY_PASSWORD"
   ```

2. Make the script executable:

   ```bash
   chmod +x temp/keystore.sh
   ```

3. Source the script before building the app:
   ```bash
   source temp/keystore.sh
   ```

### For Windows:

1. Create a batch file in `temp` (e.g., `temp/keystore.bat`):

   ```batch
   @echo off
   set KEYSTORE_FILE=%CD%\temp\mindful.jks
   set STORE_PASSWORD=your_keystore_password
   set KEY_ALIAS=mindful
   set KEY_PASSWORD=your_key_password

   echo KEYSTORE_FILE: %KEYSTORE_FILE%
   echo STORE_PASSWORD: %STORE_PASSWORD%
   echo KEY_ALIAS: %KEY_ALIAS%
   echo KEY_PASSWORD: %KEY_PASSWORD%
   ```

2. Run the batch file before building the app:
   ```batch
   temp\keystore.bat
   ```

**Note:** The `temp/` directory is ignored by Git to ensure sensitive files like keystores and environment scripts are not accidentally committed.

## Building the APK

1. Build the APK in release mode:

   ```bash
   flutter build apk --release
   ```

2. The APK will be generated at:
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

---

## Troubleshooting

- **Missing `storeFile` Error**:
  Ensure the `KEYSTORE_FILE` environment variable is correctly set and points to a valid keystore file.

- **JDK Version Issues**:
  Verify that the JDK version is set to 17:

  ```bash
  flutter doctor -v
  ```

- **Environment Variables Not Available**:
  Ensure the environment variables are set in the same terminal where you run the build command.

---

By following these steps, you can successfully set up the project, generate a keystore, and build Mindful from source. Let us know if you encounter any issues! 😊
