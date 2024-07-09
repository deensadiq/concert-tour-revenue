-- Remove Duplicates
DELETE FROM concerts
WHERE id NOT IN (
    SELECT MIN(id)
    FROM concerts
    GROUP BY Rank, Artist, Tour_title, Year(s)
);

-- Handle Missing Values
UPDATE concerts
SET Peak = '0'
WHERE Peak IS NULL;

UPDATE concerts
SET All_Time_Peak = '0'
WHERE All_Time_Peak IS NULL;

-- Standardize Data Formats
UPDATE concerts
SET Actual_gross = REPLACE(Actual_gross, '$', ''),
    Adjusted_gross = REPLACE(Adjusted_gross, '$', ''),
    Average_gross = REPLACE(Average_gross, '$', '');

-- Convert Data Types
ALTER TABLE concerts
ALTER COLUMN Actual_gross TYPE DECIMAL USING REPLACE(Actual_gross, ',', '')::DECIMAL;
ALTER TABLE concerts
ALTER COLUMN Adjusted_gross TYPE DECIMAL USING REPLACE(Adjusted_gross, ',', '')::DECIMAL;
ALTER TABLE concerts
ALTER COLUMN Average_gross TYPE DECIMAL USING REPLACE(Average_gross, ',', '')::DECIMAL;

-- Remove Special Characters
UPDATE concerts
SET Tour_title = TRIM(Tour_title),
    Artist = TRIM(Artist);
