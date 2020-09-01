% map coordinates
% map_8.txt -> (14,1) & (1, 18)
% map_1.txt -> (2, 2), (6, 2), (10, 2), (2, 4), (10,14) & (12, 6)

startCol = 2;
startRow = 2;
goalCol = 14;
goalRow = 10;

map = map_convert("map_1.txt");

f = @() a_star(startCol, startRow, goalCol, goalRow, map);
t = timeit(f);
disp("Time: ");
disp(t);