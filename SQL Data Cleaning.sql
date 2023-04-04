
/*

CLEANING DATA IN SQL (Portfolio Project)

*/

SELECT *
FROM SQLPortfolioProject..NashvilleHousing


--------------------------------------------------------------------------------------------

-- Standardize/Change Date Format

SELECT SaleDate, CONVERT(date, SaleDate) -- originally SaleDate in datetime format
FROM SQLPortfolioProject..NashvilleHousing

ALTER TABLE SQLPortfolioProject..NashvilleHousing
ALTER COLUMN SaleDate date

SELECT SaleDate
FROM SQLPortfolioProject..NashvilleHousing


--------------------------------------------------------------------------------------------

-- Populate Property Address Data

SELECT *
FROM SQLPortfolioProject..NashvilleHousing
WHERE PropertyAddress IS NULL

-- Turns out the ParcelID functions as a unique identifier for PropertyAddress and there
-- are cases where particular parcel ID appears twice, once associated with specified
-- PropertyAddress and once with null value which we can assume should be the same as the
-- specified one.

SELECT NasH1.ParcelID, NasH1.PropertyAddress, NasH2.ParcelID, NasH2.PropertyAddress,
	   ISNULL(NasH1.PropertyAddress, NasH2.PropertyAddress)
FROM SQLPortfolioProject..NashvilleHousing NasH1
JOIN SQLPortfolioProject..NashvilleHousing NasH2
	ON NasH1.ParcelID = NasH2.ParcelID
	AND NasH1.[UniqueID ] <> NasH2.[UniqueID ]
WHERE NasH1.PropertyAddress IS NULL

UPDATE NasH1
SET PropertyAddress = ISNULL(NasH1.PropertyAddress, NasH2.PropertyAddress)
FROM SQLPortfolioProject..NashvilleHousing NasH1
JOIN SQLPortfolioProject..NashvilleHousing NasH2
	ON NasH1.ParcelID = NasH2.ParcelID
	AND NasH1.[UniqueID ] <> NasH2.[UniqueID ]
WHERE NasH1.PropertyAddress IS NULL


--------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

SELECT PropertyAddress
FROM SQLPortfolioProject..NashvilleHousing

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Street,
	   SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS City
FROM SQLPortfolioProject..NashvilleHousing

ALTER TABLE SQLPortfolioProject..NashvilleHousing
ADD PropertyStreetAddress nvarchar(255),
    PropertyCity nvarchar(255)

UPDATE SQLPortfolioProject..NashvilleHousing
SET PropertyStreetAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),
    PropertyCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

SELECT *
FROM SQLPortfolioProject..NashvilleHousing

-- Now with owner address

SELECT OwnerAddress
FROM SQLPortfolioProject..NashvilleHousing

SELECT PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS Street,
	   PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS City,
	   PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS State
FROM SQLPortfolioProject..NashvilleHousing

ALTER TABLE SQLPortfolioProject..NashvilleHousing
ADD OwnerStreetAddress nvarchar(255),
    OwnerCity nvarchar(255),
    OwnerState nvarchar(255)

UPDATE SQLPortfolioProject..NashvilleHousing
SET OwnerStreetAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
    OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
    OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

SELECT *
FROM SQLPortfolioProject..NashvilleHousing


--------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) AS Count
FROM SQLPortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
       CASE 
           WHEN SoldAsVacant = 'Y' THEN 'Yes'
           WHEN SoldAsVacant = 'N' THEN 'No'
           ELSE SoldAsVacant
       END
FROM SQLPortfolioProject..NashvilleHousing
-- WHERE SoldAsVacant = 'Y' OR SoldAsVacant = 'N'

UPDATE SQLPortfolioProject..NashvilleHousing
SET SoldAsVacant = CASE 
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
    END

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) AS Count
FROM SQLPortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2


--------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH CTE_Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
               ORDER BY UniqueID
           ) AS RowNum
    FROM SQLPortfolioProject..NashvilleHousing
)
DELETE
FROM CTE_Duplicates
WHERE RowNum > 1


--------------------------------------------------------------------------------------------

-- Delete Unused Columns

ALTER TABLE SQLPortfolioProject..NashvilleHousing
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict

SELECT *
FROM SQLPortfolioProject..NashvilleHousing


--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------