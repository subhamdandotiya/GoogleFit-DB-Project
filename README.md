# Google Fit Database Project

## Overview
The **Google Fit Database Project** replicates the functionalities of Google Fit by creating a robust relational database to manage and analyze user health and fitness data. This project organizes diverse health metrics such as sleep, activity, nutrition, and more into an efficient schema, making it ideal for fitness tracking and analysis applications.

---

## Features

### 1. **Sleep Tracking**
- Logs sleep duration and REM sleep patterns for users.

### 2. **Health Recommendations**
- Provides personalized coaching plans and future workout recommendations.
- Stores American Heart Association (AHA) recommendations.

### 3. **Activity Monitoring**
- Records exercise type, steps, distance, heart points, and calorie expenditure.

### 4. **Nutrition Management**
- Tracks calorie count and hydration intake.

### 5. **Body Measurements**
- Captures height, weight, and body fat percentage.

### 6. **Vitals Tracking**
- Logs heart rate and blood pressure readings.

### 7. **Goal Setting and Notifications**
- Enables users to set fitness goals such as step goals and heart points.
- Sends notifications tied to goals and recommendations.

### 8. **User Profiles**
- Maintains user information including name, gender, birthdate, and linked devices.

---

## Database Schema
The database is structured into multiple interrelated tables:

- **Sleep**: Tracks user sleep data.
- **Recommendation**: Stores personalized health suggestions.
- **Cycle**: Represents health tracking cycles.
- **Coaching Plan**: Contains workout plans and feedback.
- **Health Log**: Central table linking other health-related data.
- **Profile**: Stores user profile information.
- **Body Measurement**: Tracks height, weight, and body fat.
- **Goal**: Manages user-set fitness goals.
- **Nutrition Log**: Records daily nutrition details.
- **Notification**: Manages reminders for goals and recommendations.
- **Device**: Links user devices with location information.
- **Vital**: Captures vital health statistics.
- **Activity**: Logs physical activities and related metrics.

---

## How to Use

1. **Set Up Database**:
   - Create a MySQL or compatible database.
   - Use the provided SQL scripts to create the tables and relationships.

2. **Insert Sample Data**:
   - Populate the tables with sample data for testing purposes.

3. **Query the Database**:
   - Perform SQL queries to extract, analyze, and visualize user health data.

4. **Integrate with Applications**:
   - Connect the database to a frontend application for dynamic interaction.

---

## Requirements

- **Database**: MySQL or any relational database.
- **Languages**: SQL for schema creation and queries.
- **Tools**: Database client (e.g., MySQL Workbench, phpMyAdmin).

---

## Future Enhancements

- Add support for advanced analytics and machine learning integration.
- Develop a frontend to visualize user data in real-time.
- Enable API integrations with wearable devices.

---

## License
This project is licensed under the MIT License.

---

## Contribution
Contributions are welcome! Feel free to fork this repository, make changes, and submit a pull request.

---

## Contact
For any queries or suggestions, please contact [Subham](mailto:subhamdandotiya96@gmail.com).
