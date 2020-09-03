% map coordinates
% map_8.txt -> (14,1), (4, 2), (2, 2), (14, 10) & (1, 18)
% map_1.txt -> (2, 2), (6, 2), (10, 2), (2, 4), (10,14) & (12, 6)

startCol = 1;
startRow = 14;
goalCol = 18;
goalRow = 1;

map = map_convert("map_8.txt");

f = @() a_star(startCol, startRow, goalCol, goalRow, map);
t = timeit(f);
disp("Time: ");
disp(t);

path = a_star(startCol, startRow, goalCol, goalRow, map);
plotmap(map, path)
