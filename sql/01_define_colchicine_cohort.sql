-- Define colchicine cohort
-- Adult participants randomized to colchicine
-- Establish baseline eligibility and index date

/*
Assumes existing trial-style tables:
- participants(participant_id, age, treatment_arm, randomization_date)
- medication_exposure(participant_id, medication_name, start_date, end_date)

Purpose:
This query defines the analytic population for downstream
drug–drug interaction and tolerability analyses.
*/

WITH adult_participants AS (
    SELECT
        p.participant_id,
        p.randomization_date AS index_date
    FROM participants p
    WHERE p.age >= 18
),

colchicine_randomized AS (
    SELECT
        a.participant_id,
        a.index_date
    FROM adult_participants a
    JOIN participants p
      ON a.participant_id = p.participant_id
    WHERE p.treatment_arm = 'colchicine'
),

confirmed_colchicine_exposure AS (
    SELECT DISTINCT
        c.participant_id,
        c.index_date
    FROM colchicine_randomized c
    JOIN medication_exposure m
      ON c.participant_id = m.participant_id
    WHERE LOWER(m.medication_name) = 'colchicine'
      AND m.start_date <= c.index_date
)

SELECT
    participant_id,
    index_date
FROM confirmed_colchicine_exposure;
