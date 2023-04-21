
/*

DATA EXPLORATION IN SQL (Portfolio Project)

*/

SELECT *
FROM SQLPortfolioProject..CovidDeaths

SELECT *
FROM SQLPortfolioProject..CovidVaccinations

-- VIEWS CREATED to store data for visualisations in Tableau Portfolio Project

--------------------------------------------------------------------------------------------
-- Start with more relevant columns in CovidDeaths dataset
--------------------------------------------------------------------------------------------

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM SQLPortfolioProject..CovidDeaths
ORDER BY 1,2


--------------------------------------------------------------------------------------------

-- Looking at Total Cases with Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL -- excludes locations that are not countries
-- AND location = 'Europe'
ORDER BY 1,2

-- Shows the likelihood of death if you contract covid whilst living in a given country
-- Include AND statement to look only at Europe

-- Create Views

CREATE VIEW Deaths_as_Percentage_of_Cases_World AS
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL

CREATE VIEW Deaths_as_Percentage_of_Cases_Europe AS
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE location = 'Europe'


--------------------------------------------------------------------------------------------

-- Looking at Total Cases with Population

SELECT location, date, population, total_cases, (total_cases/population)*100 AS CasesPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE location = 'Europe'
ORDER BY 1,2

-- Shows number of people that got Covid as a percentage of the population

-- Create Views

CREATE VIEW Cases_as_Percentage_of_Population_World AS
SELECT location, date, population, total_cases, (total_cases/population)*100 AS CasesPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL

CREATE VIEW Cases_as_Percentage_of_Population_Europe AS
SELECT location, date, population, total_cases, (total_cases/population)*100 AS CasesPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE location = 'Europe'


--------------------------------------------------------------------------------------------

-- Looking at countries with respective highest rate of infection individually and by population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS CasesPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 4 DESC

-- Shows the countries with their population along with the most recent total cases as a number and as a percentage of the 
-- respective population. It is in descending order of total cases as a percentage of population

-- Create Views

CREATE VIEW HighestInfectionCount_of_Countries_World AS
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS CasesPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population

CREATE VIEW HighestInfectionCount_of_Countries_Europe AS
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS CasesPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent = 'Europe'
GROUP BY location, population

--------------------------------------------------------------------------------------------

-- Looking at countries with respective highest death count individually and by population

SELECT location, population, MAX(total_deaths) AS HighestDeathCount, (MAX(total_deaths)/population)*100 AS DeathsPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 4 DESC

-- Shows the countries with their population along with the most recent total deaths as a number and as a percentage of the 
-- respective population. It is in descending order of total deaths as a percentage of population

-- Create Views

CREATE VIEW HighestDeathCount_of_Countries_World AS
SELECT location, population, MAX(total_deaths) AS HighestDeathCount, (MAX(total_deaths)/population)*100 AS DeathsPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population

CREATE VIEW HighestDeathCount_of_Countries_Europe AS
SELECT location, population, MAX(total_deaths) AS HighestDeathCount, (MAX(total_deaths)/population)*100 AS DeathsPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent = 'Europe'
GROUP BY location, population


--------------------------------------------------------------------------------------------

-- Looking at countries with highest death count overall

SELECT location, MAX(total_deaths) AS HighestDeathCount
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 2 DESC

-- Create View

CREATE VIEW HighestDeathCount_of_Countries_without_Percentage_World AS
SELECT location, MAX(total_deaths) AS HighestDeathCount
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location


--------------------------------------------------------------------------------------------

-- Looking at continents with highest total cases and death count individually and by population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS CasesPercentage,
	   MAX(total_deaths) AS HighestDeathCount, (MAX(total_deaths)/population)*100 AS DeathsPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NULL
	  AND location <> 'World'
	  AND location NOT LIKE '%Union' -- Exclude 'European Union'
	  AND location NOT LIKE '%nal' -- Exclude 'international'
GROUP BY location, population
ORDER BY 3 DESC

-- Create View

CREATE VIEW Continents_Cases_and_Deaths AS
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS CasesPercentage,
	   MAX(total_deaths) AS HighestDeathCount, (MAX(total_deaths)/population)*100 AS DeathsPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NULL
	  AND location <> 'World'
	  AND location NOT LIKE '%Union' -- Exclude 'European Union'
	  AND location NOT LIKE '%nal' -- Exclude 'international'
GROUP BY location, population


--------------------------------------------------------------------------------------------

-- Looking at global numbers

SELECT date, SUM(new_cases) AS Total_Daily_Cases, SUM(new_deaths) AS Total_Daily_Deaths, 
	   (SUM(new_deaths)/SUM(new_cases))*100 AS Deaths_To_Cases_Percentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1

