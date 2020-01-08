/* 
ATTENTION:
CREDIT CARD: entité à part ou dans booking ?

*/


SOURCE clear.sql;

SOURCE schema.sql;

SOURCE proc.sql;


SELECT "Testing answer for 6, handling reservations and bookings" as "Message";
SELECT "Filling database with flights" as "Message";

/*Fill the database with data */


CALL addYear(2010, 2.3);
CALL addDay(2010,"Monday",1);
CALL addDestination("MIT","Minas Tirith","Mordor");
CALL addDestination("HOB","Hobbiton","The Shire");
CALL addRoute("MIT","HOB",2010,2000);
CALL addFlight("MIT","HOB", 2010, "Monday", "09:00:00");
CALL addFlight("MIT","HOB", 2010, "Monday", "21:00:00");



SELECT "Test 1: Adding a reservation, expected OK result" as "Message";
CALL addReservation("MIT","HOB",2010,1,"Monday","09:00:00",3,@a);
SELECT "Check that the reservation number is returned properly (any number will do):" AS "Message",@a AS "Res. number returned"; 

SELECT "Test 2: Adding a reservation with incorrect flightdetails. Expected answer: There exist no flight for the given route, date and time" as "Message";
CALL addReservation("MIT","HOB",2010,1,"Tuesday","21:00:00",3,@b); 

SELECT "Test 3: Adding a reservation when there are not enough seats. Expected answer: There are not enough seats available on the chosen flight" as "Message";
CALL addReservation("MIT","HOB",2010,1,"Monday","09:00:00",61,@c); 
/*
SELECT "Test 4.1: Adding a passenger. Expected OK result" as "Message";
CALL addPassenger(@a,00000001,"Frodo Baggins");

SELECT "Test 4.2: Test whether the same passenger can be added to other reservations. For this test, first add another reservation" as "Message";
CALL addReservation("MIT","HOB",2010,1,"Monday","21:00:00",4,@e);
SELECT @e AS "Reservation number";

SELECT "Now testing. Expected OK result" as "Message";
CALL addPassenger(@e,00000001,"Frodo Baggins"); 

SELECT "Test 5: Adding a passenger with incorrect reservation number. Expected result: The given reservation number does not exist" as "Message";
CALL addPassenger(9999999,00000001,"Frodo Baggins"); 

SELECT "Test 6: Adding a contact. Expected OK result" as "Message";
CALL addContact(@a,00000001,"frodo@magic.mail",080667989); 

SELECT "Test 7: Adding a contact with incorrect reservation number. Expected result: The given reservation number does not exist" as "Message";
CALL addContact(99999,00000001,"frodo@magic.mail",080667989); 

SELECT "Test 8: Adding a contact that is not a passenger on the reservation. Expected result: The person is not a passenger of the reservation" as "Message";
CALL addContact(@a,00000099,"frodo@magic.mail",080667989); 

SELECT "Test 9: Making a payment. Expected OK result" as "Message";
CALL addPayment (@a, "Gandalf", 6767676767676767); 

SELECT "Test 10: Making a payment to a reservation with incorrect reservation number. Expected result: The given reservation number does not exist" as "Message";
CALL addPayment (999999, "Gandalf", 6767676767676767);

SELECT "Test 11: Making a payment to a reservation with no contact. First setting up reservation" as "Message";
CALL addReservation("MIT","HOB",2010,1,"Monday","09:00:00",1,@d); 
CALL addPassenger(@d,00000002,"Sam Gamgee"); 

SELECT "Now testing. Expected result: The reservation has no contact yet" as "Message";
CALL addPayment (@d, "Gandalf", 6767676767676767); 

SELECT "Test 12: Adding a passenger to an already payed reservation. Expected result: The booking has already been payed and no futher passengers can be added" as "Message";
CALL addPassenger(@a,00000003,"Merry Pippins"); 
*/
