# E-Commerce-Business-Intelligence-Customer-Analytics
End to End Business Intelligence Project using SQL, Power BI, and Python for customer segmentation revenue analysis, Pareto Analysis, category insights and interactive dashboards.


An end-to-end **Business Intelligence and Customer Analytics** project using **SQL, Power BI, and Python** to analyze e-commerce performance, customer contribution, category concentration, and purchasing behavior.

##  Business Objective

The objective was to understand **what drives revenue, which customers matter most, where revenue is concentrated, and how customer behavior differs across segments**.

The analysis was designed to answer key business questions around:

* Revenue and profit performance
* Customer revenue concentration
* Product category contribution
* Order and quantity trends
* Customer behavioral segmentation
* Opportunities for retention, cross-selling, and targeted marketing

---

##  Executive Snapshot

| KPI                |         Value |
| ------------------ | ------------: |
| Revenue            | **$701.25K+** |
| Profit             | **$247.62K+** |
| Profit Margin      |    **35.31%** |
| Total Units        |    **16.9K+** |
| Customers          |     **3.9K+** |
| AOV                |    **$70.12** |
| YoY Revenue Growth |       **48%** |

---

##  Key Business Insights

### 1. Revenue Growth

Revenue increased by **48% YoY**, indicating strong overall business growth across the analyzed period.

The dashboard was used to track revenue, profit, order volume, and category-level performance over time to identify major fluctuations and growth periods.

### 2. Customer Revenue Concentration — Pareto Analysis

**20% of customers contributed 62% of total revenue**, highlighting a strong concentration of revenue among high-value customers.

This indicates an opportunity to prioritize:

* High-value customer retention
* Loyalty initiatives
* Personalized offers
* Cross-selling and upselling

The Pareto analysis helps distinguish customers who have a disproportionate impact on overall revenue.

### 3. Category Revenue Concentration

**Mobiles & Tablets, Entertainment, and Appliances contributed 79% of total revenue.**

This concentration highlights these categories as major revenue drivers and suggests opportunities for:

* Inventory prioritization
* Category-specific promotions
* Marketing budget allocation
* Cross-category selling

At the same time, dependence on a few categories creates a potential concentration risk that should be monitored.

### 4. Customer Segmentation

Customer behavioral features were engineered using purchasing characteristics such as **spending and purchase volume**, followed by **K-Means Clustering**.

The segmentation identified distinct behavioral groups, including:

* **Loyal, High-Value Customers**
* **Normal but Low Engagement Customers**
* **Extreme High-Volume Customers**

The segments reveal that revenue is not generated uniformly across the customer base, allowing marketing strategies to be tailored according to customer behavior.

### 5. Business Performance

The dashboard tracks core KPIs including **Revenue, Profit, Profit Margin, AOV, Units, and Customers**, allowing performance to be analyzed from both financial and customer perspectives.

The analysis also highlights periods where **revenue and volume movements do not necessarily translate proportionally into profit**, providing a basis for investigating pricing, discounting, and product-mix effects.

---

##  Data & Analysis Workflow

The project followed an end-to-end analytics workflow:

```text
Raw E-Commerce Data
        ↓
Data Validation & Cleaning
        ↓
Master Table Creation
        ↓
SQL Business Analysis
        ↓
Customer Feature Engineering
        ↓
Customer Segmentation
        ↓
Power BI Dashboard
        ↓
Business Insights & Recommendations
```

### 1. Data Preparation

The dataset was validated, cleaned, transformed, and organized into an analytical master table.

Key activities included:

* Data validation
* Data cleaning
* Handling invalid records
* Data transformation
* Master table creation
* Feature preparation

### 2. SQL Analysis

SQL was used extensively for business analysis and data preparation.

Key SQL techniques included:

* **CTEs**
* **JOINs**
* **CASE statements**
* **Aggregate functions**
* **Window functions**
* **GROUP BY**
* **Subqueries**
* **Date-based analysis**
* **Revenue and profitability calculations**
* **Pareto analysis**

The SQL analysis was structured around business questions rather than only technical queries.

