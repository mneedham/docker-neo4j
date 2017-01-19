//Importing the TrumpWorld

// Data constraints
CREATE CONSTRAINT ON (o:Organization) ASSERT o.name IS UNIQUE;
CREATE CONSTRAINT ON (p:Person) ASSERT p.name IS UNIQUE;

// Connect organizations with other organizations from the 1st tab
WITH 'https://docs.google.com/spreadsheets/u/1/d/1Z5Vo5pbvxKJ5XpfALZXvCzW26Cl4we3OaN73K9Ae5Ss/export?format=tsv&id=1Z5Vo5pbvxKJ5XpfALZXvCzW26Cl4we3OaN73K9Ae5Ss&gid=634968401' AS url
LOAD CSV WITH HEADERS FROM url AS row FIELDTERMINATOR '\t'
MERGE (o1:Organization {name:row.`Organization A`})
MERGE (o2:Organization {name:row.`Organization B`})
CREATE (o1)-[con:CONNECTED_TO]->(o2)
SET con.connection=row.Connection, con.source=row.`Source(s)`;

// Connect people with organizations from the 2nd tab

WITH 'https://docs.google.com/spreadsheets/u/1/d/1Z5Vo5pbvxKJ5XpfALZXvCzW26Cl4we3OaN73K9Ae5Ss/export?format=tsv&id=1Z5Vo5pbvxKJ5XpfALZXvCzW26Cl4we3OaN73K9Ae5Ss&gid=1368567920' AS url
LOAD CSV WITH HEADERS FROM url AS row FIELDTERMINATOR '\t'
MERGE (p:Person {name:row.Person})
MERGE (o:Organization {name:row.Organization})
CREATE (p)-[con:INVOLVED_WITH]->(o)
SET con.connection=row.Connection, con.source=row.`Source(s)`;

// Connect people with other people from the 3rd tab

WITH 'https://docs.google.com/spreadsheets/u/1/d/1Z5Vo5pbvxKJ5XpfALZXvCzW26Cl4we3OaN73K9Ae5Ss/export?format=tsv&id=1Z5Vo5pbvxKJ5XpfALZXvCzW26Cl4we3OaN73K9Ae5Ss&gid=905294723' AS url
LOAD CSV WITH HEADERS FROM url AS row FIELDTERMINATOR '\t'
MERGE (p1:Person {name:row.`Person A`})
MERGE (p2:Person {name:row.`Person B`})
CREATE (p2)-[con:RELATED_TO]->(p1)
SET con.connection=row.Connection, con.source=row.`Source(s)`;
