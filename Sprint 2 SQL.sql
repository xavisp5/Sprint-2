-- NIVELL 1
-- 1.1 Mostra-ho tot
-- select * FROM company;
-- select * FROM credit_card;
-- select * FROM data_user;
-- select * FROM transaction;

-- 1.2.A llistat de paisos que generen vendes:

/* SELECT company.country, COUNT(transaction.id) AS número_vendes
FROM company
INNER JOIN transaction
ON company.id = transaction.company_id
GROUP BY company.country
ORDER BY número_vendes DESC; 
*/
 
/* -- 1.2.B des de quants països es generen vendes:

SELECT COUNT(distinct company.country)
FROM company
JOIN transaction
ON company.id = transaction.company_id
HAVING COUNT(transaction.id) > 0; 
*/


/* -- 1.2.C. Companyia amb la mitjana més gran de vendes:
SELECT company.company_name, avg (transaction.amount)
FROM company
LEFT JOIN transaction
ON company.id = transaction.company_id
GROUP BY company.company_name
ORDER BY avg (transaction.amount) DESC
LIMIT 1;
*/

/* -- 1.3.A. Mostra totes les transaccions realitzades per empreses d'Alemanya
SELECT * FROM transaction
WHERE company_id IN(select company.id from company
where country = "Germany"); 
*/



-- 1.3.B. Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions:
/* --seleccionar dades companyies que tinguin X codis:
SELECT * FROM company
WHERE id IN ('b-2222','b-2234');
*/

-- mitjana amount:
/* select avg(amount) from transaction;
*/

/* -- mitjana amount d'una empresa: 
select company_id, avg(amount) from transaction
GROUP BY company_id
; */

 /* -- ara necessito un llistat d'ids d'empreses que tinguin una transacció amb amount superior a la mitjana;
SELECT distinct company_id from transaction
WHERE (SELECT avg(amount) from transaction
GROUP BY company_id) > (SELECT avg(amount) from transaction);
*/


/* SELECT * FROM company
WHERE id IN (select distinct company_id from transaction
where amount > (select avg(amount) from transaction)); */




-- 1.3.C. Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses:
/* SELECT * FROM company
WHERE id NOT IN (select distinct company_id from transaction); 
*/
-- select distinct company_id from transaction;





-- NIVELL 2
-- 2.1. Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. Mostra la data de cada transacció juntament amb el total de les vendes.

/* Select Date(timestamp) as Data, sum(amount) from transaction
GROUP BY Date(timestamp)
order by sum(amount) desc
limit 5;
*/

-- 2.2. Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.
/* select country, avg(transaction.amount) from company
left join transaction
ON company.id = transaction.company_id
Group by company.country
order by avg(transaction.amount) desc;
*/

-- En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la companyia "Non Institute".
-- Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.
-- 2.3.A - Mostra el llistat aplicant JOIN i subconsultes.

/* select company_name, transaction.* from company
left join transaction
ON company.id = transaction.company_id
where country = (select country from company
where company_name = 'Non Institute');

*/



-- 2.3.B - Mostra el llistat aplicant solament subconsultes.
/* select * from transaction
where company_id IN (select id from company
where country = (select country from company
where company_name = 'Non Institute'));
*/

-- NIVELL 3
-- 3.1 Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions
-- amb un valor comprès entre 350 i 400 euros i en alguna d'aquestes dates:
-- 29 d'abril del 2015, 20 de juliol del 2018 i 13 de març del 2024.
-- Ordena els resultats de major a menor quantitat.

/* select company_name, phone, country, DATE(transaction.timestamp) AS data , transaction.amount from company
inner join transaction
ON company.id = transaction.company_id
WHERE transaction.amount > 350 AND transaction.amount < 400
AND DATE(transaction.timestamp) IN('2015-04-29','2018-07-20','2024-03-13')
ORDER BY transaction.amount DESC;
*/

-- 3.2 un llistat de les empreses on especifiquis si tenen més de 400 transaccions o menys.

/* SELECT *, Mes_de_400_vendes from company
LEFT JOIN transaction
ON company.id = transaction.company_id
SET Mes_de_400_vendes =
	CASE
		WHEN COUNT(transaction.id) > 400 THEN 'Sí'
        ELSE 'No'
	END; */


/* SELECT *, COUNT(transaction.id) from company
    INNER JOIN transaction
    ON company.id = transaction.company_id
        CASE 
        WHEN COUNT(transaction.id) > 400 THEN 'Sí'
        ELSE 'No'
    END AS Mes_de_400_vendes
FROM transaction;
 */ 
 
 /* 
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails; 
 */
 
SELECT company.company_name, COUNT(transaction.id) AS Numero_transaccions,
	CASE
		WHEN COUNT(transaction.id) > 400 THEN 'Sí'
		ELSE 'No'
    END AS Mes_de_400_vendes
FROM company
INNER JOIN transaction
ON company.id = transaction.company_id
group by company_id
order by company_name ASC;
    

