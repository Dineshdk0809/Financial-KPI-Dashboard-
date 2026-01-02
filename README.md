# Financial-KPI-Dashboard-
End-to-end Financial KPI Dashboard built using SQL and Power BI to analyze revenue, expenses, profit trends, burn rate, and business runway.

## Project Overview
This project simulates a real-world startup finance scenario where financial health and business sustainability are analyzed using SQL-driven KPIs and executive-level dashboards.

All business logic and calculations are handled in **MySQL**, while **Power BI** is used strictly for visualization and storytelling.

---

## Business Objectives
- Analyze overall financial performance using Profit & Loss (P&L)
- Track cash burn rate and estimate business runway
- Measure marketing efficiency using Customer Acquisition Cost (CAC)
- Estimate customer value using Lifetime Value (LTV)
- Evaluate scalability using Unit Economics (LTV vs CAC)

---

## Tools & Technologies
- MySQL
- SQL
- Power BI
- MySQL ODBC Connector

---

## Dataset Description
Synthetic startup data representing:
- Customers and acquisition channels  
- Revenue transactions  
- Operating expenses  
- Marketing spend  
- Cash balance  

The dataset mirrors real startup finance and marketing data structures.

---

## Data Pipeline Architecture
Raw Tables → Clean SQL Views → KPI Views → Power BI Dashboard
- Raw data tables are preserved without modification
- Data cleaning and validation are handled using SQL views
- KPI calculations are exposed via final KPI-level views
- Power BI connects only to final SQL views (no raw tables)

---

## Data Cleaning & Preparation
- Filtered invalid and negative values using SQL views
- Ensured data consistency before KPI computation
- Followed layered SQL modeling (raw → clean → KPI)

---

## Key KPI Calculations

### Profit & Loss (P&L)
Calculated total revenue, total expenses, and net profit to assess overall financial performance.

---

### Burn Rate
Calculated monthly operating expenses to measure how quickly the company is spending cash.

---

### Runway
Estimated runway by dividing current cash balance by average monthly burn rate to understand cash sustainability.

---

### Customer Acquisition Cost (CAC)
Calculated CAC by dividing total marketing spend by the number of customers acquired, grouped by acquisition channel.

---

### Customer Lifetime Value (LTV)
Calculated customer-level lifetime revenue and derived average LTV to estimate long-term customer value.

---

### Unit Economics (LTV vs CAC)
Compared LTV against CAC to determine whether customer acquisition is economically viable.

---

## Dashboard Structure (Power BI)

### Page 1 — Executive Summary
Provides a high-level overview of the company’s financial health:
- Net Profit / Loss
- Monthly Burn Rate (latest)
- Runway (months)
- Burn Rate Trend
- Executive insights

---

### Page 2 — Unit Economics
Evaluates customer-level business sustainability:
- CAC by Channel (table and bar chart)
- Average Customer LTV
- LTV vs CAC Ratio
- Strategic insights on scalability

---

## Key Business Insights
- The startup is currently operating at a loss, which is typical for early-stage companies
- Monthly burn rate shows stabilization, indicating controlled spending
- Runway is critically low, highlighting urgency for cost optimization or fundraising
- Organic acquisition channels demonstrate significantly stronger unit economics
- Paid marketing channels require optimization before scaling

---

## Key Learnings
- Importance of SQL-first KPI computation for accuracy and reusability
- Clear separation of data transformation and visualization layers
- Translating financial metrics into actionable business insights
- Building concise, executive-ready dashboards

---

## Conclusion
This project demonstrates an end-to-end financial analytics workflow combining SQL-based KPI computation with Power BI dashboards to support strategic decision-making in a startup environment.

---
