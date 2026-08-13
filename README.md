💼 Employee Expense Reimbursement System
SAP ABAP RAP + CDS + Fiori Elements

An end-to-end Employee Expense Reimbursement System developed using the SAP ABAP RESTful Application Programming Model (RAP) and SAP Fiori Elements.

The project digitizes the complete expense reimbursement process across three business roles:

Employee → Manager → Finance

The application uses a common RAP-based data model while exposing role-specific projection views and Fiori applications for Employee, Manager, and Finance users.

🚀 Project Overview

The system provides a structured workflow for submitting, reviewing, approving, rejecting, and processing employee expense claims.

Business Process
┌──────────────┐
│   Employee   │
└──────┬───────┘
       │
       │ Create Claim
       │ Add Expense Items
       ▼
┌──────────────────────┐
│    Expense Claim     │
│   + Expense Items     │
└──────────┬───────────┘
           │
           │ Submit
           ▼
┌──────────────────────┐
│       Manager        │
│       Review         │
└──────────┬───────────┘
           │
       ┌───┴────┐
       │        │
    Approve   Reject
       │        │
       ▼        ▼
┌──────────┐  ┌──────────┐
│ Finance  │  │ Rejected │
│ Process  │  │  Claim   │
└────┬─────┘  └──────────┘
     │
     │ Process
     ▼
┌──────────────┐
│ Reimbursed   │
└──────────────┘
🎯 Key Features
👨‍💼 Employee Application

Employees can:

Create expense claims
Add multiple expense items
Maintain expense details
View their submitted claims
View claim status
Cancel eligible claims
Review claim and expense-item information
👨‍💼 Manager Application

Managers can:

View submitted employee claims
Open claim details
Review individual expense items
Approve claims
Reject claims
View claim processing status

The Manager application uses a dedicated projection and behavior layer rather than exposing the complete employee-facing business model.

💰 Finance Application

Finance users can:

View claims approved by the manager
Review claim details
Review expense items
Process reimbursement
Update reimbursement-related status
Track processed claims
🏗️ RAP Architecture

The project follows the layered architecture of the ABAP RESTful Application Programming Model.

                         ┌─────────────────────────┐
                         │     SAP Fiori Apps      │
                         │                         │
                         │ Employee │ Manager │    │
                         │          │ Finance │    │
                         └────────────┬────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────┐
                         │    Projection Layer     │
                         │                         │
                         │ ZC_MM_EMPLOYEE_EXPENSE  │
                         │ ZC_MM_MANAGER_EXPENSE   │
                         │ ZC_MM_FINANCE_EXPENSE   │
                         └────────────┬────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────┐
                         │     RAP Behavior Layer  │
                         │                         │
                         │ Behavior Definitions   │
                         │ Actions / Validations  │
                         │ Feature Control        │
                         └────────────┬────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────┐
                         │      CDS Data Model     │
                         │                         │
                         │ Expense Claim           │
                         │ Expense Item            │
                         │ Employee                │
                         │ Expense Type            │
                         └────────────┬────────────┘
                                      │
                                      ▼
                         ┌─────────────────────────┐
                         │      SAP HANA DB        │
                         │     Database Tables     │
                         └─────────────────────────┘

SAP describes RAP as an architecture for building transactional Fiori applications and OData services using CDS-based data models, behavior, and service infrastructure.

🧩 Data Model

The main business relationship is:

             Expense Claim
                   │
                   │ Composition
                   │
                   ▼
              Expense Item

One expense claim can contain multiple expense items.

Expense Claim
│
├── Claim Information
│
├── Employee
│
├── Status
│
├── Total Amount
│
└── Expense Items
      │
      ├── Expense Type
      ├── Expense Date
      ├── Amount
      ├── Currency
      └── Description

This parent-child structure is modeled using CDS entities and RAP composition.

SAP RAP business objects can contain multiple nodes, with behavior defined for the business object and its composition tree.

🗂️ Development Objects

