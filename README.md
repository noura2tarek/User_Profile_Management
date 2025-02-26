# **User Profile Management**

# Description
A Flutter application for managing user profiles.                                
This app allows you to:                    
- View a list of users.
- Add new users.
- Edit existing users.
- Delete users.
- Show profile screen of selected user.
- Work offline with data persistence using SharedPreferences.

-----------------

## **Features**
1. **HomeScreen**:
   - View a list of users with their name, email, and profile picture.
   - Pull-to-refresh to reload the list. 

2. **Add/Edit User**:
   - Add a new user with details like name, username, email, phone, and website.
   - Edit existing user details.

3. **Delete User**:
   - Delete a user from the list.

4. **Offline Support**:
   - Data is saved locally using SharedPreferences when offline.
   - Synced with the server when the app comes online.

5. **Responsive Design**:
   - The UI adapts to different screen sizes .

6. **Validations**:
   - Input fields are validated for proper formatting.

7.  **Url Launcher**:
   - url launcher added for email and phone in profile screen.

---------------------------------------

## App Structure
The code is organized using **MVC Architecture** for clean and maintainable code structure.                   
The main folders in lib are:
- **controller**: contains controllers which deal with presentaion layer to handle logic (api_service and profile controller).
- **model**: define the data models (user model).
- **view**: UI design and components (screens and widgets).

--------------------------------------------

## How to Run

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the app.

----------------------------

## **Packages Used**
- **Dio**: For making HTTP requests to the API ==> https://pub.dev/packages/dio.
- **SharedPreferences**: For local data storage and offline support ==> https://pub.dev/packages/shared_preferences.
- **fluttertoast** : To show toast in success or fail ==> https://pub.dev/packages/fluttertoast.
- **url_launcher** : For launching a URL (Email or phone) ==> https://pub.dev/packages/url_launcher.
- **MVC Architecture**: For clean and maintainable code structure.

  


