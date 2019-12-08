/*
Lab 2 report

Charles Blanchard (chabl044)
Justin Ruaux (jusru942)

*/


/*
Drop all user created tables that have been created when solving the lab
*/

DROP TABLE IF EXISTS jbsale CASCADE;
DROP TABLE IF EXISTS jbsupply CASCADE;
DROP TABLE IF EXISTS jbdebit CASCADE;
DROP TABLE IF EXISTS jbparts CASCADE;
DROP TABLE IF EXISTS jbitem CASCADE;
DROP TABLE IF EXISTS jbsupplier CASCADE;
DROP TABLE IF EXISTS jbdept CASCADE;
DROP TABLE IF EXISTS jbstore CASCADE;

DROP TABLE IF EXISTS jbtransDebit CASCADE;
DROP TABLE IF EXISTS jbtransDeposit CASCADE;
DROP TABLE IF EXISTS jbtransWithdrawal CASCADE;
DROP TABLE IF EXISTS jbtransaction CASCADE;
DROP TABLE IF EXISTS jbcustomer CASCADE;
DROP TABLE IF EXISTS jbaccount CASCADE;

ALTER TABLE jbmanager DROP FOREIGN KEY IF EXISTS fk_manager_employee;
ALTER TABLE jbemployee DROP FOREIGN KEY IF EXISTS fk_employee_manager;

DROP TABLE IF EXISTS jbemployee CASCADE;
DROP TABLE IF EXISTS jbmanager CASCADE;

DROP TABLE IF EXISTS jbcustomer CASCADE;

DROP TABLE IF EXISTS jbcity CASCADE;

DROP VIEW IF EXISTS debitCost CASCADE;



/* Have the source scripts in the file so it is easy to recreate!*/

SOURCE company_schema.sql
SOURCE company_data.sql



SELECT 'Lab2' AS 'Message';

/*
Question 3 :
*/

/*
We may need to calculate the salary of a manager. To do that, we add
the salary of its employee part and its bonus.
Therefore , bonus attribute need to be equal to something no
matter what. We initializize it to 0.
*/

/* jbmanager creation and filling */
CREATE TABLE jbmanager
(	
	id INT,
    bonus INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_manager PRIMARY KEY(id)
);


INSERT INTO jbmanager(id)
(SELECT manager FROM jbemployee WHERE jbemployee.manager IS NOT NULL)
UNION
(SELECT manager FROM jbdept WHERE jbdept.manager IS NOT NULL);


/* Constraint edition */
ALTER TABLE jbmanager ADD CONSTRAINT fk_manager_employee FOREIGN KEY (id) REFERENCES jbemployee(id);	

ALTER TABLE jbemployee DROP CONSTRAINT IF EXISTS fk_emp_mgr;
ALTER TABLE jbemployee ADD CONSTRAINT fk_employee_manaaager FOREIGN KEY (manager) REFERENCES jbmanager(id) ON DELETE SET NULL;

ALTER TABLE jbdept DROP FOREIGN KEY IF EXISTS fk_dept_mgr;

ALTER TABLE jbdept ADD CONSTRAINT fk_dept_mgr FOREIGN KEY (manager) REFERENCES jbmanager(id) ON DELETE SET NULL;


/*
Question 4 : 
*/

/* Incresing the bonus of all dept manager by 10000. */
UPDATE jbmanager 
SET bonus = bonus + 10000
WHERE id IN (SELECT manager FROM jbdept);

SELECT * from jbmanager;



/*
Question 5 :
*/

/* Tables creation */
CREATE TABLE jbaccount
(
	accountNumber INT,
    balance INT DEFAULT 0,
    customer INT,
    CONSTRAINT pk_account PRIMARY KEY(accountNumber)
) ENGINE=InnoDB;

