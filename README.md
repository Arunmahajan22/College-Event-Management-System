
<div align="center">

# 🎓 College Event Management System

### *A Scalable Oracle SQL & PL/SQL Database for Smart College Event Management*

<p>
<img src="https://img.shields.io/badge/Oracle-Database-F80000?style=for-the-badge&logo=oracle&logoColor=white"/>
<img src="https://img.shields.io/badge/SQL-PLSQL-blue?style=for-the-badge"/>
<img src="https://img.shields.io/badge/DBMS-Project-success?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Normalization-3NF-orange?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge"/>
<img src="https://img.shields.io/github/license/Arunmahajan22/College-Event-Management-System?style=for-the-badge"/>
</p>

*A complete relational database solution for managing hackathons, workshops, seminars, clubs, registrations and participant feedback.*


</div>

---

# 📚 Table of Contents

- ✨ Features
- 🏗 Architecture
- 🗄 Database Design
- 🧩 ER Diagram
- 📂 Project Structure
- ⚙️ Database Modules
- 🚀 SQL Features
- 📈 Sample Workflow
- 🔮 Future Enhancements
- 👨‍💻 Author

---

# 📖 Overview

The **College Event Management System** is a normalized Oracle SQL database developed to simplify the management of college events. It maintains a centralized repository for students, faculty, clubs, events, registrations and feedback while enforcing relational integrity through primary keys, foreign keys, constraints, stored procedures, triggers and cursors.

---

# ✨ Features

| Feature | Description |
|---------|-------------|
| 🎯 Event Management | Manage Hackathons, Workshops & Seminars |
| 👨‍🎓 Student Management | Student Profiles & Registrations |
| 👨‍🏫 Faculty Management | Faculty Information & Feedback |
| 🏛 Club Management | Club-wise Event Organization |
| 🎫 Ticket Generation | Automatic Ticket IDs using Trigger |
| 💬 Feedback | Ratings & Comments |
| ⚡ PL/SQL | Procedures & Triggers |
| 📊 Reporting | Cursor-based Registration Reports |
| 🔒 Integrity | PK, FK & Constraints |
| 📚 Normalization | Designed up to 3NF |

---

# 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| Database | Oracle Database |
| Language | SQL, PL/SQL |
| Design | ER Modeling |
| Concepts | Normalization, Constraints |
| IDE | Oracle SQL Developer |

---

# 🏗 Database Architecture

```text
                 PERSON
               /        \
          STUDENT      FACULTY
              |            |
      REGISTRATION     FEEDBACK
              |
            EVENT
      /        |        \
Hackathon  Seminar  Workshop
              |
        ORGANIZED_BY
              |
             CLUB
```

---

# 🧩 ER Diagram

> Replace this placeholder after uploading your diagram.

```md
![ER Diagram](assets/er-diagram.png)
```

---

# ⚙️ Database Modules

- 👤 Person
- 👨‍🎓 Student
- 👨‍🏫 Faculty
- 🏛 Club
- 🎉 Event
- 📝 Registration
- 💬 Feedback
- 🔗 Organized_By
- 🏆 Hackathon
- 🎙 Seminar
- 🛠 Workshop

---

# 🚀 SQL Features

## Stored Procedures

- Register Participant
- Submit Feedback
- Assign Club to Event

## Triggers

- Auto Generate Ticket ID
- Log Negative Feedback

## Cursor

- Display all registrations for a selected event

---

# 🔄 Sample Workflow

```text
Student
   │
Registers
   │
Registration Created
   │
Trigger Generates Ticket
   │
Participates in Event
   │
Faculty Reviews Event
   │
Feedback Stored
   │
Negative Feedback Logged Automatically
```

---

# 📊 Highlights

- ✅ Normalized Database (3NF)
- ✅ Relational Integrity
- ✅ Oracle SQL
- ✅ PL/SQL Procedures
- ✅ Database Triggers
- ✅ Cursor Implementation
- ✅ Sample Dataset
- ✅ Modular Schema
- ✅ Scalable Design

---

# 🔮 Future Enhancements

- 🌐 Web Portal
- 📱 Mobile Application
- 💳 Payment Gateway
- 📧 Email Notifications
- 📷 QR Code Tickets
- 📈 Analytics Dashboard
- 🔐 Authentication & Authorization
- ☁️ Cloud Deployment

---

# 🤝 Contributing

Contributions, improvements and suggestions are welcome.

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Submit a Pull Request

---

# 📜 License

Released under the MIT License.

---

<div align="center">

## 👨‍💻 Author

### Arun Mahajan

**Computer Engineering • Thapar Institute of Engineering and Technology**

⭐ **If this repository helped you, don't forget to Star it!**

Made with ❤️ using Oracle SQL & PL/SQL

</div>
