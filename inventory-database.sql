-- 1. Display first 10 parts data
SELECT * FROM parts
LIMIT 10;

-- 2. Add unique and not empty constraint to code column 
ALTER TABLE parts
ADD UNIQUE (code);

ALTER TABLE parts
ALTER COLUMN code SET NOT NULL;

-- 3. Fill all empty description column rows with 'Non Available'
UPDATE parts
SET description = 'Non Available'
WHERE description IS NULL
OR description = ' ';

SELECT * FROM parts
ORDER BY id;

-- 4. Set non empty constraint on description column
ALTER TABLE parts
ALTER COLUMN description SET NOT NULL;

-- 5. Add new parts information without description data 
-- With Error
-- INSERT INTO parts(id, code, manufacturer_id)
-- VALUES(54, 'Oxygen sensor', 'V1-009', 9);

-- With out Error
INSERT INTO parts
VALUES(54, 'Oxygen sensor', 'V1-009', 9);


-- 6. Add not null constraint on quantiy and price_usd column
ALTER TABLE reorder_options
ALTER COLUMN quantity SET NOT NULL;

ALTER TABLE reorder_options
ALTER COLUMN price_usd SET NOT NULL;

-- 7. Add constraint to ensure price_usd and quantity are positivie integers
ALTER TABLE reorder_options
ADD CHECK (price_usd > 0 AND quantity > 0);

-- 8. Add constraint to check price per unit is between 0.02 and 25
ALTER TABLE reorder_options
ADD CHECK (price_usd / quantity > 0.02 AND price_usd / quantity < 25);

-- 9. Add constraint to ensure all parts in reorder_options are available
ALTER TABLE parts
ADD PRIMARY KEY (id);

ALTER TABLE reorder_options
ADD FOREIGN KEY (part_id) REFERENCES
parts(id);

-- 10. Add constraint to ensure quantiy is greater than 0
ALTER TABLE locations
ADD CHECK (qty > 0);

-- 11. Add constraint to ensure part_id and location are unique
ALTER TABLE locations
ADD UNIQUE(part_id, location);

-- 12. Add constraint to ensure only valid parts exist in locations
ALTER TABLE locations
ADD FOREIGN KEY (part_id) REFERENCES
parts(id);

-- 13. Add constraint to ensure all parts have a valid manufacturer
ALTER TABLE parts
ADD FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id);

-- 14. Add a new manufacturer with id 
INSERT INTO manufacturers(id, name)
VALUES (11, 'Pip-NNC');

-- 15. Modify manufacturer in parts with id
UPDATE parts
SET manufacturer_id = 11
WHERE manufacturer_id IN (1, 2);