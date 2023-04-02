

--SELECT *
--FROM SQLPortfolioProject..CovidDeaths

--SELECT *
--FROM SQLPortfolioProject..CovidVaccinations




/****************************************** DATA PREP ******************************************/

/* Update date column to data type date */

--UPDATE CovidDeaths
--SET date = 
--    CASE 
--        WHEN ISDATE(date) = 1 THEN CONVERT(date, date, 103)
--        ELSE CONVERT(date, SUBSTRING(date, 7, 4) + '-' + SUBSTRING(date, 4, 2) + '-' + SUBSTRING(date, 1, 2))
--    END

--ALTER TABLE SQLPortfolioProject..CovidDeaths
--ALTER COLUMN date DATE

--SELECT DATA_TYPE 
--FROM INFORMATION_SCHEMA.COLUMNS 
--WHERE 
--   TABLE_NAME = 'CovidDeaths' AND 
--   COLUMN_NAME = 'date'

--UPDATE CovidVaccinations
--SET date = 
--    CASE 
--        WHEN ISDATE(date) = 1 THEN CONVERT(date, date, 103)
--        ELSE CONVERT(date, SUBSTRING(date, 7, 4) + '-' + SUBSTRING(date, 4, 2) + '-' + SUBSTRING(date, 1, 2))
--    END

--ALTER TABLE SQLPortfolioProject..CovidVaccinations
--ALTER COLUMN date DATE

--SELECT DATA_TYPE 
--FROM INFORMATION_SCHEMA.COLUMNS 
--WHERE 
--   TABLE_NAME = 'CovidVaccinations' AND 
--   COLUMN_NAME = 'date'


/* Update all columns to replace empty values with nulls */

--UPDATE CovidDeaths
--SET continent = NULL
--WHERE continent = '';

--UPDATE CovidDeaths
--SET population = NULL
--WHERE population = '';

--UPDATE CovidDeaths
--SET total_cases = NULL
--WHERE total_cases = '';

--UPDATE CovidDeaths
--SET new_cases = NULL
--WHERE new_cases = '';

--UPDATE CovidDeaths
--SET total_deaths = NULL
--WHERE total_deaths = '';

--UPDATE CovidDeaths
--SET new_deaths = NULL
--WHERE new_deaths = '';

--UPDATE CovidDeaths
--SET icu_patients = NULL
--WHERE icu_patients = '';

--UPDATE CovidDeaths
--SET hosp_patients = NULL
--WHERE hosp_patients = '';

--UPDATE CovidDeaths
--SET new_cases_smoothed = NULL
--WHERE new_cases_smoothed = '';

--UPDATE CovidDeaths
--SET new_deaths_smoothed = NULL
--WHERE new_deaths_smoothed = '';

--UPDATE CovidDeaths
--SET total_cases_per_million = NULL
--WHERE total_cases_per_million = '';

--UPDATE CovidDeaths
--SET new_cases_per_million = NULL
--WHERE new_cases_per_million = '';

--UPDATE CovidDeaths
--SET new_cases_smoothed_per_million = NULL
--WHERE new_cases_smoothed_per_million = '';

--UPDATE CovidDeaths
--SET total_deaths_per_million = NULL
--WHERE total_deaths_per_million = '';

--UPDATE CovidDeaths
--SET new_deaths_per_million = NULL
--WHERE new_deaths_per_million = '';

--UPDATE CovidDeaths
--SET new_deaths_smoothed_per_million = NULL
--WHERE new_deaths_smoothed_per_million = '';

--UPDATE CovidDeaths
--SET reproduction_rate = NULL
--WHERE reproduction_rate = '';

--UPDATE CovidDeaths
--SET icu_patients_per_million = NULL
--WHERE icu_patients_per_million = '';

--UPDATE CovidDeaths
--SET hosp_patients_per_million = NULL
--WHERE hosp_patients_per_million = '';

--UPDATE CovidDeaths
--SET weekly_hosp_admissions = NULL
--WHERE weekly_hosp_admissions = '';

--UPDATE CovidDeaths
--SET weekly_hosp_admissions_per_million = NULL
--WHERE weekly_hosp_admissions_per_million = '';

--UPDATE CovidDeaths
--SET weekly_icu_admissions = NULL
--WHERE weekly_icu_admissions = '';

--UPDATE CovidDeaths
--SET weekly_icu_admissions_per_million = NULL
--WHERE weekly_icu_admissions_per_million = '';

