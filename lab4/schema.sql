SELECT "Tables creation" as "Message";

CREATE TABLE Airport
(
	code VARCHAR(3),
    name VARCHAR(30),
    country VARCHAR(30),
    CONSTRAINT pk_airport PRIMARY KEY(code)
) ENGINE=InnoDB;


CREATE TABLE Route
(
	id INT AUTO_INCREMENT,
    arrival VARCHAR(3),
    departure VARCHAR(3),
    price DOUBLE,
    year INT,
    CONSTRAINT pk_route PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE WeekDay
(
	id INT AUTO_INCREMENT,
    name VARCHAR(10),
    year INT,
    factor DOUBLE,
    CONSTRAINT pk_weekday PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE BrianAir
(
	year INT,
    profitFactor DOUBLE,
    CONSTRAINT pk_brianair PRIMARY KEY(year)
) ENGINE=InnoDB;

CREATE TABLE WeeklySchedule
(
	id INT AUTO_INCREMENT,
	route INT,
    year INT,
    day INT,
    time TIME,
    CONSTRAINT pk_weeklyschedule PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE Flight
(
	flightNumber INT AUTO_INCREMENT,
	scheduleId INT,
    weekNumber INT,
    CONSTRAINT pk_flight PRIMARY KEY(flightNumber)
) ENGINE=InnoDB;


CREATE TABLE Reservation
(
	reservationNumber INT AUTO_INCREMENT,
	flight INT,
    nbPassenger INT,
    contact INT DEFAULT NULL,
    CONSTRAINT pk_reservation PRIMARY KEY(reservationNumber)
) ENGINE=InnoDB;

CREATE TABLE Booking
(
	bookingNumber INT,
	creditCard BIGINT,
    price INT,
    CONSTRAINT pk_booking PRIMARY KEY(bookingNumber)
) ENGINE=InnoDB;


CREATE TABLE CreditCard
(
	cardNumber BIGINT,
	owner VARCHAR(30),
    CONSTRAINT pk_creditCard PRIMARY KEY(cardNumber)
) ENGINE=InnoDB;

CREATE TABLE Contact
(
	passportNumber INT,
	phoneNumber BIGINT,
    email VARCHAR(30),
    CONSTRAINT pk_Contact PRIMARY KEY(passportNumber)
) ENGINE=InnoDB;

CREATE TABLE TicketList
(
	reservationNumber INT,
	ticketNumber INT,
    passportNumber INT,
    CONSTRAINT pk_ticketList PRIMARY KEY(ticketNumber)
) ENGINE=InnoDB;

CREATE TABLE Passenger
(
	passportNumber INT,
    name VARCHAR(30),
    CONSTRAINT pk_passenger_passport PRIMARY KEY(passportNumber)
) ENGINE=InnoDB;

CREATE TABLE PotentialBoarding
(
	reservationNumber INT,
	passportNumber INT
) ENGINE=InnoDB;
	

SELECT "Foreign key creation" as "Message";

ALTER TABLE Route ADD CONSTRAINT fk_route_arrival FOREIGN KEY (arrival) REFERENCES Airport(code);
ALTER TABLE Route ADD CONSTRAINT fk_route_departure  FOREIGN KEY (departure) REFERENCES Airport(code);
ALTER TABLE Route ADD CONSTRAINT fk_route_year  FOREIGN KEY (year) REFERENCES BrianAir(year);

ALTER TABLE WeekDay ADD CONSTRAINT fk_weekday_year  FOREIGN KEY (year) REFERENCES BrianAir(year);

ALTER TABLE WeeklySchedule ADD CONSTRAINT fk_weeklyschedule_route FOREIGN KEY (route) REFERENCES Route(id);
ALTER TABLE WeeklySchedule ADD CONSTRAINT fk_weeklyschedule_day FOREIGN KEY (day) REFERENCES WeekDay(id);
ALTER TABLE WeeklySchedule ADD CONSTRAINT fk_weeklyschedule_brianAir FOREIGN KEY (year) REFERENCES BrianAir(year);

ALTER TABLE Flight ADD CONSTRAINT fk_flight_scheduleid FOREIGN KEY (scheduleId) REFERENCES WeeklySchedule(id);


ALTER TABLE Reservation ADD CONSTRAINT fk_reservation_flight FOREIGN KEY (flight) REFERENCES Flight(flightNumber);
ALTER TABLE Reservation ADD CONSTRAINT fk_reservation_contact FOREIGN KEY (contact) REFERENCES Contact(passportNumber);


ALTER TABLE Booking ADD CONSTRAINT fk_booking_bookingNumber FOREIGN KEY (bookingNumber) REFERENCES Reservation(reservationNumber);
ALTER TABLE Booking ADD CONSTRAINT fk_booking_creditCard FOREIGN KEY (creditCard) REFERENCES CreditCard(cardNumber);



ALTER TABLE TicketList ADD CONSTRAINT fk_ticketlist_passportNumber FOREIGN KEY (passportNumber) REFERENCES Passenger(passportNumber);
ALTER TABLE TicketList ADD CONSTRAINT fk_ticketlist_reservationNumber FOREIGN KEY (reservationNumber) REFERENCES Booking(bookingNumber);


ALTER TABLE Contact ADD CONSTRAINT fk_contact_passportNumber FOREIGN KEY (passportNumber) REFERENCES Passenger(passportNumber);

ALTER TABLE PotentialBoarding ADD CONSTRAINT fk_potentialboarding_reservation FOREIGN KEY (reservationNumber) REFERENCES Reservation(reservationNumber);
ALTER TABLE PotentialBoarding ADD CONSTRAINT fk_potentialboarding_passport FOREIGN KEY (passportNumber) REFERENCES Passenger(passportNumber);
