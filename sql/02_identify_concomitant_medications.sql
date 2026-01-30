-- Identify concomitant medications
-- Baseline medication assessment relative to colchicine index date
-- Prepare medication list for DDI classification

/*
Assumes existing tables:
- colchicine_cohort(participant_id, index_date)
- medication_exposure(participant_id, medication_name, start_date, end_date)

Purpose:
This query identifies medications taken at baseline that overlap
with the colchicine index date. These medications will be evaluated
for potential drug–drug interactions in subsequent steps.
*/

WITH baseline_medications AS (
    SELECT
        c.participant_id,
        LOWER(m.medication_name) AS medication_name,
        m.start_date,
        m.end_date
    FROM colchicine_cohort c
    JOIN medication_exposure m
      ON c.participant_id = m.participant_id
    WHERE
        -- Medication started on or before index date
        m.start_date <= c.index_date

        -- Medication active at index date (or ongoing)
        AND (m.end_date IS NULL OR m.end_date >= c.index_date)
)

SELECT DISTINCT
    participant_id,
    medication_name
FROM baseline_medications;
