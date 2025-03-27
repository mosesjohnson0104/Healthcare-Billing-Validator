import tkinter as tk
from tkinter import messagebox, ttk
import mysql.connector

# MySQL Connection
db = mysql.connector.connect(
    host="localhost",
    user="root",  # Replace with your MySQL username
    password="Sarah@1710",  # Replace with your MySQL password
    database="AR"
)
cursor = db.cursor()

# Function to Fetch Patient Details
def fetch_patient():
    patient_id = entry_patient_id.get().strip()
    
    if not patient_id.isdigit():
        messagebox.showerror("Error", "Enter a valid Patient ID!")
        return
    
    query = """
    SELECT 
        p.patient_id, p.first_name, p.last_name, p.dob, p.gender, p.contact_number, p.email, p.address, p.status,
        IFNULL(h.hospital_name, 'N/A'), IFNULL(h.location, 'N/A'),
        IFNULL(m.service_date, 'N/A'), IFNULL(m.service_description, 'N/A'), IFNULL(m.covered, 'N/A'),
        IFNULL(i.provider_name, 'N/A'), IFNULL(i.policy_number, 'N/A'), IFNULL(i.coverage_details, 'N/A')
    FROM Patient p
    LEFT JOIN Medical_Service m ON p.patient_id = m.patient_id
    LEFT JOIN Hospital h ON m.hospital_id = h.hospital_id
    LEFT JOIN Insurance i ON p.patient_id = i.patient_id
    WHERE p.patient_id = %s
    """

    cursor.execute(query, (patient_id,))
    result = cursor.fetchone()

    print("DEBUG - Raw SQL Output:", result)  # Add this line

    if result is None:
        messagebox.showerror("Error", "Patient ID not found!")
        return
    
    # If fewer columns are returned, pad missing ones with 'N/A'
    while len(result) < 18:
        result += ("N/A",)

    display_text.set(f"Patient: {result[1]} {result[2]}\n"
                     f"DOB: {result[3]} | Gender: {result[4]}\n"
                     f"Contact: {result[5]} | Email: {result[6]}\n"
                     f"Address: {result[7]} | Status: {result[8]}\n"
                     f"Hospital: {result[9]} ({result[10]})\n"
                     f"Service: {result[11]} ({result[12]})\n"
                     f"Coverage: {result[13]}\n"
                     f"Insurance: {result[14]} ({result[15]}) - {result[16]}")
  

# GUI Setup
root = tk.Tk()
root.title("Healthcare System")
root.geometry("500x400")

# Labels & Entry
tk.Label(root, text="Enter Patient ID:").pack(pady=5)
entry_patient_id = tk.Entry(root)
entry_patient_id.pack(pady=5)

# Fetch Button
tk.Button(root, text="Get Patient Info", command=fetch_patient).pack(pady=10)

# Display Result
display_text = tk.StringVar()
tk.Label(root, textvariable=display_text, wraplength=450, justify="left").pack(pady=10)

# Run the App
root.mainloop()

# Close Connection
db.close()
