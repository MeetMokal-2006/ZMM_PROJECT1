# 💼 Employee Expense Reimbursement System

**SAP ABAP RAP + CDS + SAP Fiori Elements**

An end-to-end employee expense reimbursement application developed using **SAP ABAP RESTful Application Programming Model (RAP)** and **SAP Fiori Elements**.

The system manages the complete expense process across three applications:

**Employee → Manager → Finance**

---

## 🚀 Features

### 👨‍💼 Employee

* Create expense claims
* Add multiple expense items
* View claim details and status
* Cancel eligible claims

### 👨‍💼 Manager

* View submitted expense claims
* Review expense items
* Approve claims
* Reject claims

### 💰 Finance

* View **only Manager-approved claims**
* Review approved claim and expense items
* Process reimbursement
* Track processed claims

---

## 🔄 Workflow

```text
Employee
   ↓
Create Claim + Add Expenses
   ↓
Submit Claim
   ↓
Manager Review
   ├── Reject
   └── Approve
          ↓
   Finance sees approved claim
          ↓
   Process Reimbursement
```

---

## 🏗️ SAP RAP Implementation

The project includes:

* CDS View Entities
* Root & Child Entities
* Composition & Associations
* Projection Views
* Behavior Definitions
* Behavior Implementation Classes
* RAP Actions
* Validations
* Instance Feature Control
* Side Effects
* Draft Handling
* Value Helps
* Metadata Extensions
* OData Service
* Service Definition & Binding

---

## 📱 Fiori Applications

| Application              | Purpose                           |
| ------------------------ | --------------------------------- |
| **Employee Expense App** | Create and manage expense claims  |
| **Manager Expense App**  | Review, approve and reject claims |
| **Finance Expense App**  | Process Manager-approved claims   |

Each application uses its own **role-specific projection view** while working with the underlying RAP business model.

---

## 🗄️ Main Database Tables

```text
ZMM_EMPLOYEE
ZMM_EXPENS_CLAIM
ZMM_EXPENSE_ITEM
ZMM_EXPENSE_TYPE
```

Draft tables are also used for RAP draft processing.

---

## ⚙️ Main RAP Objects

### CDS Views

```text
ZR_MM_EXPENSECLAIM
ZR_MM_EXPENSEITEM
ZR_MM_EMPLOYEE
ZR_MM_EXPENSETYPE

ZC_MM_EMPLOYEE_EXPENSE
ZC_MM_MANAGER_EXPENSE
ZC_MM_FINANCE_EXPENSE
```

### Behavior Implementations

```text
ZBP_R_MM_EXPENSECLAIM
ZBP_R_MM_MANAGER_EXPENSE
ZBP_R_MM_FINANCE_EXPENSE
```

### Service

```text
ZSRD_MM_EXPENSE   → Service Definition
ZSRB_MM_EXPENSE   → Service Binding
```

---

## 🛠️ Technology Stack

* **SAP S/4HANA**
* **ABAP**
* **ABAP RAP**
* **CDS**
* **OData V4**
* **SAP Fiori Elements**
* **SAPUI5**
* **SAP HANA**
* **Eclipse ADT**

---

## 📸 Applications

Screenshots of the Employee, Manager, and Finance applications can be added here.

```text
screenshots/
├── employee-app.png
├── manager-app.png
└── finance-app.png
```

---

## 👨‍💻 Author

**Meet Mokal**

SAP ABAP | RAP | CDS | Fiori Elements
