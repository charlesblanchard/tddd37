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
Question 1:
*/

SELECT *
FROM jbemployee;

/*
+------+--------------------+--------+---------+-----------+-----------+
| id   | name               | salary | manager | birthyear | startyear |
+------+--------------------+--------+---------+-----------+-----------+
|   10 | Ross, Stanley      |  15908 |     199 |      1927 |      1945 |
|   11 | Ross, Stuart       |  12067 |    NULL |      1931 |      1932 |
|   13 | Edwards, Peter     |   9000 |     199 |      1928 |      1958 |
|   26 | Thompson, Bob      |  13000 |     199 |      1930 |      1970 |
|   32 | Smythe, Carol      |   9050 |     199 |      1929 |      1967 |
|   33 | Hayes, Evelyn      |  10100 |     199 |      1931 |      1963 |
|   35 | Evans, Michael     |   5000 |      32 |      1952 |      1974 |
|   37 | Raveen, Lemont     |  11985 |      26 |      1950 |      1974 |
|   55 | James, Mary        |  12000 |     199 |      1920 |      1969 |
|   98 | Williams, Judy     |   9000 |     199 |      1935 |      1969 |
|  129 | Thomas, Tom        |  10000 |     199 |      1941 |      1962 |
|  157 | Jones, Tim         |  12000 |     199 |      1940 |      1960 |
|  199 | Bullock, J.D.      |  27000 |    NULL |      1920 |      1920 |
|  215 | Collins, Joanne    |   7000 |      10 |      1950 |      1971 |
|  430 | Brunet, Paul C.    |  17674 |     129 |      1938 |      1959 |
|  843 | Schmidt, Herman    |  11204 |      26 |      1936 |      1956 |
|  994 | Iwano, Masahiro    |  15641 |     129 |      1944 |      1970 |
| 1110 | Smith, Paul        |   6000 |      33 |      1952 |      1973 |
| 1330 | Onstad, Richard    |   8779 |      13 |      1952 |      1971 |
| 1523 | Zugnoni, Arthur A. |  19868 |     129 |      1928 |      1949 |
| 1639 | Choy, Wanda        |  11160 |      55 |      1947 |      1970 |
| 2398 | Wallace, Maggie J. |   7880 |      26 |      1940 |      1959 |
| 4901 | Bailey, Chas M.    |   8377 |      32 |      1956 |      1975 |
| 5119 | Bono, Sonny        |  13621 |      55 |      1939 |      1963 |
| 5219 | Schwarz, Jason B.  |  13374 |      33 |      1944 |      1959 |
+------+--------------------+--------+---------+-----------+-----------+
*/

/* 
Question 2:
*/

SELECT name
FROM jbdept
ORDER BY name ASC;

/*
+------------------+
| name             |
+------------------+
| Bargain          |
| Book             |
| Candy            |
| Children's       |
| Children's       |
| Furniture        |
| Giftwrap         |
| Jewelry          |
| Junior Miss      |
| Junior's         |
| Linens           |
| Major Appliances |
| Men's            |
| Sportswear       |
| Stationary       |
| Toys             |
| Women's          |
| Women's          |
| Women's          |
+------------------+
*/

/* 
Question 3:
*/

SELECT name
FROM jbparts
WHERE QOH=0;

/*
+-------------------+
| name              |
+-------------------+
| card reader       |
| card punch        |
| paper tape reader |
| paper tape punch  |
+-------------------+
*/

/* 
Question 4:
*/

SELECT name, salary
FROM jbemployee
WHERE salary>=9000 AND salary<=10000;

/*
+----------------+--------+
| name           | salary |
+----------------+--------+
| Edwards, Peter |   9000 |
| Smythe, Carol  |   9050 |
| Williams, Judy |   9000 |
| Thomas, Tom    |  10000 |
+----------------+--------+
*/

/* 
Question 5:
*/

SELECT name, STARTYEAR-BIRTHYEAR as startage
FROM jbemployee;

