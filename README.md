# Integrated Life Insurance Reserving and Pricing System

## Project Overview
This project simulates an end-to-end actuarial cycle for a Life Insurance portfolio containing 60,000 policies.

The goal was to build a multi-language pipeline (SQL, Python, R, Excel) that takes raw policy data and produces two critical business outputs:
1. A calculation of the required capital reserves (IBNR).
2. A mortality pricing model to set premium rates for new customers.

## Key Results
* **Reserving:** Calculated a total Incurred But Not Reported (IBNR) reserve requirement of $325,547,069 using the Chain-Ladder method.
* **Pricing:** Developed a Poisson Generalized Linear Model (GLM) that identified Age as the primary driver of mortality risk.
* **Outcome:** Created a rate card showing risk probability increasing from roughly 1% at age 18 to 18% at age 80.

## Dashboard Preview
![Dashboard View](3_Excel_Dashboard/Dashboard_Screenshot.png)

### 📥 [Download the Actuarial Dashboard (xlsx)](3_Excel_Dashboard/Actuarial_Dashboard.xlsx)

## Technical Workflow
This project utilizes specific tools for the tasks they are best suited for:

1.  **SQL (SQLite):** Used for efficient data aggregation. Grouped 60,000 raw policy rows into summarized risk buckets based on Age, BMI, and Medical History.

2.  **Python (Pandas & NumPy):** Used for data engineering and simulation.
    * Generated synthetic timelines (Issue Date vs. Payment Date) to create actuarial run-off triangles.
    * Simulated claim events based on a dynamic risk probability dependent on Age.
    * Calculated Cumulative Development Factors (CDFs) to project ultimate claim costs.

3.  **R (RStudio):** Used for statistical modeling.
    * Fitted a Poisson GLM with a Log-Link function to model claim frequency.
    * Validated the model by confirming the statistical significance (P-value < 0.05) of the Age variable.

4.  **Excel:** Used for the final front-end interface.
    * Combined the R pricing output and Python reserving output into a user-friendly calculator for stakeholders.

## Repository Structure
* **0_Data:** Contains the raw inputs, cleaned datasets, and final CSV outputs.
* **1_Python_SQL_reserving:**
    * Python scripts for Chain-Ladder Reserving and 'Smart Simulation' of claims.
    * SQL queries used to aggregate 60k rows into risk buckets.
* **2_Rstudio_Pricing:** R scripts for the Poisson GLM and Mortality Curve generation.
* **3_Excel_Dashboard:** The final Executive Dashboard file and preview image.

## Data Source
The base risk factors (Age, BMI, Medical History) were sourced from the **Prudential Life Insurance Assessment** dataset on Kaggle.

* **Dataset Link:** [Prudential Life Insurance Assessment](https://www.kaggle.com/c/prudential-life-insurance-assessment/data)
* **File Used:** `train.csv`
* **Note:** While the policyholder attributes (Age, BMI) are real, the claim dates and death events were simulated stochastically for the purpose of building and testing these models.