/* Now with CovidVaccination */

--UPDATE CovidVaccinations
--SET continent = NULL
--WHERE continent = '';

--UPDATE CovidVaccinations
--SET new_tests = NULL
--WHERE new_tests = '';

--UPDATE CovidVaccinations
--SET total_tests = NULL
--WHERE total_tests = '';

--UPDATE CovidVaccinations
--SET total_tests_per_thousand = NULL
--WHERE total_tests_per_thousand = '';

--UPDATE CovidVaccinations
--SET new_tests_per_thousand = NULL
--WHERE new_tests_per_thousand = '';

--UPDATE CovidVaccinations
--SET new_tests_smoothed = NULL
--WHERE new_tests_smoothed = '';

--UPDATE CovidVaccinations
--SET new_tests_smoothed_per_thousand = NULL
--WHERE new_tests_smoothed_per_thousand = '';

--UPDATE CovidVaccinations
--SET positive_rate = NULL
--WHERE positive_rate = '';

--UPDATE CovidVaccinations
--SET tests_per_case = NULL
--WHERE tests_per_case = '';

--UPDATE CovidVaccinations
--SET tests_units = NULL
--WHERE tests_units = '';

--UPDATE CovidVaccinations
--SET total_vaccinations = NULL
--WHERE total_vaccinations = '';

--UPDATE CovidVaccinations
--SET people_vaccinated = NULL
--WHERE people_vaccinated = '';

--UPDATE CovidVaccinations
--SET people_fully_vaccinated = NULL
--WHERE people_fully_vaccinated = '';

--UPDATE CovidVaccinations
--SET new_vaccinations = NULL
--WHERE new_vaccinations = '';

--UPDATE CovidVaccinations
--SET new_vaccinations_smoothed = NULL
--WHERE new_vaccinations_smoothed = '';

--UPDATE CovidVaccinations
--SET total_vaccinations_per_hundred = NULL
--WHERE total_vaccinations_per_hundred = '';

--UPDATE CovidVaccinations
--SET people_vaccinated_per_hundred = NULL
--WHERE people_vaccinated_per_hundred = '';

--UPDATE CovidVaccinations
--SET people_fully_vaccinated_per_hundred = NULL
--WHERE people_fully_vaccinated_per_hundred = '';

--UPDATE CovidVaccinations
--SET new_vaccinations_smoothed_per_million = NULL
--WHERE new_vaccinations_smoothed_per_million = '';

--UPDATE CovidVaccinations
--SET stringency_index = NULL
--WHERE stringency_index = '';

--UPDATE CovidVaccinations
--SET population_density = NULL
--WHERE population_density = '';

--UPDATE CovidVaccinations
--SET median_age = NULL
--WHERE median_age = '';

--UPDATE CovidVaccinations
--SET aged_65_older = NULL
--WHERE aged_65_older = '';

--UPDATE CovidVaccinations
--SET aged_70_older = NULL
--WHERE aged_70_older = '';

--UPDATE CovidVaccinations
--SET gdp_per_capita = NULL
--WHERE gdp_per_capita = '';

--UPDATE CovidVaccinations
--SET extreme_poverty = NULL
--WHERE extreme_poverty = '';

--UPDATE CovidVaccinations
--SET cardiovasc_death_rate = NULL
--WHERE cardiovasc_death_rate = '';

--UPDATE CovidVaccinations
--SET diabetes_prevalence = NULL
--WHERE diabetes_prevalence = '';

--UPDATE CovidVaccinations
--SET female_smokers = NULL
--WHERE female_smokers = '';

--UPDATE CovidVaccinations
--SET male_smokers = NULL
--WHERE male_smokers = '';

--UPDATE CovidVaccinations
--SET handwashing_facilities = NULL
--WHERE handwashing_facilities = '';

--UPDATE CovidVaccinations
--SET hospital_beds_per_thousand = NULL
--WHERE hospital_beds_per_thousand = '';

--UPDATE CovidVaccinations
--SET life_expectancy = NULL
--WHERE life_expectancy = '';

--UPDATE CovidVaccinations
--SET human_development_index = NULL
--WHERE human_development_index = '';

---- Then change data types manually for each to int/varchar/decimal(18,3)





/****************************************** DATA EXPLORATION ******************************************/

-- Select the data that I will be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM SQLPortfolioProject..CovidDeaths
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM SQLPortfolioProject..CovidDeaths
-- WHERE location = 'Europe'
ORDER BY 1,2

