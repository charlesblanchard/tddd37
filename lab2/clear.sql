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