/*
+--------------------+----------+
| name               | startage |
+--------------------+----------+
| Ross, Stanley      |       18 |
| Ross, Stuart       |        1 |
| Edwards, Peter     |       30 |
| Thompson, Bob      |       40 |
| Smythe, Carol      |       38 |
| Hayes, Evelyn      |       32 |
| Evans, Michael     |       22 |
| Raveen, Lemont     |       24 |
| James, Mary        |       49 |
| Williams, Judy     |       34 |
| Thomas, Tom        |       21 |
| Jones, Tim         |       20 |
| Bullock, J.D.      |        0 |
| Collins, Joanne    |       21 |
| Brunet, Paul C.    |       21 |
| Schmidt, Herman    |       20 |
| Iwano, Masahiro    |       26 |
| Smith, Paul        |       21 |
| Onstad, Richard    |       19 |
| Zugnoni, Arthur A. |       21 |
| Choy, Wanda        |       23 |
| Wallace, Maggie J. |       19 |
| Bailey, Chas M.    |       19 |
| Bono, Sonny        |       24 |
| Schwarz, Jason B.  |       15 |
+--------------------+----------+
*/

/* 
Question 6:
*/

SELECT name
FROM jbemployee
WHERE name LIKE '%son,%';

/*
+---------------+
| name          |
+---------------+
| Thompson, Bob |
+---------------+
*/

/* 
Question 7:
*/

SELECT *
FROM jbitem
WHERE supplier IN 
	(
	SELECT id
	FROM jbsupplier
	WHERE name='Fisher-Price'
	);

/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
+-----+-----------------+------+-------+------+----------+
*/

/* 
Question 8:
*/

SELECT I.*
FROM jbitem as I, jbsupplier as S
WHERE S.name='Fisher-Price' AND I.supplier = S.id;

/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
+-----+-----------------+------+-------+------+----------+
*/

/* 
Question 9:
*/

SELECT *
FROM jbcity as C
WHERE C.id IN 
	(
	SELECT S.city
	FROM jbsupplier as S
	);

/*
+-----+----------------+-------+
| id  | name           | state |
+-----+----------------+-------+
|  10 | Amherst        | Mass  |
|  21 | Boston         | Mass  |
| 100 | New York       | NY    |
| 106 | White Plains   | Neb   |
| 118 | Hickville      | Okla  |
| 303 | Atlanta        | Ga    |
| 537 | Madison        | Wisc  |
| 609 | Paxton         | Ill   |
| 752 | Dallas         | Tex   |
| 802 | Denver         | Colo  |
| 841 | Salt Lake City | Utah  |
| 900 | Los Angeles    | Calif |
| 921 | San Diego      | Calif |
| 941 | San Francisco  | Calif |
| 981 | Seattle        | Wash  |
+-----+----------------+-------+
*/

/* 
Question 10:
*/

SELECT name,color
FROM jbparts
WHERE weight >
	(
	SELECT weight
	FROM jbparts
	WHERE name='card reader'
	);

/*
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
*/

/* 
Question 11:
*/

SELECT A.name,A.color
FROM jbparts as A, jbparts as B
WHERE B.name='card reader' AND A.weight > B.weight;

/*
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
*/

/* 
Question 12:
*/

SELECT AVG(weight) as averageWeightBlackParts
FROM jbparts
WHERE color='black';

/*
+-------------------------+
| averageWeightBlackParts |
+-------------------------+
|                347.2500 |
+-------------------------+
*/

/* 
Question 13:
*/

SELECT Su.name, SUM(S.quan*P.weight) as totalWeight
FROM jbsupplier as Su 
	JOIN jbsupply as S ON Su.id=S.supplier
	JOIN jbparts as P ON P.id=S.part
WHERE Su.city IN
(
	SELECT id
	FROM jbcity
	WHERE state='Mass'
)
GROUP BY S.supplier;


