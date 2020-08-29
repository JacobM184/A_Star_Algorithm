# A_Star_Algorithm
Implementation of the A* Pathfinding algorithm in MATLAB

## Instructions

This A* Algorithm takes the following 5 inputs:
- startCol - this is the column value for the starting position
- startRow - this is the row value for the starting position
- goalCol - this is the column value for the goal position
- goalRow - this is the row value for the goal position
- map - this is the matrix that represents the map

Note: the end positions for the two provided maps in (row, col) format are as follows:
- map_8.txt -> (14,1) & (1, 18)
- map_1.txt -> (2, 2), (6, 2), (10, 2) & (12, 6)

Note that the algorithm currently moves through all spaces with a value of '0'. If you would like to change this behaviour, edit the value of the **Obstruction** variable.

## Outputs

This function outputs a list of coordinates from the goal coordinate to the start coordinate. The list will be of the size (numOfElementsInMap, 2). the first column of each row will hold a row coordinate value, and the second column will hold a column coordinate value.

Because the backtracking function is rather basic, this list will usually have a size larger than the route to be returned. This means that there will be a number of zero terms after the start coord and the end of list. Note that this function does NOT plot the path, though it may easily be plotted using the outputted list.

If you would also like to output each row and column as the algorithm goes to it, then uncomment lines 70 to 73 in the a_star.m file.
