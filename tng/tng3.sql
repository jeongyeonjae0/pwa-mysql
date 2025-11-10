-- 1. 모든 직원의 이름과 입사일을 조회하세요.
SELECT 
	`name`
	,hire_at
FROM employees;

-- 2. 'd005' 부서에 속한 모든 직원의 직원 ID를 조회하세요.
SELECT 
	emp.emp_id
FROM employees emp 
 	JOIN department_emps depe 
 		ON emp.emp_id = depe.emp_id
 		AND emp.fire_at IS NULL 
 		AND depe.dept_code = 'D005'
		AND depe.end_at IS NULL	
;

-- 3. 1995년 1월 1일 이후에 입사한 모든 직원의 정보를 입사일 순서대로 정렬하여 조회하세요.
SELECT *
FROM employees 
WHERE 
	hire_at >= '1995.01.01'
ORDER BY hire_at ASC
;
	
-- 4. 각 부서별로 몇 명의 직원이 있는지 계산하고, 직원 수가 많은 부서부터 순서대로 보여주세요.
SELECT 
	dept_name
	,COUNT(depe.dept_code)
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id 
		AND emp.fire_at IS NULL 
		AND depe.end_at IS NULL
	JOIN departments depm
		ON depe.dept_code = depm.dept_code
GROUP BY depe.dept_code
ORDER BY COUNT(depe.dept_code) DESC
;	 

-- 5. 각 직원의 현재 연봉 정보를 조회하세요.
SELECT
	emp.emp_id
	,sal.salary 
FROM employees emp
	JOIN salaries sal 
		ON emp.emp_id = sal.emp_id
		AND emp.fire_at IS NULL
		AND sal.end_at IS NULL 
;		

-- 6. 각 직원의 이름과 해당 직원의 현재 부서 이름을 함께 조회하세요.
SELECT
	emp.`name`
	,dept.dept_name 
FROM departments dept
	JOIN department_emps depe 
		ON dept.dept_code = depe.dept_code
		AND depe.end_at IS NULL 
	JOIN employees emp 
		ON depe.emp_id = emp.emp_id 
		AND emp.fire_at IS NULL
;		

-- 7. '마케팅부' 부서의 현재 매니저의 이름을 조회하세요.
SELECT
	dept.dept_name 
	,emp.`name`
FROM department_managers depm
	JOIN departments dept 
		ON depm.dept_code = dept.dept_code
		AND depm.end_at IS NULL 
		AND dept.dept_name = '마케팅부'
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
		AND emp.fire_at IS NULL
;

-- 8. 현재 재직 중인 각 직원의 이름, 성별, 직책(title)을 조회하세요.
SELECT
	emp.`name`
	,emp.gender
	,titl.title 
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id 
		AND emp.fire_at IS null
		AND tite.end_at IS NULL 
	JOIN titles titl
		ON tite.title_code = titl.title_code
;

-- 9. 현재 가장 높은 연봉을 받는 상위 5명의 직원 ID와 연봉을 조회하세요.
SELECT 
	emp.emp_id
	,sal.salary
FROM employees emp 
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id 
		AND sal.end_at IS NULL
ORDER BY sal.salary DESC
LIMIT 5
;
-- 10. 각 부서의 현재 평균 연봉을 계산하고, 평균 연봉이 60000 이상인 부서만 조회하세요. 
SELECT 
	depm.dept_name
	,CEILING(AVG(sal.salary)) avg_sal
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
		AND emp.fire_at IS NULL 
		AND depe.end_at IS NULL 
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL 
	JOIN departments depm 
		ON depe.dept_code = depm.dept_code
GROUP BY depe.dept_code
	HAVING AVG(sal.salary) >= 60000
ORDER BY avg_sal DESC
;

-- 11. 아래 구조의 테이블을 작성하는 SQL을 작성해 주세요.
CREATE TABLE users(
	userid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,username VARCHAR(30) NOT NULL COMMENT '이름'
	,authflg CHAR(1) DEFAULT '0' 
	,birthday DATE NOT NULL COMMENT '생일'
	,created_at DATETIME DEFAULT CURRENT_TIMESTAMP()
);

-- 12. 테이블에 아래 데이터를 입력 
INSERT INTO users(
	username
	,authflg
	,birthday
	,created_at
)
VALUES(
	'그린'
	,'0'
	,'2024-01-26'
	,NOW()
);

-- 13. 레코드를 아래 데이터로 갱신해 주세요. 
UPDATE users 
SET 
	username = '테스터'
	,AuthFlg = '1'
	,birthday = '2007-03-01' 
WHERE 
	userid ='1'
;

-- 14. 레코드를 삭제해 주세요.
DELETE FROM users
WHERE 
	userid ='1'
;