### 3. Customer Behavioral Analysis

Customer-level features were engineered to understand purchasing behavior.

The analysis considered customer-level measures such as:

* Total spending
* Purchase volume
* Units purchased
* Revenue contribution
* Purchasing behavior

These features were subsequently used for customer segmentation.

### 4. Customer Segmentation

**K-Means Clustering** was applied to behavioral features to identify meaningful customer groups.

The resulting segments were interpreted from a business perspective rather than treated only as numerical clusters.

---

##  Power BI Dashboard

An interactive **Power BI Executive Dashboard** was developed to provide a consolidated view of business performance.

### Dashboard KPIs

* Revenue
* Profit
* Profit Margin
* Total Units
* Total Customers
* Average Order Value

### Dashboard Analysis

The dashboard includes visual analysis of:

* Category-wise revenue
* Order volume by category
* Revenue and profit trends
* Brand performance
* Payment-method quantity distribution
* Customer revenue concentration
* Pareto analysis

### Dashboard Preview

![E-Commerce Executive Dashboard](assets/executive_dashboard.png)

---

## 📊 Customer Segmentation

The customer segmentation analysis was used to move beyond overall KPIs and understand **who is actually driving business performance**.

![Customer Segmentation](assets/customer_segmentation.png)

The segmentation provides a foundation for differentiated strategies such as:

| Customer Segment       | Business Approach                               |
| ---------------------- | ----------------------------------------------- |
| Loyal, High-Value      | Retention, loyalty rewards, premium offers      |
| Normal, Low Engagement | Re-engagement campaigns and personalized offers |
| Extreme High-Volume    | Account-level attention, bulk offers, retention |

---

##  Pareto Analysis

The customer Pareto analysis revealed that:

> **The top 20% of customers contributed 62% of total revenue.**


This finding suggests that customer value is highly concentrated and that retaining high-value customers can have a disproportionate impact on revenue.

---

##  Business Recommendations

Based on the analysis:

1. **Prioritize high-value customers** through loyalty and retention programs.
2. **Focus marketing investment** on the three categories contributing **79% of revenue**.
3. Develop **segment-specific campaigns** instead of using a single strategy for all customers.
4. Investigate periods where **revenue growth does not translate proportionally into profit growth**.
5. Use customer and category insights to support **cross-selling and personalized promotions**.

---

##  Repository Structure

```text
ecommerce-business-intelligence/
│
├── README.md
│
├── data/
│   ├── customer_details.xlsx
│   ├── order_details.xlsx
│   ├── payment_details.xlsx
│   ├── sku_details.xlsx
│   └── customer_segment.xlsx
│
├── sql/
│   ├── 1_DATA_VALIDATION.sql
│   ├── 2_MASTER_TABLE.sql
│   ├── 3_BUSINESS_PERFORMANCE_ANALYSIS.sql
│   ├── 4_CUSTOMER_BEHAVIORAL_FEATURE_ENGINEERING.sql
│   ├── DATA_CLEANING_NEW.sql
│   ├── ML_data_query_NEW.sql
│   └── STAKEHOLDERS_QUESTIONS.sql
│
├── powerbi/
│   └── ecommerce_executive_dashboard.pbix
│
├── ml/
│   └── ml_model_ecommerce.html
│
└── assets/
    ├── ecommerce_dashboard.png
    ├── customer_segmentation.png
    
```

---

##  Tools & Technologies

**SQL:** MySQL, CTEs, JOINs, Window Functions, Aggregations, Business Analysis

**Python:** Pandas, NumPy, Scikit-learn, Data Processing, Feature Engineering

**Power BI:** Data Visualization, KPI Dashboards, Interactive Reporting, Business Intelligence

**Analytics:** Pareto Analysis, Customer Segmentation, Revenue Analysis, Category Analysis

---

##  Project Outcome

The project transformed raw e-commerce data into an **interactive business intelligence solution** that connects technical analysis with business decisions.

The analysis identified **revenue concentration, category dependencies, high-value customers, and distinct customer behaviors**, providing a structured basis for retention, marketing, inventory, and cross-selling decisions.
