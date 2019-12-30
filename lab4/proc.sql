SELECT "Procedure creation" as "Message";


DELIMITER //
CREATE PROCEDURE addYear (IN year INT, IN factor DOUBLE)
BEGIN
	INSERT INTO BrianAir VALUES (year,factor);
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addDay (IN year INT, IN name VARCHAR(10), IN factor DOUBLE)
BEGIN
	INSERT INTO WeekDay(name,year,factor) VALUES (name,year,factor);
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addDestination (IN code VARCHAR(3), IN name VARCHAR(30), IN country VARCHAR(30))
BEGIN
	INSERT INTO Airport VALUES (code,name,country);
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addRoute (IN arrival VARCHAR(3), IN departure VARCHAR(3), IN year INT, IN price DOUBLE)
BEGIN
	INSERT INTO Route(arrival,departure,year,price) VALUES (arrival,departure,year,price);
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addFlight (IN arrival VARCHAR(3), IN departure VARCHAR(3), IN year INT, IN day VARCHAR(10), IN time TIME)
BEGIN
	INSERT INTO WeeklySchedule(route,year,day,time)
	SELECT R.id, year, D.id, time FROM Route as R, WeekDay as D WHERE R.arrival=arrival AND R.departure=departure AND R.year=year AND D.name=day AND D.year=year;
	
	BEGIN
		DECLARE cnt INT DEFAULT 1;
		WHILE cnt < 53 DO
		   INSERT INTO Flight(scheduleId,weekNumber)
		   SELECT R.id, cnt FROM Route as R, WeekDay as D WHERE R.arrival=arrival AND R.departure=departure AND R.year=year AND D.name=day AND D.year=year;
		   SET cnt = cnt + 1;
		END WHILE;
	END;

END//
DELIMITER ;


DELIMITER //
CREATE FUNCTION calculateFreeSeats(flightnumber INT)
RETURNS INT
BEGIN
	DECLARE R INT;
	SELECT SUM(R.nbPassenger) INTO R
	FROM Booking as B INNER JOIN Reservation as R ON B.bookingNumber=R.reservationNumber 
	WHERE R.flight = flightnumber;
	RETURN R;
END//
DELIMITER ;


