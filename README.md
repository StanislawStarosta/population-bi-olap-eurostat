# Eurostat EU Population BI Solution (SSIS ETL + OLAP Cube + Power BI)

## 📌 Project Overview

This project presents a complete Business Intelligence solution based on Eurostat demographic data describing the adult population in the European Union.

The system covers the full BI pipeline:
- ETL process using SQL Server Integration Services (SSIS)
- Data warehouse and OLAP cube design
- Analytical reporting using Power BI

The goal is to demonstrate an end-to-end BI architecture from raw data ingestion to interactive dashboards.

---

## ⚙️ System Architecture

The project consists of three main layers:

### 1. ETL Layer (SSIS)
Data extraction, transformation, and loading were implemented using SQL Server Integration Services (SSIS).

This layer includes:
- data extraction from Eurostat datasets
- data cleaning and transformation
- loading data into the data warehouse

📦 File: `Projekt_adults_SAW_SSIS.zip`

---

### 2. Data Warehouse / OLAP Cube
A multidimensional analytical model was created to support fast and efficient data analysis.

The model enables:
- multidimensional slicing (country, age, gender, time)
- aggregated demographic analysis
- optimized analytical queries

📦 File: `Projekt_adults_SAW_SSAS.zip`

---

### 3. Reporting Layer (Power BI)
Interactive dashboards were created using Power BI to visualize and explore demographic data.

Reports include:
- population distribution across EU countries
- age structure analysis of adult population
- gender comparison across regions
- cross-country demographic trends

📦 File: `Projekt_adults_SAW_SSRS.zip`

---

## 🧰 Technologies Used

- SQL Server Integration Services (SSIS)
- SQL Server (Data Warehouse)
- OLAP modeling
- Power BI
- DAX (Data Analysis Expressions)
- Eurostat datasets

---

## 📊 Key Analyses

- EU population distribution analysis
- Age group structure comparison
- Gender-based demographic insights
- Cross-country comparisons using OLAP cube
- Interactive BI dashboards

---

## 📁 Project Structure

```
├── Projekt_adults_SAW_SSIS.zip   → SSIS ETL packages
├── Projekt_adults_SAW_SSAS.zip          → OLAP / Data warehouse model
├── Projekt_adults_SAW_SSRS.zip       → Power BI dashboards
├── kraje.xlsx
└── README.md
```

---

## 📈 Key Insights

- Significant demographic differences exist between EU countries
- Age structure varies strongly across regions
- Gender distribution is relatively stable with minor variations
- OLAP modeling enables fast multidimensional exploration of data

---

## ▶️ How to Run the Project

1. Download or clone the repository:
```bash
git clone https://github.com/your-username/your-repo.git
```

2. Extract ZIP files:
- `Projekt_adults_SAW_SSIS.zip` → SSIS packages
- `Projekt_adults_SAW_SSAS.zip` → OLAP model
- `Projekt_adults_SAW_SSRS.zip` → Power BI dashboards

3. Run components in order:
- SSIS ETL process
- Load data into warehouse / cube
- Open Power BI report (`.pbix` if included inside ZIP)

---

## 🧠 Skills Demonstrated

- End-to-end BI pipeline design
- ETL development using SSIS
- Data warehouse and OLAP modeling
- SQL-based data processing
- Business intelligence reporting
- Data visualization and storytelling

---

## 📊 Business Value

This project demonstrates how raw demographic data can be transformed into meaningful business insights through:
- structured ETL processes
- interactive dashboards

---

## 🧠 Author

Business Intelligence project based on Eurostat demographic data, implementing a full SSIS + OLAP + Power BI workflow.

## 🧠 Author

Business Intelligence project based on Eurostat demographic data.
