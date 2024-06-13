-- Layoffs Cleaning
-- 1 Remove Duplicates  /  DONE
-- 2 Standardize the Data  /  DONE
-- 3 Null or Missing Values  /  DONE
-- 4 Remove nessesary columns  /  DONE
 
 
 -- Make A Copy of Dataset
SELECT * FROM layoffs_staging;

CREATE TABLE layoffs_staging LIKE layoffs;

INSERT layoffs_staging SELECT * FROM layoffs;

-- 1 Remove Duplicates

SELECT * ,
-- ROW_NUMBER assigns a uniques num to row within specified group of row(OVER(PARTITION BY))
ROW_NUMBER () OVER (PARTITION BY company, industry, total_laid_off, percentage_laid_off,`date`,country) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS(
	SELECT * ,
	ROW_NUMBER () OVER (
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) 
	AS row_num
	FROM layoffs_staging)
;

ALTER TABLE layoffs_staging DROP COLUMN row_num;

DELETE
FROM layoffs_2
WHERE row_num > 1;

SELECT *
FROM layoffs_2
WHERE row_num > 1;

CREATE TABLE `layoffs_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_2 
SELECT * ,
ROW_NUMBER () OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,"date",stage,country,funds_raised_millions) 
AS row_num
FROM layoffs_staging;

-- 2 Standardize the Data  

SELECT *
FROM layoffs_2;

-- TRIM([leading | trailing | both] [trim_character FROM] string)
-- leading: Removes characters from the beginning of the string.
-- trailing: Removes characters from the end of the string.
-- both: Removes characters from both the beginning and end of the string. This is the default behavior if no option is specified.
-- trim_character: The character that you want to remove. If not specified, it defaults to space.
-- string: The string from which you want to remove characters.

UPDATE layoffs_2 SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_2
ORDER BY 1;

UPDATE layoffs_2 SET industry = 'Crypto'
WHERE industry LIKE '%Crypto%'; 

SELECT DISTINCT country
FROM layoffs_2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_2
WHERE country LIKE '%United States%';

UPDATE layoffs_2 SET country = 'United States'
WHERE country LIKE '%United States%'; 

SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_2;

UPDATE layoffs_2 SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
ALTER TABLE layoffs_2 MODIFY COLUMN `date` DATE;

-- Null or Missing Values 

SELECT * FROM layoffs_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_2
WHERE industry IS NULL
OR industry ='';

SELECT * FROM layoffs_2
WHERE company = "Airbnb";

UPDATE layoffs_2 SET industry = 'Consumer'
WHERE company = 'Juul'; 

-- Another way to fullfill null and blank
SELECT t1.company,t1.industry,t2.company,t2.industry
FROM layoffs_2 t1
JOIN layoffs_2 t2
	ON t1.company = t2.company AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;

UPDATE layoffs_2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_2 t1
JOIN layoffs_2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;

-- 4 Remove nessesary columns

UPDATE layoffs_2 SET percentage_laid_off = NULL
WHERE percentage_laid_off = '';

SELECT company,total_laid_off,percentage_laid_off
FROM layoffs_2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

SELECT COUNT(company)
FROM layoffs_2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

DELETE FROM layoffs_2 
WHERE  total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_2;
ALTER TABLE layoffs_2 DROP COLUMN row_num;