-- selects and aggregates the following financial metrics – 'amount requested,' 'disbursed amount,' 
--'amount repaid,' 'interest accrued,' and 'penalty'  on a monthly basis.

SELECT
  DATE_FORMAT(approved_date, '%Y-%M') Month,
  SUM(amount_requested), 
  SUM(disbursed_amount),
  SUM(amount_repaid),
  SUM(amount_due),
  SUM(interest_accrued), 
  SUM(penalty)
FROM 
  v_loan_requests_above_ten_bob 
WHERE 
  ((DATE(approved_date) BETWEEN '2022-08-01'
  AND '2023-05-31') AND DATE(due_date) < current_date() )
GROUP BY  Month
ORDER BY Month

-- from the above date , I calculated the monthly collection rates

-- Selects and aggregates the defaulter count by monthly basis

SELECT 
  COUNT(a.profile_id) AS defaulter_count, 
  DATE_FORMAT(a.due_date, '%Y-%M') AS Period
FROM 
  v_loan_requests_above_ten_bob a 
  INNER JOIN profile p ON a.profile_id = p.profile_id 
WHERE 
  DATEDIFF(a.pay_date, a.due_date) > 0 
  AND DATE(a.due_date) >= '2022-08-01'
GROUP BY Period;


