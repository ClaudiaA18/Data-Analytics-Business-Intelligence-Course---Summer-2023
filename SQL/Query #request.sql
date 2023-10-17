Request 
# 1) Identificati toate event-urile care se suprapun cu intervalul '2023-01-04' to '2023-01-09'
SELECT *
FROM events
WHERE start_date <= '2023-01-09' AND end_date >= '2023-01-04';

# 2) Identificati perechile de event-uri care au suprapuneri de intervale
SELECT e1.event_name AS event1, e2.event_name AS event2
FROM events e1
JOIN events e2 ON e1.event_name < e2.event_name
WHERE e1.end_date >= e2.start_date AND e1.start_date <= e2.end_date;

# 3) Listati fiecare event_name si fiecare data din interval
SELECT event_name, start_date AS date
FROM events
UNION
SELECT event_name, end_date AS date
FROM events;

# 4) Identificati zilele care nu se suprapaun intre event-uri si afisati-le doar pe acestea. Sa apara unice.
SELECT DISTINCT date
FROM (
  SELECT start_date AS date
  FROM events
  EXCEPT
  SELECT end_date AS date
  FROM events
) AS non_overlapping_dates;
