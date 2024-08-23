# 📝 How to contribute

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

# 🛠️ Building from source

Learn how to build Mindful from source.

1. Setup the Flutter environment for your [platform](https://docs.flutter.dev/get-started/install)

2. Clone the repository

   ```sh
   git clone https://github.com/akaMrNagar/Mindful.git && cd mindful
   ```

3. Get dependencies

   ```sh
   flutter pub get
   ```

4. Generate temporary files

   ```sh
   dart run build_runner build -d
   ```

5. Build the APK

   ```sh
   flutter build apk
   ```