-- Shows the global daily number of new cases, new deaths, and deaths-to-cases percentage for that day in chronological order

SELECT SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths,
	   (SUM(new_deaths)/SUM(new_cases))*100 AS Deaths_To_Cases_Percentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL

-- Shows the total number of cases and deaths along with the deaths-to-cases percentage for the world overall so far

-- Create Views

CREATE VIEW Daily_Cases_and_Deaths_Global AS
SELECT date, SUM(new_cases) AS Total_Daily_Cases, SUM(new_deaths) AS Total_Daily_Deaths, 
	   (SUM(new_deaths)/SUM(new_cases))*100 AS Deaths_To_Cases_Percentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date

CREATE VIEW Total_Cases_and_Deaths_Global AS
SELECT SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths,
	   (SUM(new_deaths)/SUM(new_cases))*100 AS Deaths_To_Cases_Percentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL


--------------------------------------------------------------------------------------------
-- Now with more relevant columns in CovidVaccinations dataset
--------------------------------------------------------------------------------------------

SELECT deaths.location, deaths.date, population, vaccs.new_vaccinations, vaccs.total_vaccinations
FROM SQLPortfolioProject..CovidDeaths deaths
JOIN SQLPortfolioProject..CovidVaccinations vaccs
	ON deaths.location = vaccs.location 
	AND deaths.date = vaccs.date
WHERE deaths.continent IS NOT NULL
ORDER BY  1,2

--------------------------------------------------------------------------------------------

-- Looking at Total Population vs Vaccinations  

SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
	   SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
					     ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
--	   (rolling_vaccinations/population)*100	-- cannot be added as is
FROM SQLPortfolioProject..CovidDeaths deaths
JOIN SQLPortfolioProject..CovidVaccinations vaccs
	ON deaths.location = vaccs.location 
	AND deaths.date = vaccs.date
WHERE deaths.continent IS NOT NULL
ORDER BY  2,3

-- Assuming no total_vaccinations column, this creates my own rolling count of vaccinations column

-- Getting rolling_vaccinations as percentage not possible without CTE or Temp table

---- CTE solve

WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
	   SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
					     ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
FROM SQLPortfolioProject..CovidDeaths deaths
JOIN SQLPortfolioProject..CovidVaccinations vaccs
	ON deaths.location = vaccs.location 
	AND deaths.date = vaccs.date
WHERE deaths.continent IS NOT NULL
)
SELECT *, (rolling_vaccinations/population)*100 AS rolling_vaccinations_percentage
FROM CTE_vaccs
ORDER BY  2,3

---- Temp table solve

DROP TABLE IF EXISTS #rolling_percentage_vaccinated_pop
CREATE TABLE #rolling_percentage_vaccinated_pop (
  continent nvarchar(255), 
  location nvarchar(255), 
  date date, 
  population float, 
  new_vaccinations float, 
  rolling_vaccinations float,
  rolling_vaccinations_percentage float
)

INSERT INTO #rolling_percentage_vaccinated_pop (continent, location, date, population, new_vaccinations, rolling_vaccinations)
SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
	   SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
					     ORDER BY deaths.date) AS rolling_vaccinations
FROM SQLPortfolioProject..CovidDeaths deaths
JOIN SQLPortfolioProject..CovidVaccinations vaccs
	ON deaths.location = vaccs.location 
	AND deaths.date = vaccs.date
WHERE deaths.continent IS NOT NULL

UPDATE #rolling_percentage_vaccinated_pop
SET rolling_vaccinations_percentage = (rolling_vaccinations/population)*100;

-- Create View (Does not work with Temp tables)

CREATE VIEW Percentage_of_Vaccinated_Population_World AS
WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.continent IS NOT NULL
)
SELECT *, (rolling_vaccinations/population)*100 AS rolling_vaccinations_percentage
FROM CTE_vaccs

CREATE VIEW Percentage_of_Vaccinated_Population_Europe AS
WITH CTE_vaccs (location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.location = 'Europe'
)
SELECT *, (rolling_vaccinations/population)*100 AS rolling_vaccinations_percentage
FROM CTE_vaccs


--------------------------------------------------------------------------------------------

-- Looking at countries with respective total vaccinations individually and by population

WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.continent IS NOT NULL
)
SELECT location, population, MAX(rolling_vaccinations) AS total_vaccinated,
	   (MAX(rolling_vaccinations)/population)*100 AS total_vaccinated_percentage
FROM CTE_vaccs
GROUP BY location, population
ORDER BY 3 DESC

-- Shows the countries with their population along with the most recent total vaccinations as a total and as a percentage of the 
-- respective population. It is in descending order of total vaccinations as total

-- Create Views

