-- Flag drug–drug interactions
-- Classify baseline medications with known colchicine interactions
-- Generate participant-level DDI status

/*
Assumes existing inputs:
- colchicine_cohort(participant_id, index_date)
- baseline_medications(participant_id, medication_name)
- ddi_reference(interacting_drug, ddi_class)

Purpose:
This query identifies participants with at least one baseline
medication that has a known interaction with colchicine and
creates a binary DDI indicator.
*/

WITH ddi_matches AS (
    SELECT
        b.participant_id,
        d.ddi_class
    FROM baseline_medications b
    JOIN ddi_reference d
      ON b.medication_name = LOWER(d.interacting_drug)
),

participant_ddi_status AS (
    SELECT
        participant_id,
        CASE
            WHEN COUNT(*) > 0 THEN 1
            ELSE 0
        END AS has_colchicine_ddi
    FROM ddi_matches
    GROUP BY participant_id
)

SELECT
    c.participant_id,
    COALESCE(p.has_colchicine_ddi, 0) AS has_colchicine_ddi
FROM colchicine_cohort c
LEFT JOIN participant_ddi_status p
  ON c.participant_id = p.participant_id;


-- Output shape:
-- participant_id | has_colchicine_ddi

