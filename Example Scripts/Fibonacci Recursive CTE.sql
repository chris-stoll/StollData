;WITH Fibobacci50 (nest_level, fib_num, prev_num)
AS
(
	SELECT 1, CAST(0 AS BIGINT), CAST(1 AS BIGINT) --anchor/start
	UNION ALL
    SELECT b.nest_level+1, b.fib_num+b.prev_num, b.fib_num --increment
	FROM Fibobacci50 b
	WHERE b.nest_level < 50
)
SELECT 
	[NumberOrder] = cte.nest_level, [FibonacciNumber] = cte.fib_num
FROM Fibobacci50 cte