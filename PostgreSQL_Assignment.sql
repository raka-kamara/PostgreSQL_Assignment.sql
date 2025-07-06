CREATE TABLE rangers (ranger_id SERIAL PRIMARY KEY, name VARCHAR(100), region VARCHAR(100));

CREATE TABLE species (species_id SERIAL PRIMARY KEY, common_name varchar(150),
scientific_name VARCHAR(150), discovery_date DATE, conservation_status VARCHAR(50));

CREATE TABLE sightings (sightings_id SERIAL PRIMARY KEY, ranger_id INTEGER REFERENCES rangers(ranger_id), 
species_id INTEGER REFERENCES species(species_id),
sighting_time TIMESTAMP, location VARCHAR(100), notes TEXT);

INSERT INTO rangers (name, region) VALUES ('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');
SELECT * FROM rangers;

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * FROM species;

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

SELECT * FROM sightings;

--problem 1 
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- problem 2
SELECT COUNT(DISTINCT species_id) as unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

--Problem 4
SELECT rangers.name, COUNT(sightings.sighting_id) AS total_sightings 
FROM rangers 
JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name 
ORDER BY rangers.name ASC;


--Problem 5
SELECT species.common_name FROM species LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.species_id is NULL

--problem 6
SELECT species.common_name, sightings.sighting_time, rangers.name
FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;

--problem 7
UPDATE species SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

--problem 8


SELECT 
  sighting_id,
  CASE 
    WHEN sighting_time::time < '12:00:00' THEN 'Morning'
    WHEN sighting_time::time < '17:00:00' THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;



