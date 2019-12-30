/* 
MODIF RM:

ajout year dans weekday
modif code airport
ajout year dans route

*/


SOURCE clear.sql;

SOURCE schema.sql;

SOURCE proc.sql;

SELECT SUM(R.nbPassenger) 
FROM Booking as B INNER JOIN Reservation as R ON B.bookingNumber=R.reservationNumber 
WHERE R.flight=flightnumber;
	
/*SELECT calculateFreeSeats(1);*/
