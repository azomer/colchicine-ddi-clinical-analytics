-- Data quality and safety checks
-- Validate cohort integrity, joins, and temporal consistency

/*
Assumes existing inputs:
- colchicine_cohort(participant_id, index_date)
- baseline_medications(participant_id, medication_name)
- participant_ddi_status(participant_id, has_colchicine_ddi)
- tolerability_events(participant_id, has_gi_event)

Purpose:
This query set performs basic data quality checks to ensure
the analytic cohort is stable, complete, and free from
common sources of bias or duplication.
*/

-- 1. Check for missing index dates
SELECT
    COUNT(*) AS missing_index_date_count
FROM colchicine_cohort
WHERE index_date IS NULL;

-- 2. Check for duplicate participants in cohort
SELECT
    participant_id,
    COUNT(*) AS row_count
FROM colchicine_cohort
GROUP BY participant_id
HAVING COUNT(*) > 1;

-- 3. Validate DDI flag completeness
SELECT
    COUNT(*) AS missing_ddi_flag_count
FROM participant_ddi_status
WHERE has_colchicine_ddi IS NULL;

-- 4. Validate tolerability outcome completeness
SELECT
    COUNT(*) AS missing_gi_event_flag_count
FROM tolerability_events
WHERE has_gi_event IS NULL;

-- 5. Sanity check: ensure no outcomes occur before index date
SELECT
    COUNT(*) AS events_before_index_date
FROM tolerability_events t
JOIN colchicine_cohort c
  ON t.participant_id = c.participant_id
WHERE t.has_gi_event = 1
  AND t.event_date <= c.index_date;


-- Output shape:
-- aggregate counts by check (one result set per query)

