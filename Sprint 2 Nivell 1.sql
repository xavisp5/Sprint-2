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




/*-- Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions:
SELECT * FROM company
WHERE id IN ('b-2222','b-2234');*/


/* -- mitjana amount:
select avg(amount) from transaction; */

/* -- ara necessito un llistat d'ids d'empreses que tinguin una transacció amb amount superior a la mitjana;
select distinct company_id from transaction
where amount > (select avg(amount) from transaction); */


/* SELECT * FROM company
WHERE id IN (select distinct company_id from transaction
where amount > (select avg(amount) from transaction)); */




/* 1.3.C. Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses:
SELECT * FROM company
WHERE id NOT IN (select distinct company_id from transaction);  */

-- select distinct company_id from transaction;
-- select distinct id from company;




-- NIVELL 2
-- 2.1. Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. Mostra la data de cada transacció juntament amb el total de les vendes.

/* Select  sum(amount), Date(timestamp) AS date from transaction
GROUP BY Date(timestamp)
order by sum(amount) desc
limit 5; */

/* -- 2.2. Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.
select country, avg(transaction.amount) from company
left join transaction
ON company.id = transaction.company_id
Group by company.country
order by avg(transaction.amount) desc;  */


-- En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la companyia "Non Institute".
-- Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.
-- 2.3.A - Mostra el llistat aplicant JOIN i subconsultes.

/* select company_name, transaction.* from company
left join transaction
ON company.id = transaction.company_id
where country = (select country from company
where company_name = 'Non Institute'); */





-- 2.3.B - Mostra el llistat aplicant solament subconsultes.
select * from transaction
where company_id IN (select id from company
where country = (select country from company
where company_name = 'Non Institute'));



