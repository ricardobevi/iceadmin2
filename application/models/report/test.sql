SELECT *
FROM 
	ticket AS T 
	    JOIN product_ticket AS PT ON T.id = PT.ticket_id
	    JOIN product AS P ON PT.product_id = P.id
	    JOIN product_price AS PP ON P.id = PP.product_id
	    JOIN price AS Pr ON PP.price_id = Pr.id
	WHERE 
		T.date_time BETWEEN '2017-12-10 06:00:00' AND '2017-12-10 06:00:00' + INTERVAL 23 HOUR + INTERVAL 59 MINUTE + INTERVAL 59 SECOND
