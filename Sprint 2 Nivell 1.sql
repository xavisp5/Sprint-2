-- select * FROM company;
-- select * FROM credit_card;
-- select * FROM data_user;
-- select * FROM transaction;
/*
-- llistat de paisos que generen vendes:

SELECT company.country, COUNT(transaction.id)
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id
GROUP BY company.country
ORDER BY COUNT(transaction.id) DESC; */

/* 
-- des de quants països es generen vendes:

SELECT COUNT(distinct company.country), COUNT(transaction.id)
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id
HAVING COUNT(transaction.id) > 0; */

/* 
-- Companyia amb la mitjana més gran de vendes:
SELECT company.company_name, avg (transaction.amount)
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id
GROUP BY company.company_name
ORDER BY avg (transaction.amount) DESC
LIMIT 1; */

/*
-- Mostra totes les transaccions realitzades per empreses d'Alemanya
SELECT * FROM transaction
WHERE company_id IN(select company.id from company
where country = "Germany");  */




-- Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions:
SELECT * FROM company
WHERE
(SELECT AVG(amount) from transaction)  > (select AVG(amount) FROM transaction)
;



-- select AVG(amount) FROM transaction;


