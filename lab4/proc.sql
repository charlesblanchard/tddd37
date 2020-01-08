SELECT "Procedure creation" as "Message";

/* QUESTION 3 */

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
CREATE PROCEDURE addRoute (IN departure VARCHAR(3), IN arrival VARCHAR(3), IN year INT, IN price DOUBLE)
BEGIN
	INSERT INTO Route(arrival,departure,year,price) VALUES (arrival,departure,year,price);
END//
DELIMITER ;


/* QUESTION 4 */

DELIMITER //
CREATE PROCEDURE addFlight (IN departure VARCHAR(3), IN arrival VARCHAR(3), IN year INT, IN day VARCHAR(10), IN time TIME)
BEGIN
	INSERT INTO WeeklySchedule(route,year,day,time)
	SELECT R.id, year, D.id, time 
	FROM Route as R, WeekDay as D 
	WHERE R.arrival=arrival 
		AND R.departure=departure 
		AND R.year=year 
		AND D.name=day 
		AND D.year=year;
	
	BEGIN
		DECLARE cnt INT DEFAULT 1;
		WHILE cnt < 53 DO
			
			INSERT INTO Flight(scheduleId,weekNumber)
			SELECT S.id, cnt 
			FROM WeeklySchedule as S
			WHERE S.year=year
				AND S.time=time
				AND S.route IN 
					(
					SELECT id
					FROM Route R
					WHERE R.arrival=arrival 
						AND R.departure=departure 
						AND R.year=year
					)
				AND S.day IN
					(
					SELECT id
					FROM WeekDay D
					WHERE D.name=day AND D.year=year
					);
				
			SET cnt = cnt + 1;
		END WHILE;
	END;
END//
DELIMITER ;


DELIMITER //
CREATE FUNCTION calculateBookedSeats(flightnumber INT) RETURNS INT
BEGIN
	RETURN (SELECT COUNT(*)
	FROM TicketList T JOIN Reservation R ON R.flight = flightnumber);
END//
DELIMITER ;


DELIMITER //
CREATE FUNCTION calculateFreeSeats(flightnumber INT) RETURNS INT
BEGIN
	RETURN 40 - calculateBookedSeats(flightnumber);
END//
DELIMITER ;


/* QUESTION 5 */

DELIMITER //
CREATE TRIGGER ticketIssuing
BEFORE INSERT ON TicketList FOR EACH ROW
BEGIN
	SET NEW.ticketNumber = RAND();
END//
DELIMITER ;


/* QUESTION 6 */

DELIMITER //
CREATE PROCEDURE addReservation(IN departureAirportCode VARCHAR(3), IN arrivalAirportCode VARCHAR(3), IN year INT, IN week INT, IN day VARCHAR(10), IN time TIME, IN nbPassenger INT, OUT outputReservationNumber INT)
BEGIN
	DECLARE fNumber INT DEFAULT NULL;
	
	SELECT flightNumber INTO fNumber
	FROM Flight F
	WHERE F.weekNumber=week AND F.scheduleId IN 
	(
		SELECT id 
		FROM WeeklySchedule S 
		WHERE S.year=year 
			AND S.time=time 
			AND S.route IN 
			(
				SELECT id 
				FROM Route R 
				WHERE R.arrival=arrivalAirportCode AND R.departure=departureAirportCode AND R.year=year
			)
			AND S.day IN
			(
				SELECT id
				FROM WeekDay D
				WHERE D.name=day AND D.year=year
			)
	);
	
	IF fNumber IS NULL 
	THEN
		SELECT "There exist no flight for the given route, date and time" as "Message";
	ELSE
		IF nbPassenger > calculateFreeSeats(fNumber)
		THEN
			SELECT "There are not enough seats available on the chosen flight" as "Message";
		ELSE
			SELECT "OK" as "Message";
			INSERT INTO Reservation(flight,nbPassenger)	VALUES (fNumber, nbPassenger);
			SET outputReservationNumber=LAST_INSERT_ID();
		END IF;
	END IF;
END//
DELIMITER ;

/* il faut tester si la reservation existe */
DELIMITER //
CREATE PROCEDURE addPassenger(IN reservationNumber INT, IN passportNumber INT, IN name VARCHAR(30))
BEGIN
	INSERT INTO Passenger(passportNumber,name) VALUES (passportNumber, name);
	INSERT INTO PotentialBoarding(reservationNumber,passportNumber) VALUES (reservationNumber, passportNumber);
END//
DELIMITER ;


/* il faut tester si la reservation existe, si le passager existe et est dans la reservation */
DELIMITER //
CREATE PROCEDURE addContact(IN reservationNumber INT, IN passportNumber INT, IN email VARCHAR(30), IN phoneNumber BIGINT)
BEGIN
	INSERT INTO Contact(passportNumber,phoneNumber,email) VALUES (passportNumber, phoneNumber,email);
	/* update reservation */
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addPayment(IN reservationNumber INT, IN cardHolderName VARCHAR(30), IN creditCardNumber BIGINT)
BEGIN
	
END//
DELIMITER ;
