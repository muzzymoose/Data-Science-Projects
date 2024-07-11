SELECT
  stay,
  COUNT(inter_dom) AS count_int,
  round(AVG(todep),2) AS average_phq,
  round(AVG(tosc),2) AS average_scs,
  round(AVG(toas),2) SA average_as
FROM
  students
WHERE
  stay IS NOT NULL AND
  inter_dom = 'Inter'
GROUP BY
  stay,
  inter_dom
ORDER BY
  stay DESC