-- 15. 테이블에 아래 Column을 추가해 주세요. 
ALTER TABLE users 
ADD COLUMN addr VARCHAR(100) NOT NULL DEFAULT '-'
;

-- 16. 테이블을 삭제해 주세요.
DROP TABLE users;

-- 17. 테이블에서 유저명, 생일, 랭크명을 출력해 주세요.
CREATE TABLE users(
	userid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,username VARCHAR(30) NOT NULL COMMENT '이름'
	,authflg CHAR(1) DEFAULT '0' 
	,birthday DATE NOT NULL COMMENT '생일'
	,created_at DATETIME DEFAULT CURRENT_TIMESTAMP()
);	

INSERT INTO users(
	username
	,authflg
	,birthday
	,created_at
)
VALUES(
	'green'
	,'0'
	,'2024-01-26'
	,'2024-01-26 10:51:27'
);

CREATE TABLE rankmanagements(
	rankid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,userid INT UNSIGNED NOT NULL
	,rankname VARCHAR(30) NOT NULL
);

ALTER TABLE rankmanagements 
	ADD CONSTRAINT fk_rankmanagements_userid
		FOREIGN KEY (userid)
		REFERENCES users(userid) 
;	

INSERT INTO rankmanagements(
	userid
	,rankname
)
VALUES(
	 1
	,'manager'
); 

SELECT 
	username 
	,birthday
	,rankname 
FROM users 
	JOIN rankmanagements 
		ON users.userid = rankmanagements.userid
;


-- 1. 모든 직원의 이름과 입사일을 조회하세요. 
SELECT 
	`name`
	,hire_at
FROM employees
ORDER BY `name`, `hire_at`
;

-- 2. 'D005' 부서에 속한 모든 직원의 직원 ID를 조회하세요. 
SELECT 
	depe.emp_id 
FROM department_emps depe
	JOIN employees emp
		ON depe.emp_id = emp.emp_id
		AND emp.fire_at IS NULL
WHERE 
	depe.end_at IS NULL 
	AND depe.dept_code = 'D005'
;

-- 3. 1995년 1월 1일 이후에 입사한 모든 직원의 정보를 입사일 순서대로 정렬하여 조회하세요.
SELECT 
	* 
FROM employees 
WHERE 
	hire_at >= '1995-01-01'
ORDER BY hire_at
;

-- 4. 각 부서별로 몇 명의 직원이 있는지 계산하고, 직원 수가 많은 부서별로 
SELECT
	dept_code
	,COUNT(*) cnt_emp
FROM department_emps 
WHERE 
	end_at IS NULL
GROUP BY dept_code
ORDER BY cnt_emp DESC
;

-- 5. 각 직원의 현재 연봉 정보를 조회하세요. 
SELECT 
	emp_id
	,salary 
FROM salaries
WHERE 
	end_at IS NULL
;

-- 6. 각 직원의 이름과 해당 직원의 현재 부서 이름을 함께 조회하세요. 
SELECT 
	emp.`name`
	,depm.dept_name
FROM employees emp 
	JOIN department_emps depe 
		ON emp.emp_id = depe.emp_id
		AND emp.fire_at IS NULL
		AND depe.end_at IS NULL
	JOIN departments depm 
		ON depe.dept_code = depm.dept_code
		AND depm.end_at IS NULL
;

-- 7. '마케팅부' 부서의 현재 매니저의 이름을 조회하세요. 
SELECT 
	emp.`name`
FROM departments dep
	JOIN department_managers depm
		ON dep.dept_code = depm.dept_code
		AND dep.dept_name = '마케팅부'
		AND dep.end_at IS NULL 
		AND depm.end_at IS NULL
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
		AND emp.fire_at IS NULL
;

-- 8.현재 재직 중인 각 직원의 이름, 성별, 직책(title)을 조회하세요.
SELECT 
	emp.`name`
	,emp.gender
	,titl.title
FROM employees emp 
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
		AND emp.fire_at IS NULL 
		AND tite.end_at IS NULL
	JOIN titles titl 
		ON tite.title_code = titl.title_code
;

-- 9. 현재 가장 높은 연봉을 받는 상위 5명의 직원 ID와 연봉을 조회하세요.
SELECT 
	emp.emp_id
	,sal.salary
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id 
		AND emp.fire_at IS NULL
		AND sal.end_at IS NULL
ORDER BY sal.salary DESC
LIMIT 5
;

-- 10. 각 부서의 현재 평균 연봉을 계산하고, 평균 연봉이 60000 이상인 부서만 조회하세요.
SELECT
	depe.dept_code
	,AVG(sal.salary) avg_salary 
FROM salaries sal 
	JOIN department_emps depe
		ON sal.emp_id = depe.emp_id
		AND sal.end_at IS NULL
		AND depe.end_at IS NULL
GROUP BY depe.dept_code
	HAVING avg_salary >= 60000000
;
