The following development objects were created as part of the project.

📦 Service Layer
Service Definition
ZSRD_MM_EXPENSE

Purpose: Defines the CDS entities exposed as part of the expense management business service.

Service Binding
ZSRB_MM_EXPENSE

Purpose: Binds the service definition to the service protocol used by the Fiori applications.

SAP defines a business service in RAP through a service definition + service binding combination. The service definition determines what is exposed, while the binding connects that service to a specific protocol and service type.

📊 CDS Data Definitions

The project contains multiple CDS entities covering the data model, projection layer, value helps, and supporting objects.

Root / Interface Views
ZR_MM_EMPLOYEE
ZR_MM_EXPENSECLAIM
ZR_MM_EXPENSEITEM
ZR_MM_EXPENSETYPE

ZR_MM_FINANCE_EXPENSE
ZR_MM_FINANCE_EXPENSEITEM

ZR_MM_MANAGER_EXPENSE
ZR_MM_MANAGER_EXPENSEITEM
Projection Views
Employee
ZC_MM_EMPLOYEE_EXPENSE
ZC_MM_EMPLOYEE_EXPENSEITEM
Expense Claim
ZC_MM_EXPENSECLAIM
ZC_MM_EXPENSEITEM
Manager
ZC_MM_MANAGER_EXPENSE
ZC_MM_MANAGER_EXPENSEITEM
Finance
ZC_MM_FINANCE_EXPENSE
ZC_MM_FINANCE_EXPENSEITEM

The role-specific projection views allow the same underlying business data to be presented differently for Employee, Manager, and Finance applications.

SAP RAP projection behavior is specifically intended to expose service-specific behavior from an underlying business object.

🔎 Value Help Views

The project includes dedicated value help CDS views.

ZC_MM_VH_EMPLOYEE
ZC_MM_VH_EXPENSETYPE
Employee Value Help

Used for selecting employee information from a controlled list rather than manually entering employee-related values.

Expense Type Value Help

Used for selecting valid expense categories/types.

📝 Additional CDS Objects

The project also contains:

ZMM_A_REJECT_CLAIM

This CDS object is used for the Reject Claim dialogue functionality.

⚙️ RAP Behavior Definitions

The project contains 7 Behavior Definitions.

ZC_MM_EMPLOYEE_EXPENSE
ZC_MM_EXPENSECLAIM
ZC_MM_FINANCE_EXPENSE
ZC_MM_MANAGER_EXPENSE

ZR_MM_EXPENSECLAIM
ZR_MM_FINANCE_EXPENSE
ZR_MM_MANAGER_EXPENSE

These definitions control the transactional behavior of the RAP business objects and their projections.

The behavior layer is responsible for defining operations and business rules such as:

Create
Update
Delete
Actions
Validations
Feature control
Status-dependent operations
Transactional behavior

SAP documents the behavior definition as the RAP repository object that describes the behavior of a business object, while behavior pools contain its implementation.

🧠 Behavior Implementation Classes

The project contains dedicated behavior implementation classes.

ZBP_R_MM_EXPENSECLAIM
ZBP_R_MM_FINANCE_EXPENSE
ZBP_R_MM_MANAGER_EXPENSE

These classes implement the custom business logic for the corresponding RAP behavior definitions.

Examples of business logic include:

Employee
   │
   ├── Create Claim
   ├── Maintain Items
   ├── Submit
   └── Cancel Claim
          │
          ▼
Manager
   │
   ├── Approve Claim
   └── Reject Claim
          │
          ▼
Finance
   │
   └── Process Reimbursement
🔄 Business Actions

The application uses RAP actions for business operations that go beyond standard CRUD processing.

Examples include:

Employee
Submit Claim
Cancel Claim
Manager
Approve Claim
Reject Claim
Finance
Process Expense Claim

These actions allow the application to represent real business operations rather than treating the application as a simple database CRUD interface.

🛡️ Feature Control

The application uses RAP instance-based feature control to enable or disable operations depending on the current claim status.

