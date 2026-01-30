# Colchicine Drug–Drug Interaction and Tolerability Analytics

## Overview
This repository demonstrates analytical patterns relevant to **secondary analyses of randomized clinical trials**, with a focus on **drug–drug interaction (DDI) classification** and **clinical tolerability outcomes**.

The structure reflects analytical workflows used to evaluate medication safety and adverse event profiles in trial-based data. This repository is **related to published work in *JAMA Network Open* (2024)** and is intended to illustrate analytic reasoning and methodology only.

**This repository does not reproduce published analyses or results.**

---

## Context
Colchicine has known drug–drug interactions with commonly prescribed medications. While pharmacokinetic studies have characterized these interactions, understanding their **clinical tolerability** requires careful analytic design.

In a published secondary analysis of the COLCORONA randomized clinical trial, drug–drug interaction status was evaluated as a potential modifier of colchicine-related adverse events. This repository mirrors the **analytic structure and logic** of such evaluations without replicating trial data, effect estimates, or outcomes.

---

## Project Structure and Analytical Approach

The analysis is organized as a stepwise pipeline. Each SQL file represents a discrete analytical decision point commonly encountered in trial-based secondary analyses.

### 1. Define Colchicine Cohort
**File:** `01_define_colchicine_cohort.sql`

### 1. Define Colchicine Cohort
**File:** `01_define_colchicine_cohort.sql`

- Identifies adult participants randomized to the colchicine arm
- Confirms active colchicine exposure using medication records
- Establishes a clear index date based on randomization
- Produces a clean, participant-level cohort for downstream analyses


---

### 2. Identify Concomitant Medications
**File:** `02_identify_concomitant_medications.sql`

- Identifies baseline medications overlapping with the colchicine index date
- Applies temporal logic to capture ongoing and recently initiated therapies
- Produces a participant-level medication list for DDI classification

---

### 3. Flag Drug–Drug Interactions
**File:** `03_flag_drug_drug_interactions.sql`

- Applies rule-based DDI classification
- Demonstrates how interaction status can be operationalized
- Separates interaction logic from outcome modeling

---

### 4. Define Tolerability Events
**File:** `04_define_tolerability_events.sql`

- Defines adverse event–like signals (e.g., gastrointestinal events)
- Establishes observation windows relative to exposure
- Illustrates outcome construction in tolerability analyses

---

### 5. Data Quality and Safety Checks
**File:** `05_data_quality_and_safety_checks.sql`

- Identifies missing or incomplete exposure data
- Detects duplicate inflation due to joins
- Validates temporal consistency of medications and events

---

## Scope and Boundaries
- This repository is **methodological** and **instructional**.
- It does **not** include trial data.
- It does **not** reproduce statistical models, estimates, or results.
- It is intended to demonstrate **analytic structure and reasoning**, not study findings.

---

## Skills Demonstrated
- Secondary analysis design for randomized clinical trials  
- Drug–drug interaction classification logic  
- Medication exposure windowing  
- Adverse event definition and timing  
- Defensive SQL for safety and data quality  

---

## Author
**Azza Omer**  
Clinical Analytics | Medication Safety | Drug–Drug Interactions

