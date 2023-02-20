CREATE TABLE emptable (
    eno integer,
    lname varchar(10),
    fname varchar(10),
    street varchar(20),
    city varchar(15),
    st varchar(2),
    zip varchar(5),
    dept varchar(4),
    payrate numeric(13,2),
    com numeric(3,2)
);


INSERT INTO emptable VALUES (123, 'Doe', 'John', '123, Nowhere Lane', 'Noplace', 'NA', '00100', 'DEP1', 200.00, 1.23);
INSERT INTO emptable VALUES (456, 'Smith', 'Jane', '456, Someplace Rd.', 'Somewhere', 'NA', '00111', 'DEP2', 130.00, 3.45);
INSERT INTO emptable VALUES (124, 'Doe', 'Jams', '123, Nowhere Lane', 'Noplace', 'NA', '00100', 'DEP1', 300.00, 2);
INSERT INTO emptable VALUES (125, 'Doe', 'Janet', '123, Nowhere Lane', 'Noplace', 'NA', '00100', 'DEP1',400.00, 1.23);
INSERT INTO emptable VALUES (126, 'Doe', 'Jacab', '123, Nowhere Lane', 'Noplace', 'NA', '00100', 'DEP1', 500.00, 1.23);
INSERT INTO emptable VALUES (400, 'Smith', 'John', '123, Nowhere Lane', 'Noplace', 'NA', '00100', 'DEP2', 600.00, 1.23);