-- Shows the likelihood of death if you contract covid whilst living in a given country
-- Include WHERE statement to look only at Europe


-- Looking at Total Cases vs Population

SELECT location, date, population, total_cases, (total_cases/population)*100 AS CasesPercentage
FROM SQLPortfolioProject..CovidDeaths
WHERE location = 'Europe'
ORDER BY 1,2

-- Shows the percentage of people that got Covid


-- Looking at countries with highest rate of infection

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS CasesPercentage
FROM SQLPortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY 4 DESC


-- Looking at countries with highest death count by population

SELECT location, population, MAX(total_deaths) AS HighestDeathCount, (MAX(total_deaths)/population)*100 AS DeathsPercentage
FROM SQLPortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY 4 DESC


-- Looking at countries with highest death count overall

SELECT location, MAX(total_deaths) AS HighestDeathCount
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL -- So we only see data for countries
GROUP BY location
ORDER BY 2 DESC


-- BREAKING THINGS DOWN BY CONTINENT

-- Showing continents with highest death count by population

SELECT location, MAX(total_deaths) AS HighestDeathCount
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NULL
	  AND location <> 'World'
	  AND location NOT LIKE '%Union' -- Exclude EU
	  AND location NOT LIKE '%nal' -- Exclude 'international'
GROUP BY location
ORDER BY 2 DESC


-- Global Numbers

SELECT date, SUM(new_cases) AS Total_Daily_Cases, SUM(new_deaths) AS Total_Daily_Deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS Deaths_To_Cases_Percentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1

SELECT SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS Deaths_To_Cases_Percentage
FROM SQLPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1


-- NOW WITH COVID VACCINATIONS

-- Looking at Total Population vs Vaccinations 

-- Assuming no total_vaccinations column, how to create my own rolling count column

SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
	   SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
										 ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
	 --  (rolling_vaccinations/population)*100 cannot be added as is
FROM SQLPortfolioProject..CovidDeaths deaths
JOIN SQLPortfolioProject..CovidVaccinations vaccs
	ON deaths.location = vaccs.location 
	AND deaths.date = vaccs.date
WHERE deaths.continent IS NOT NULL
ORDER BY  2,3


-- Using CTE to add column using another newly created column

WITH CTE_vaccs (continent, location, date, population, new_vaccinations, rolling_vaccinations) AS (
SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
	   SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
										 ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
FROM SQLPortfolioProject..CovidDeaths deaths
JOIN SQLPortfolioProject..CovidVaccinations vaccs
	ON deaths.location = vaccs.location 
	AND deaths.date = vaccs.date
WHERE deaths.continent  IS NOT NULL
)
SELECT *, (rolling_vaccinations/population)*100 AS rolling_vaccinations_percentage
FROM CTE_vaccs
ORDER BY  2,3

-- Now using Temp table to add column using another newly created column

DROP TABLE IF EXISTS #rolling_percentage_vaccinated_pop
CREATE TABLE #rolling_percentage_vaccinated_pop (
continent nvarchar(255), 
location nvarchar(255), 
date date, 
population float, 
new_vaccinations float, 
rolling_vaccinations float
)

INSERT INTO #rolling_percentage_vaccinated_pop
SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
	   SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
										 ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
FROM SQLPortfolioProject..CovidDeaths deaths
JOIN SQLPortfolioProject..CovidVaccinations vaccs
	ON deaths.location = vaccs.location 
	AND deaths.date = vaccs.date
WHERE deaths.continent  IS NOT NULL

SELECT *, (rolling_vaccinations/population)*100 AS rolling_vaccinations_percentage
FROM #rolling_percentage_vaccinated_pop
ORDER BY  2,3


-- Creating View to store data for later visualisations

CREATE VIEW Percentage_of_Vaccinated_Population AS
SELECT deaths.continent, deaths.location, deaths.date, population, vaccs.new_vaccinations,
	   SUM(vaccs.new_vaccinations) OVER (PARTITION BY deaths.location 
										 ORDER BY deaths.location, deaths.date) AS rolling_vaccinations
FROM SQLPortfolioProject..CovidDeaths deaths
JOIN SQLPortfolioProject..CovidVaccinations vaccs
	ON deaths.location = vaccs.location 
	AND deaths.date = vaccs.date
WHERE deaths.continent  IS NOT NULL

SELECT *
FROM Percentage_of_Vaccinated_Population