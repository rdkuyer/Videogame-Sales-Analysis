-- Cleaning and prepping videogame_Sales


-- Delete duplicates
WITH duplicates AS (
    SELECT unique_title,
        rank,
        ROW_NUMBER() OVER (PARTITION BY unique_title ORDER BY unique_title DESC) AS rn
    FROM videogame_data
)
DELETE FROM videogame_data
WHERE rank IN (
    SELECT rank 
    FROM duplicates
    WHERE rn > 1
);

-- Check if succeded
SELECT unique_title, COUNT(*)
FROM videogame_data
GROUP BY unique_title
HAVING COUNT(*) > 1;

-- Add categories for platform & generation
-- Based on: https://en.wikipedia.org/wiki/History_of_video_game_consoles#First_generation_(1972%E2%80%931980)
ALTER TABLE videogame_data
ADD COLUMN IF NOT EXISTS unique_title VARCHAR(250),
ADD COLUMN IF NOT EXISTS game_generation VARCHAR(250),
ADD COLUMN IF NOT EXISTS platform VARCHAR(250),
ADD COLUMN IF NOT EXISTS sort_generation int;

UPDATE videogame_data
SET unique_title = LOWER(TRIM(title || '_' || console)),
    game_generation = CASE
    -- First Generation (1972–1980)
    WHEN console IN ('2600') THEN 'First Generation (1972–1980)'
    
    -- Second Generation (1976–1992)
    WHEN console IN ('7800', 'Int', '5200', 'ColecoVision', 'MSX') THEN 'Second Generation (1976–1992)'
    
    -- Third Generation (1983–2003)
    WHEN console IN ('NES', 'C64', 'Master System', 'GG') THEN 'Third Generation (1983–2003)'
    
    -- Fourth Generation (1987–2004)
    WHEN console IN ('SNES', 'GEN', 'TG16', 'SCD', '3DO') THEN 'Fourth Generation (1987–2004)'
    
    -- Fifth Generation (1993–2006)
    WHEN console IN ('PS', 'N64', 'SAT', 'VB') THEN 'Fifth Generation (1993–2006)'
    
    -- Sixth Generation (1998–2013)
    WHEN console IN ('PS2', 'GC', 'Xbox', 'DC') THEN 'Sixth Generation (1998–2013)'
    
    -- Seventh Generation (2005–2017)
    WHEN console IN ('PS3', 'X360', 'Wii', 'PSP', 'DS', 'DSi', 'PSV', 'WiiU') THEN 'Seventh Generation (2005–2017)'
    
    -- Eighth Generation (2012–Present)
    WHEN console IN ('PS4', 'XOne', 'Switch', 'NS', '3DS') THEN 'Eighth Generation (2012–Present)'
    
    -- Ninth Generation (2020–Present)
    WHEN console IN ('PS5', 'XS', 'Series X') THEN 'Ninth Generation (2020–Present)'
    
    -- PC & Mobile Platforms
    WHEN console IN ('PC', 'Linux', 'MacOS', 'OSX', 'iOS', 'Android') THEN 'PC and Mobile Platforms'

    ELSE 'Other'
    END,

    platform =CASE
    -- PlayStation Consoles
    WHEN console IN ('PS', 'PS2', 'PS3', 'PS4', 'PS5', 'PSP', 'PSV', 'PSN') THEN 'PlayStation'

    -- Nintendo Consoles
    WHEN console IN ('NES', 'SNES', 'N64', 'GC', 'Wii', 'WiiU', 'DS', '3DS', 'DSi', 'GBC', 'GBA', 'Switch', 'NS', 'VC', 'iQue') THEN 'Nintendo'

    -- Microsoft Consoles
    WHEN console IN ('Xbox', 'X360', 'XOne', 'XS', 'Series', 'XBL') THEN 'Xbox'

    -- Sega Consoles
    WHEN console IN ('GEN', 'SCD', 'S32X', 'SAT', 'DC', 'GG', 'MS') THEN 'Sega'

    -- Atari Consoles
    WHEN console IN ('2600', '5200', '7800', 'Lynx') THEN 'Atari'

    -- Commodore Consoles
    WHEN console IN ('C64', 'C128', 'Amig', 'CD32') THEN 'Commodore'

     -- PC Platforms
    WHEN console IN ('PC', 'Linux', 'MacOS', 'OSX', 'WinP', 'ApII', 'ACPC') THEN 'PC'

    -- Mobile Platforms
    WHEN console IN ('iOS', 'Android', 'And', 'Mob') THEN 'Mobile'
    
    -- NEC Consoles
    WHEN console IN ('TG16', 'PCE', 'PCFX') THEN 'NEC'

    -- Other Consoles
    WHEN console IN ('GIZ', 'Ouya', 'FMT', 'Ast', 'MSD', 'AJ', 'OR', 'WW', 'NGage', 'WS', 'Arc', 'Aco', 'BRW', 'ZXS', 'BBCM', 'FMT') THEN 'Other'

    ELSE 'Other'
    END,

    sort_generation = CASE 
    WHEN game_generation = 'First Generation (1972–1980)' THEN 1
    WHEN game_generation = 'Second Generation (1976–1992)' THEN 2
    WHEN game_generation = 'Third Generation (1983–2003)'THEN 3
    WHEN game_generation = 'Fourth Generation (1987–2004)' THEN 4
    WHEN game_generation =  'Fifth Generation (1993–2006)'THEN 5
    WHEN game_generation = 'Sixth Generation (1998–2013)' THEN 6
    WHEN game_generation = 'Seventh Generation (2005–2017)' THEN 7
    WHEN game_generation = 'Eighth Generation (2012–Present)' THEN 8
    WHEN game_generation = 'Ninth Generation (2020–Present)' THEN 9
    ELSE 10
END;

SELECT DISTINCT console
FROM videogame_data

--
-- Create tables in project database 

-- Sales tables
CREATE TABLE IF NOT EXISTS Fact_sales AS
SELECT unique_title, 
    title, 
    total_sales, 
    na_sales, 
    jp_sales, 
    pal_sales, 
    other_sales, 
    rank
FROM videogame_data;

-- Product table
CREATE TABLE IF NOT EXISTS Dim_Product AS
SELECT unique_title,
        title,
        console,
        developer,
        genre,
        publisher,
        platform,
        game_generation,
        release_date,
        last_update,
        sort_generation,
        rank
FROM videogame_data;

-- Review table
CREATE TABLE IF NOT EXISTS Dim_Review AS
SELECT unique_title,
        critic_score,
        rank
FROM videogame_data
WHERE critic_score IS NOT NULL;

SELECT * 
FROM videogame_data
LIMIT 10