For example:

Claim Status
     │
     ├── New
     │    ├── Edit       ✓
     │    └── Cancel     ✓
     │
     ├── Submitted
     │    ├── Edit       ✕
     │    └── Cancel     ✓
     │
     ├── Approved
     │    ├── Edit       ✕
     │    └── Cancel     ✕
     │
     └── Reimbursed
          ├── Edit       ✕
          └── Cancel     ✕

This prevents invalid operations from being performed on claims that have already progressed to later stages.

🔁 Side Effects

The application also uses RAP/Fiori side effects to update dependent UI information after business operations.

This helps ensure that the Fiori Elements UI reflects changes in the business object without requiring unnecessary manual refreshes.

📝 Metadata Extensions

The project contains 7 Metadata Extensions.

ZMDE_C_EMPLOYEE_EXPENSEITEM
ZMDE_C_MANAGER_EXPENSEITEM

ZMDE_C_MM_EMPLOYEE
ZMDE_C_MM_EXPENSEITEM
ZMDE_C_MM_EXPENSECLAIM

ZMDE_C_MM_FINANCE_EXPENSE
ZMDE_C_MM_FINANCE_EXPENSEITEM
ZMDE_C_MM_MANAGER_EXPENSE

Metadata extensions are used to keep UI-related annotations separate from the core CDS data definitions.

They define the presentation of the Fiori Elements applications, including:

UI fields
Sections
Facets
Header information
Tables
Actions
Filters
Object Page layout
🗄️ Database Tables

The project contains 6 database tables.

ZMM_EMPLOYEE
ZMM_EXPENSE_ITEM
ZMM_EXPENSE_TYPE
ZMM_EXPENS_CLAIM
ZMM_EXPENS_C_D
ZMM_EXP_ITEM_D

The database layer stores the persistent business data and draft data required by the RAP implementation.

Main Tables
Table	Purpose
ZMM_EMPLOYEE	Employee master data
ZMM_EXPENSE_TYPE	Expense type/category data
ZMM_EXPENSE_ITEM	Individual expense items
ZMM_EXPENS_CLAIM	Expense claim information
ZMM_EXPENS_C_D	Draft data for expense claim
ZMM_EXP_ITEM_D	Draft data for expense-related data
📝 Draft Handling

The project uses RAP draft-enabled processing.

Draft tables are used for maintaining incomplete changes before the transaction is activated.

User
 │
 │ Edit
 ▼
Draft Data
 │
 │ Save / Activate
 ▼
Active Data

This allows users to work on an expense claim without immediately changing the active business data.

🖥️ Fiori Elements Applications

The backend provides the foundation for three role-specific Fiori Elements applications.

1. Employee Expense App

Projection:

ZC_MM_EMPLOYEE_EXPENSE

Purpose:

Allows employees to create and manage their expense claims and expense items.

2. Manager Expense App

Projection:

ZC_MM_MANAGER_EXPENSE

Purpose:

Allows managers to review, approve, and reject employee expense claims.

3. Finance Expense App

Projection:

ZC_MM_FINANCE_EXPENSE

Purpose:

Allows finance users to process approved claims and manage reimbursement processing.

🎨 Fiori Elements

The project uses a metadata-driven Fiori Elements approach instead of building the complete UI manually with custom SAPUI5 code.

The UI is driven by:

CDS Views
    +
UI Annotations
    +
Metadata Extensions
    +
OData Service
    =
Fiori Elements Application

Fiori Elements provides standardized application floorplans such as List Reports and Object Pages for OData-based applications.

🏛️ Complete Technical Architecture
                         SAP FIORI
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
        ▼                   ▼                   ▼
 Employee App          Manager App         Finance App
        │                   │                   │
        └───────────────────┼───────────────────┘
                            │
                            ▼
                  Projection CDS Views
                            │
             ┌──────────────┼──────────────┐
             │              │              │
             ▼              ▼              ▼
       Employee BO     Manager BO      Finance BO
             │              │              │
             └──────────────┼──────────────┘
                            ▼
                    RAP Behavior Layer
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
     Validations        Actions        Feature Control
          │                 │                 │
          └─────────────────┼─────────────────┘
                            ▼
                    Interface CDS Layer
                            │
                            ▼
                     Database Tables
                            │
                            ▼
                        SAP HANA
