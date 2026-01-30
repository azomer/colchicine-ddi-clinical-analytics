-- Define tolerability events
-- Identify gastrointestinal adverse-event–like outcomes
-- Anchor outcome timing relative to colchicine index date

/*
Assumes existing inputs:
- colchicine_cohort(participant_id, index_date)
- adverse_events(participant_id, event_type, event_date)

Purpose:
This query defines tolerability outcomes occurring after
colchicine initiation. Events are assessed within a predefined
post-index observation window.
*/

WITH post_index_events AS (
    SELECT
        c.participant_id,
        a.event_type,
        a.event_date
    FROM colchicine_cohort c
    JOIN adverse_events a
      ON c.participant_id = a.participant_id
    WHERE
        -- Events occurring after colchicine initiation
        a.event_date > c.index_date

        -- Example follow-up window (e.g., 30 days)
        AND a.event_date <= DATE_ADD(c.index_date, INTERVAL 30 DAY)
),

gi_events AS (
    SELECT
        participant_id,
        CASE
            WHEN COUNT(*) > 0 THEN 1
            ELSE 0
        END AS has_gi_event
    FROM post_index_events
    WHERE LOWER(event_type) IN (
        'nausea',
        'vomiting',
        'diarrhea',
        'abdominal pain'
    )
    GROUP BY participant_id
)

SELECT
    c.participant_id,
    COALESCE(g.has_gi_event, 0) AS has_gi_event
FROM colchicine_cohort c
LEFT JOIN gi_events g
  ON c.participant_id = g.participant_id;

-- Output shape:
-- participant_id | has_gi_event