CREATE TABLE jbcustomer
(
	id INT,
	name VARCHAR(20),
	streetAdress VARCHAR(40),
	city INT,
    CONSTRAINT pk_customer PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE jbtransaction
(
	transactionNumber INT,
	accountNumber INT NOT NULL,
	amount INT,
	employee INT NOT NULL,
	sdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_transaction PRIMARY KEY(transactionNumber)
) ENGINE=InnoDB;

CREATE TABLE jbtransDebit
(
	transactionNumber INT,
    CONSTRAINT pk_transDebit PRIMARY KEY(transactionNumber)
) ENGINE=InnoDB;

CREATE TABLE jbtransWithdrawal
(
	transactionNumber INT,
    CONSTRAINT pk_transWithdrawal PRIMARY KEY(transactionNumber)
) ENGINE=InnoDB;

CREATE TABLE jbtransDeposit
(
	transactionNumber INT,
    CONSTRAINT pk_transDeposit PRIMARY KEY(transactionNumber)
) ENGINE=InnoDB;


/* Foreign key addition */

ALTER TABLE jbaccount ADD CONSTRAINT fk_account_customer 
FOREIGN KEY (customer) REFERENCES jbcustomer(id);

ALTER TABLE jbcustomer ADD CONSTRAINT fk_customer_city
FOREIGN KEY (city) REFERENCES jbcity(id);

ALTER TABLE jbtransaction ADD CONSTRAINT fk_transaction_account 
FOREIGN KEY (accountNumber) REFERENCES jbaccount(accountNumber);

ALTER TABLE jbtransaction ADD CONSTRAINT fk_transaction_employee
FOREIGN KEY (employee) REFERENCES jbemployee(id);


ALTER TABLE jbtransDebit ADD CONSTRAINT fk_transDebit_transaction
FOREIGN KEY (transactionNumber) REFERENCES jbtransaction(transactionNumber);

ALTER TABLE jbtransWithdrawal ADD CONSTRAINT fk_transWithdrawal_transaction
FOREIGN KEY (transactionNumber) REFERENCES jbtransaction(transactionNumber);

ALTER TABLE jbtransDeposit ADD CONSTRAINT fk_transDeposit_transaction
FOREIGN KEY (transactionNumber) REFERENCES jbtransaction(transactionNumber);



/* Random customer insertion */

INSERT INTO jbcustomer VALUES
(707956, 'Steve Stringer', '4776 Poplar Lane', 900),
(703141, 'Lauri Lerma', '105 Coburn Hollow Road', 941),
(476419, 'Bruce Osborn', '3880 Spring Street', 752),
(885363, 'Christopher Numbers', '1871 Overlook Drive', 981),
(229822, 'Teresa Rodriguez', '3571 Goldie Lane', 100),
(896594, 'Dorothy Puckett', '897 Pratt Avenue', 802);


/* Insertion of new account with account number present in jbdebit and
created customer */

/* We have an unwanted result here:
All account are owned by the same customer.
It's not a problem as a customer can have several account but it's not
a good example.
*/

INSERT INTO jbaccount(accountNumber,customer)
(
	SELECT D.account, C.id 
	FROM jbdebit as D INNER JOIN jbcustomer as C
	GROUP BY D.account
);

/* Insertion of transactions from the old jbdebit, with calculation 
of amount thanks to lab 1 query */

CREATE VIEW debitCost AS
	SELECT S.debit, SUM(S.quantity* I.price) as total
	FROM jbsale as S, jbitem as I
	WHERE S.item=I.id
	GROUP BY S.debit;

INSERT INTO jbtransaction
(
	SELECT D.id, D.account, C.total, D.employee, D.sdate FROM jbdebit as D INNER JOIN debitCost as C ON D.id = C.debit
);


/* Initialization of new jbtransDebit*/

INSERT INTO jbtransDebit
(
	SELECT transactionNumber FROM jbtransaction
);

/* Update of jbsale foreign key (not anymore on jbdebit) */

ALTER TABLE jbsale DROP FOREIGN KEY fk_sale_debit;

ALTER TABLE jbsale ADD CONSTRAINT fk_sale_transDebit
FOREIGN KEY (debit) REFERENCES jbtransDebit(transactionNumber);

/* Deletion of jbdebit */

DROP TABLE IF EXISTS jbdebit CASCADE;