CREATE VIEW HighestVaccinationCount_of_Countries_World AS
WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.continent IS NOT NULL
)
SELECT location, population, MAX(rolling_vaccinations) AS total_vaccinated,
	   (MAX(rolling_vaccinations)/population)*100 AS total_vaccinated_percentage
FROM CTE_vaccs
GROUP BY location, population

CREATE VIEW HighestVaccinationCount_of_Countries_Europe AS
WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.continent = 'Europe'
)
SELECT location, population, MAX(rolling_vaccinations) AS total_vaccinated,
	   (MAX(rolling_vaccinations)/population)*100 AS total_vaccinated_percentage
FROM CTE_vaccs
GROUP BY location, population


--------------------------------------------------------------------------------------------

-- Looking at continents with highest vaccinations count individually and by population


WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
	WHERE deaths.continent IS NULL
)
SELECT location, population, MAX(rolling_vaccinations) AS total_vaccinated,
	   (MAX(rolling_vaccinations)/population)*100 AS total_vaccinated_percentage
FROM CTE_vaccs
WHERE location <> 'World'
	  AND location NOT LIKE '%Union' -- Exclude 'European Union'
	  AND location NOT LIKE '%nal' -- Exclude 'international'
GROUP BY location, population
ORDER BY 4 DESC

-- Create View

CREATE VIEW Continents_Vaccinations AS
WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
	WHERE deaths.continent IS NULL
)
SELECT location, population, MAX(rolling_vaccinations) AS total_vaccinated,
	   (MAX(rolling_vaccinations)/population)*100 AS total_vaccinated_percentage
FROM CTE_vaccs
WHERE location <> 'World'
	  AND location NOT LIKE '%Union' -- Exclude 'European Union'
	  AND location NOT LIKE '%nal' -- Exclude 'international'
GROUP BY location, population


--------------------------------------------------------------------------------------------

-- Looking at global numbers

WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.continent IS NOT NULL
)
SELECT date, SUM(new_vaccinations) AS global_daily_vaccinations,
	   SUM(rolling_vaccinations) AS global_total_vaccinated
FROM CTE_vaccs
GROUP BY date
ORDER BY 1

-- Shows the daily and total number of vaccinations administered globally over time

WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.continent IS NOT NULL
)
SELECT MAX(deaths.population) AS global_population, SUM(new_vaccinations) AS global_total_vaccinated,
	   (SUM(new_vaccinations)/MAX(deaths.population))*100 AS percentage_of_world_vaccinated
FROM CTE_vaccs
FULL JOIN SQLPortfolioProject..CovidDeaths deaths -- To obtain population where continent is NULL and location is 'World'
	ON CTE_vaccs.location = deaths.location 
    AND CTE_vaccs.date = deaths.date

-- Shows the global population, total number of people vaccinated worldwide, and the percentage of the world population vaccinated

-- Create Views

CREATE VIEW Daily_and_Rolling_Vaccinations_Global AS
WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.continent IS NOT NULL
)
SELECT date, SUM(new_vaccinations) AS global_daily_vaccinations,
	   SUM(rolling_vaccinations) AS global_total_vaccinated
FROM CTE_vaccs
GROUP BY date

CREATE VIEW Total_Vaccinations_Global AS
WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
    SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
           SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
                                             ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
    FROM SQLPortfolioProject..CovidDeaths deaths
    JOIN SQLPortfolioProject..CovidVaccinations vaccs
        ON deaths.location = vaccs.location 
        AND deaths.date = vaccs.date
    WHERE deaths.continent IS NOT NULL
)
SELECT MAX(deaths.population) AS global_population, SUM(new_vaccinations) AS global_total_vaccinated,
	   (SUM(new_vaccinations)/MAX(deaths.population))*100 AS percentage_of_world_vaccinated
FROM CTE_vaccs
FULL JOIN SQLPortfolioProject..CovidDeaths deaths
	ON CTE_vaccs.location = deaths.location 
    AND CTE_vaccs.date = deaths.date


--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

/*

DATA PREP

*/

-- Update date column to datatype date 

/*

UPDATE CovidDeaths
SET date = 
    CASE 
        WHEN ISDATE(date) = 1 THEN CONVERT(date, date, 103)
        ELSE CONVERT(date, SUBSTRING(date, 7, 4) + '-' + SUBSTRING(date, 4, 2) + '-' + SUBSTRING(date, 1, 2))
    END

ALTER TABLE SQLPortfolioProject..CovidDeaths
ALTER COLUMN date DATE

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE 
   TABLE_NAME = 'CovidDeaths' AND 
   COLUMN_NAME = 'date'

UPDATE CovidVaccinations
SET date = 
    CASE 
        WHEN ISDATE(date) = 1 THEN CONVERT(date, date, 103)
        ELSE CONVERT(date, SUBSTRING(date, 7, 4) + '-' + SUBSTRING(date, 4, 2) + '-' + SUBSTRING(date, 1, 2))
    END

ALTER TABLE SQLPortfolioProject..CovidVaccinations
ALTER COLUMN date DATE

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE 
   TABLE_NAME = 'CovidVaccinations' AND 
   COLUMN_NAME = 'date'

*/


