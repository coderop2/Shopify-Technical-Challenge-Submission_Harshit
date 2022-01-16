-- Question 2 part A
SELECT COUNT(*) FROM Orders AS O
JOIN Shippers AS S
ON S.ShipperID == O.ShipperID
WHERE S.ShipperName == "Speedy Express"

-- Question 2 part B
SELECT LastName, count(E.EmployeeID) as orders 
FROM Orders AS O
LEFT JOIN Employees AS E
ON E.EmployeeID == O.EmployeeID
GROUP BY E.EmployeeID
ORDER BY orders DESC
LIMIT 1

-- Question 2 part C
WITH extracted_data as (
SELECT p.ProductID, p.ProductName, c.CustomerID, c.Country, od.OrderID, od.Quantity
FROM OrderDetails AS od
    
LEFT JOIN Orders AS o
ON od.OrderID == o.OrderID
    
LEFT JOIN Customers as c
ON o.CustomerID == c.CustomerID
    
LEFT JOIN Products AS p
ON p.ProductID == od.ProductID)

-- If we are measuring the most ordered product based on total orders then we do:-
SELECT ProductName, COUNT(*) AS Ordered_Quantity 
FROM extracted_data
WHERE Country == "Germany"
GROUP BY ProductName
ORDER BY Ordered_Quantity DESC
LIMIT 1
    
-- If we are measuring the most ordered product based on total quantity then we do:-
SELECT ProductName, COUNT(*) AS Ordered_Quantity, SUM(Quantity) as Total_Quantity
FROM extracted_data
WHERE Country == "Germany"
GROUP BY ProductName
ORDER BY Total_Quantity DESC
LIMIT 1