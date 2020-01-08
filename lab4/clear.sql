SELECT "Database cleaning" as "Message";

ALTER TABLE Route DROP FOREIGN KEY IF EXISTS fk_route_arrival;
ALTER TABLE Route DROP FOREIGN KEY IF EXISTS fk_route_departure;

ALTER TABLE WeekDay DROP FOREIGN KEY IF EXISTS fk_weekday_year;

ALTER TABLE WeeklySchedule DROP FOREIGN KEY IF EXISTS fk_weeklyschedule_route ;
ALTER TABLE WeeklySchedule DROP FOREIGN KEY IF EXISTS fk_weeklyschedule_day;
ALTER TABLE WeeklySchedule DROP FOREIGN KEY IF EXISTS fk_weeklyschedule_brianAir;

ALTER TABLE Flight DROP FOREIGN KEY IF EXISTS fk_flight_scheduleid;


ALTER TABLE Reservation DROP FOREIGN KEY IF EXISTS fk_reservation_flight;
ALTER TABLE Reservation DROP FOREIGN KEY IF EXISTS fk_reservation_contact;


ALTER TABLE Booking DROP FOREIGN KEY IF EXISTS fk_booking_bookingNumber;
ALTER TABLE Booking DROP FOREIGN KEY IF EXISTS fk_booking_creditCard;


ALTER TABLE TicketList DROP FOREIGN KEY IF EXISTS fk_ticketlist_passportNumber;
ALTER TABLE TicketList DROP FOREIGN KEY IF EXISTS fk_ticketlist_reservationNumber;

ALTER TABLE Passenger DROP FOREIGN KEY IF EXISTS fk_passenger_reservation;

ALTER TABLE Contact DROP FOREIGN KEY IF EXISTS fk_contact_passportNumber;

ALTER TABLE PotentialBoarding DROP FOREIGN KEY IF EXISTS fk_potentialboarding_passport;
ALTER TABLE PotentialBoarding DROP FOREIGN KEY IF EXISTS fk_potentialboarding_reservation;

DROP TABLE IF EXISTS TicketList CASCADE;
DROP TABLE IF EXISTS Booking CASCADE;
DROP TABLE IF EXISTS Reservation CASCADE;
DROP TABLE IF EXISTS CreditCard CASCADE;
DROP TABLE IF EXISTS Contact CASCADE;
DROP TABLE IF EXISTS Price CASCADE;
DROP TABLE IF EXISTS Flight CASCADE;
DROP TABLE IF EXISTS WeeklySchedule CASCADE;
DROP TABLE IF EXISTS Route CASCADE;
DROP TABLE IF EXISTS Airport CASCADE;
DROP TABLE IF EXISTS WeekDay CASCADE;
DROP TABLE IF EXISTS BrianAir CASCADE;
DROP TABLE IF EXISTS Passenger CASCADE;
DROP TABLE IF EXISTS PotentialBoarding CASCADE;

DROP PROCEDURE IF EXISTS addYear;
DROP PROCEDURE IF EXISTS addDay;
DROP PROCEDURE IF EXISTS addDestination;
DROP PROCEDURE IF EXISTS addRoute;
DROP PROCEDURE IF EXISTS addFlight;

DROP FUNCTION IF EXISTS calculateFreeSeats;
DROP FUNCTION IF EXISTS calculateBookedSeats;

DROP TRIGGER IF EXISTS ticketIssuing;

DROP PROCEDURE IF EXISTS addReservation;
DROP PROCEDURE IF EXISTS addPassenger;
DROP PROCEDURE IF EXISTS addContact;
DROP PROCEDURE IF EXISTS addPayment;