-- Update all columns to replace empty values with nulls

/* 

UPDATE CovidDeaths
SET 
    continent = NULLIF(continent, ''),
    population = NULLIF(population, ''),
    total_cases = NULLIF(total_cases, ''),
    new_cases = NULLIF(new_cases, ''),
    total_deaths = NULLIF(total_deaths, ''),
    new_deaths = NULLIF(new_deaths, ''),
    icu_patients = NULLIF(icu_patients, ''),
    hosp_patients = NULLIF(hosp_patients, ''),
    new_cases_smoothed = NULLIF(new_cases_smoothed, ''),
    new_deaths_smoothed = NULLIF(new_deaths_smoothed, ''),
    total_cases_per_million = NULLIF(total_cases_per_million, ''),
    new_cases_per_million = NULLIF(new_cases_per_million, ''),
    new_cases_smoothed_per_million = NULLIF(new_cases_smoothed_per_million, ''),
    total_deaths_per_million = NULLIF(total_deaths_per_million, ''),
    new_deaths_per_million = NULLIF(new_deaths_per_million, ''),
    new_deaths_smoothed_per_million = NULLIF(new_deaths_smoothed_per_million, ''),
    reproduction_rate = NULLIF(reproduction_rate, ''),
    icu_patients_per_million = NULLIF(icu_patients_per_million, ''),
    hosp_patients_per_million = NULLIF(hosp_patients_per_million, ''),
    weekly_hosp_admissions = NULLIF(weekly_hosp_admissions, ''),
    weekly_hosp_admissions_per_million = NULLIF(weekly_hosp_admissions_per_million, ''),
    weekly_icu_admissions = NULLIF(weekly_icu_admissions, ''),
    weekly_icu_admissions_per_million = NULLIF(weekly_icu_admissions_per_million, '');

-- Now with CovidVaccination 

UPDATE CovidVaccinations
SET continent = NULLIF(continent, ''),
    new_tests = NULLIF(new_tests, ''),
    total_tests = NULLIF(total_tests, ''),
    total_tests_per_thousand = NULLIF(total_tests_per_thousand, ''),
    new_tests_per_thousand = NULLIF(new_tests_per_thousand, ''),
    new_tests_smoothed = NULLIF(new_tests_smoothed, ''),
    new_tests_smoothed_per_thousand = NULLIF(new_tests_smoothed_per_thousand, ''),
    positive_rate = NULLIF(positive_rate, ''),
    tests_per_case = NULLIF(tests_per_case, ''),
    tests_units = NULLIF(tests_units, ''),
    total_vaccinations = NULLIF(total_vaccinations, ''),
    people_vaccinated = NULLIF(people_vaccinated, ''),
    people_fully_vaccinated = NULLIF(people_fully_vaccinated, ''),
    new_vaccinations = NULLIF(new_vaccinations, ''),
    new_vaccinations_smoothed = NULLIF(new_vaccinations_smoothed, ''),
    total_vaccinations_per_hundred = NULLIF(total_vaccinations_per_hundred, ''),
    people_vaccinated_per_hundred = NULLIF(people_vaccinated_per_hundred, ''),
    people_fully_vaccinated_per_hundred = NULLIF(people_fully_vaccinated_per_hundred, ''),
    new_vaccinations_smoothed_per_million = NULLIF(new_vaccinations_smoothed_per_million, ''),
    stringency_index = NULLIF(stringency_index, ''),
    population_density = NULLIF(population_density, ''),
    median_age = NULLIF(median_age, ''),
    aged_65_older = NULLIF(aged_65_older, ''),
    aged_70_older = NULLIF(aged_70_older, ''),
    gdp_per_capita = NULLIF(gdp_per_capita, ''),
    extreme_poverty = NULLIF(extreme_poverty, ''),
    cardiovasc_death_rate = NULLIF(cardiovasc_death_rate, ''),
    diabetes_prevalence = NULLIF(diabetes_prevalence, ''),
    female_smokers = NULLIF(female_smokers, ''),
    male_smokers = NULLIF(male_smokers, ''),
    handwashing_facilities = NULLIF(handwashing_facilities, ''),
    hospital_beds_per_thousand = NULLIF(hospital_beds_per_thousand, ''),
    life_expectancy = NULLIF(life_expectancy, ''),
    human_development_index = NULLIF(human_development_index, '');

*/

-- Then change data types manually for relevant variables to float.