🛠️ Technology Stack
Technology	Purpose
SAP S/4HANA	Enterprise application platform
ABAP	Backend development
ABAP RAP	Transactional business object framework
CDS View Entities	Data modeling
Behavior Definitions	Business behavior
Behavior Pool Classes	Custom ABAP business logic
OData	Service communication
SAP Fiori Elements	User interface
SAPUI5	Fiori technology
Metadata Extensions	UI annotations
SAP HANA	Database
Eclipse ADT	Development environment
📁 Repository Structure

The ABAP repository is organized around the following RAP development artifacts:

Employee-Expense-Reimbursement/
│
├── Database Tables
│   ├── ZMM_EMPLOYEE
│   ├── ZMM_EXPENSE_TYPE
│   ├── ZMM_EXPENSE_ITEM
│   ├── ZMM_EXPENS_CLAIM
│   ├── ZMM_EXPENS_C_D
│   └── ZMM_EXP_ITEM_D
│
├── CDS Data Definitions
│   ├── Interface Views
│   ├── Root Views
│   ├── Projection Views
│   ├── Value Help Views
│   └── Supporting CDS Objects
│
├── Behavior Definitions
│   ├── Employee Projection
│   ├── Expense Claim Projection
│   ├── Finance Projection
│   ├── Manager Projection
│   ├── Expense Claim Root
│   ├── Finance Root
│   └── Manager Root
│
├── Behavior Implementation
│   ├── ZBP_R_MM_EXPENSECLAIM
│   ├── ZBP_R_MM_FINANCE_EXPENSE
│   └── ZBP_R_MM_MANAGER_EXPENSE
│
├── Metadata Extensions
│   ├── Employee UI
│   ├── Expense Item UI
│   ├── Expense Claim UI
│   ├── Manager UI
│   └── Finance UI
│
├── Service Definition
│   └── ZSRD_MM_EXPENSE
│
└── Service Binding
    └── ZSRB_MM_EXPENSE
🔍 Development Object Summary
Category	Objects
Service Definitions	1
Service Bindings	1
Behavior Definitions	7
CDS Data Definitions	19
Metadata Extensions	7
Database Tables	6
ABAP Classes	5
📚 RAP Concepts Demonstrated

This project provides practical implementation of:

ABAP RESTful Application Programming Model
Managed RAP
Draft-enabled business objects
CDS View Entities
Root entities
Child entities
Composition
Associations
Projection views
Projection behavior
Behavior definitions
Behavior implementation
RAP actions
RAP validations
Instance feature control
Side effects
Service definitions
Service bindings
OData services
Fiori Elements
UI annotations
Metadata extensions
Value helps
Role-specific projections
🧪 Example Business Scenario
Step 1 — Employee Creates Claim
Employee
   ↓
Create Expense Claim
   ↓
Enter Claim Information
   ↓
Add Expense Items
   ↓
Submit
Step 2 — Manager Reviews
Manager
   ↓
Open Submitted Claim
   ↓
Review Expense Items
   ↓
Approve / Reject
Step 3 — Finance Processes
Finance
   ↓
Open Approved Claim
   ↓
Review Amount
   ↓
Process Reimbursement
   ↓
Complete
📸 Application Screenshots

Add the actual screenshots of your three Fiori applications here:

screenshots/
│
├── employee-app.png
├── manager-app.png
└── finance-app.png

Example:

## Employee Application

![Employee Expense Application](screenshots/employee-app.png)

## Manager Application

![Manager Expense Application](screenshots/manager-app.png)

## Finance Application

![Finance Expense Application](screenshots/finance-app.png)
