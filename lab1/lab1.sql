/*
Lab 1 report

Charles Blanchard (chabl044)
Justin Ruaux (jusru942)

*/

/*
Drop all user created tables that have been created when solving the lab
*/

DROP TABLE IF EXISTS custom_table CASCADE;
DROP TABLE IF EXISTS jbitemCustomTable CASCADE;
DROP VIEW IF EXISTS jbitemCustomView CASCADE;
DROP VIEW IF EXISTS debitCost1 CASCADE;
DROP VIEW IF EXISTS debitCost2 CASCADE;
DROP VIEW IF EXISTS jbsale_supply CASCADE;
DROP VIEW IF EXISTS tempo CASCADE;

/* Have the source scripts in the file so it is easy to recreate!*/

SOURCE company_schema.sql;
SOURCE company_data.sql;

/*
Question 1: Print a message that says "hello world"
*/

SELECT 'hello world!' AS 'message';

/* Show the output for every question.
+--------------+
| message      |
+--------------+
| hello world! |
+--------------+
1 row in set (0.00 sec)
*/ 

/*
Question 14: 
*/

CREATE TABLE jbitemCustomTable
(
	id INT,
	name VARCHAR(20),
	dept INT,
	price INT,
	qoh INT,
	supplier INT,
	
	CONSTRAINT pk_jbitemCustom PRIMARY KEY(id),
	
	CONSTRAINT fk_jbitemCustom_supplier FOREIGN KEY(supplier) references jbsupplier(id) ON DELETE CASCADE
	
);

INSERT INTO jbitemCustomTable
(
	SELECT *
	FROM jbitem
	WHERE price <
		(
		SELECT AVG(price)
		FROM jbitem
	)	
);

SELECT * FROM jbitemCustomTable;

/* 
Question 15:
*/

CREATE VIEW jbitemCustomView AS
	SELECT *
	FROM jbitem
	WHERE price <
	(
		SELECT AVG(price)
		FROM jbitem
	);

SELECT * FROM jbitemCustomView;

/* 
Question 16:

A table is static: jbitemCustom won't be modified if we modify jbitem.
A view is dynamic: for example, if we modify jbitem, then jbitemView
will be modified.

*/

/* 
Question 17:
*/

CREATE VIEW debitCost1 AS
	SELECT S.debit, SUM(S.quantity* I.price) as total
	FROM jbsale as S, jbitem as I
	WHERE S.item=I.id
	GROUP BY S.debit;
	
SELECT * FROM debitCost1;

/*
Question 18:
*/

CREATE VIEW debitCost2 AS
	SELECT S.debit, SUM(S.quantity * I.price) as total
	FROM jbsale as S INNER JOIN jbitem as I ON S.item=I.id
	GROUP BY S.debit;

SELECT * FROM debitCost2;

/* 

    EXPLIQUER PQ INNER JOIN 

*/

/*
Question 19:
*/

/* a. */

ALTER TABLE jbitem MODIFY CONSTRAINT fk_item_supplier FOREIGN KEY (supplier) REFERENCES jbsupplier(id) ON DELETE CASCADE;
ALTER TABLE jbsale MODIFY CONSTRAINT fk_sale_item FOREIGN KEY (item) REFERENCES jbitem(id) ON DELETE CASCADE;

DELETE FROM jbsupplier WHERE city IN
(
SELECT id
FROM jbcity
WHERE name='Los Angeles'
);

SELECT * FROM jbsupplier;

/* b. */

/*

    In order to be able to delete a supplier in jbsupplier, it is necessary to
also delete all the depedencies it has (foreign key contraint).
This can be done by specifying "ON DELETE CASCADE" while declaring the
constraint or by modifying it (as what we have done).

*/

/*
Question 20:
*/
CREATE VIEW tempo(supplier_name, item_name, item_id) AS
	SELECT jbsupplier.name, jbitem.name, jbitem.id
	FROM jbsupplier LEFT JOIN jbitem ON jbsupplier.id = jbitem.supplier;

CREATE VIEW jbsale_supply(supplier, item, quantity) AS
	SELECT tempo.supplier_name, tempo.item_name, jbsale.quantity
	FROM tempo LEFT JOIN jbsale ON jbsale.item = tempo.item_id;

SELECT supplier, sum(quantity) AS sum 
FROM jbsale_supply
GROUP BY supplier;


