# Healthcare Billing Validator

## 📌 Project Overview
The **Healthcare Billing Validator** is a Python-based application that connects with a MySQL database to validate whether medical services are covered under CMS (Centers for Medicare & Medicaid Services) guidelines. This project is designed to assist healthcare providers in managing patient records, hospital services, and insurance coverage.

## 🛠️ Tech Stack
- **Programming Language:** Python
- **Database:** MySQL
- **GUI Framework:** Tkinter
- **Data Processing:** Pandas
- **SQL Connector:** MySQL Connector for Python

## 📂 Features
✅ **Database Integration:** Connects to a MySQL database to fetch and validate patient records, medical services, and insurance details.  
✅ **Service Coverage Validation:** Determines whether a medical service is covered or non-covered under CMS guidelines.  
✅ **User-Friendly GUI:** Tkinter-based frontend to allow users to fetch patient details and service coverage information.  
✅ **SQL Query Execution:** Uses optimized SQL queries for retrieving and managing healthcare data.  
✅ **Error Handling & Debugging:** Built-in exception handling for smooth database operations.  

## 🏗️ Database Schema
The MySQL database consists of the following tables:
- **Patient:** Stores patient details like name, DOB, gender, and contact info.
- **Hospital:** Contains hospital names and contact details.
- **Medical_Service:** Records medical services provided to patients, along with coverage status.
- **Insurance:** Stores patient insurance provider details and policy coverage.
- **Valid_Services:** Defines CMS-approved services for validation.

## 🔧 Setup & Installation
### 1️⃣ Prerequisites
Ensure you have the following installed:
- Python (>=3.8)
- MySQL Server
- MySQL Connector for Python
- Pandas

### 2️⃣ Clone the Repository
```bash
git clone https://github.com/your-repo/healthcare-billing-validator.git
cd healthcare-billing-validator
```

### 3️⃣ Install Dependencies
```bash
pip install mysql-connector-python pandas
```

### 4️⃣ Set Up MySQL Database
- Import the provided **AR.sql** script to create the required database and tables.
- Update the database credentials in `config.py`.

### 5️⃣ Run the Application
```bash
python healthcare_app.py
```

## 📌 Usage Guide
1. **Launch the Application**: The Tkinter GUI will open.
2. **Enter Patient ID**: Retrieve patient details, hospital visits, and insurance coverage.
3. **Check Service Coverage**: Validate if a medical service is covered under CMS.
4. **Update Records**: Modify patient status and service details using SQL queries.

## 🚀 Future Enhancements
🔹 Implement Flask or Django for a web-based frontend.  
🔹 Integrate real-time API for CMS coverage updates.  
🔹 Add authentication and role-based access control.  

## 🤝 Contributing
Feel free to contribute by submitting pull requests. For major changes, please open an issue first to discuss your ideas.

## 📝 License
This project is licensed under the MIT License.

---

🎯 **Developed by Moses** | 💡 *A project to simplify healthcare billing validation*