/*
+--------------+-------------+
| name         | totalWeight |
+--------------+-------------+
| Fisher-Price |     1135000 |
| DEC          |        3120 |
+--------------+-------------+
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
	
	CONSTRAINT fk_jbitemCustom_supplier FOREIGN KEY(supplier) references jbsupplier(id) ON DELETE CASCADE,
	CONSTRAINT fk_jbitemCustom_dept FOREIGN KEY(dept) references jbdept(id)
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
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  26 | Earrings        |   14 |  1000 |   20 |      199 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
*/

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
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  26 | Earrings        |   14 |  1000 |   20 |      199 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
*/

/* 
Question 16:
*/

/*
A table is static: jbitemCustomTable won't be modified if we modify jbitem.
A view is dynamic: for example, if we modify jbitem, then jbitemCustomView
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
+--------+-------+
| debit  | total |
+--------+-------+
| 100581 |  2050 |
| 100582 |  1000 |
| 100586 | 13446 |
| 100592 |   650 |
| 100593 |   430 |
| 100594 |  3295 |
+--------+-------+
*/

/*
Question 18:
*/

CREATE VIEW debitCost2 AS
	SELECT S.debit, SUM(S.quantity * I.price) as total
	FROM jbsale as S INNER JOIN jbitem as I ON S.item=I.id
	GROUP BY S.debit;

SELECT * FROM debitCost2;

/*
+--------+-------+
| debit  | total |
+--------+-------+
| 100581 |  2050 |
| 100582 |  1000 |
| 100586 | 13446 |
| 100592 |   650 |
| 100593 |   430 |
| 100594 |  3295 |
+--------+-------+
*/

/* 
    We are using an INNER JOIN. In our case, we want the intersection of 
jbsale and jbitem regarding one condition.
    LEFT JOIN or RIGHT JOIN would have given differents result (NULL tuples)
*/

/*
Question 19:
*/

/* a. */

DELETE FROM jbsale where item IN
(
SELECT id
FROM jbitem
WHERE supplier IN
(
SELECT id
	FROM jbsupplier
	WHERE city IN
	(
		SELECT id
		FROM jbcity
		WHERE name='Los Angeles'
	)
));

DELETE FROM jbitem where supplier IN
(
	SELECT id
	FROM jbsupplier
	WHERE city IN
	(
		SELECT id
		FROM jbcity
		WHERE name='Los Angeles'
	)
);

DELETE FROM jbsupplier WHERE city IN
(
SELECT id
FROM jbcity
WHERE name='Los Angeles'
);

SELECT * FROM jbsupplier;

/*
+-----+--------------+------+
| id  | name         | city |
+-----+--------------+------+
|   5 | Amdahl       |  921 |
|  15 | White Stag   |  106 |
|  20 | Wormley      |  118 |
|  33 | Levi-Strauss |  941 |
|  42 | Whitman's    |  802 |
|  62 | Data General |  303 |
|  67 | Edger        |  841 |
|  89 | Fisher-Price |   21 |
| 122 | White Paper  |  981 |
| 125 | Playskool    |  752 |
| 213 | Cannon       |  303 |
| 241 | IBM          |  100 |
| 440 | Spooley      |  609 |
| 475 | DEC          |   10 |
| 999 | A E Neumann  |  537 |
+-----+--------------+------+
*/

/* b. */

/*
    In order to be able to delete a supplier in jbsupplier, it is necessary to
also delete all the depedencies it has (foreign key contraint).
This can be done by specifying "ON DELETE CASCADE" while declaring the
constraint or by modifying it afterwards
*/

/*
Question 20:
*/

CREATE VIEW jbsale_supply(supplier, item, quantity) AS
SELECT jbsupplier.name, jbitem.name, jbsale.quantity
FROM jbsupplier JOIN jbitem ON jbsupplier.id=jbitem.supplier LEFT JOIN jbsale ON jbsale.item=jbitem.id;

SELECT supplier, SUM(quantity) AS sum FROM jbsale_supply
GROUP BY supplier;

/*
+--------------+------+
| supplier     | sum  |
+--------------+------+
| Cannon       |    6 |
| Fisher-Price | NULL |
| Levi-Strauss |    1 |
| Playskool    |    2 |
| White Stag   |    4 |
| Whitman's    |    2 |
+--------------+------+
*/