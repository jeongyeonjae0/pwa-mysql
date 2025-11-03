-- UPDATE 문
UPDATE employees
SET 
	fire_at = NOW()
	,deleted_at = NOW()
WHERE 
 	emp_id = 100005
;

UPDATE salaries 
SET 
	salary = 30000000
WHERE 
	sal_id = 1022177
;
	
