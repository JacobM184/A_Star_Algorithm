%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           A* Pathfinding Algorithm               %
%           Author: Jacob Mukkada                  %
%           Date: 30/08/2020                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function path = a_star(startCol, startRow, goalCol, goalRow, map)

    % get size of map
    mapSize = size(map);
    mapNumEl = numel(map);
    
    % set what value nodes are NOT obstructions
    Obstruction = 1;
    
    % default return
    path = [];
    
    % create sets for unvisited nodes
    openSet = true(mapSize);
    
    % set start node to false in unvisted set
    openSet(startRow, startCol) = false;
    
    % origin set
    cameFrom = zeros(mapSize(1), mapSize(2), 2);
    
    % set G cost to infinity for all nodes except for start node
    gCost = inf(mapSize);
    gCost(startRow, startCol) = 0;
    
    % set F cost to infinity everywhere
    fCost = inf(mapSize);
    
    % For start, calculate the H Cost + G cost (which is 0) an update
    fCost(startRow, startCol) = calcH(startCol, startRow, goalCol, goalRow);
    
    % define moves
    moves = [[-1, 0]; [0, -1]; [1, 0]; [0, 1]];

    % loop while there are undiscovered nodes
    while any(openSet(:) == true)

        % find coords of minimum fCost on the map
        [~, idx] = min(fCost(:));
        [currRow, currCol] = ind2sub(size(fCost), idx);
        
        % check if goal has been reached
        if ((currRow == goalRow) && (currCol == goalCol))
            path = backtrackPath(cameFrom, goalCol, goalRow, mapNumEl, startCol, startRow);
            return
        end
        
        
        % Code for DEBUGGING only %
        %disp("Row: ")            %
        %disp(currRow)            %
        %disp("Col: ")            %
        %disp(currCol)            %
        %-------------------------%
        
        % remove current from openSet set
        openSet(currRow, currCol) = false;
        
        % set F cost of current node to infinity to avoid reselection
        fCost(currRow, currCol) = inf;
        
        % G cost for neighbours 
        neighbourG = 1;

        % loop to go through all the 4 possible surrounding neighbours
        for i = 1:4
            
            % get coords for neighbour i
            neighbourRow = currRow + moves(i,1);
            neighbourCol = currCol + moves(i,2);
            
            
            % verify if the neighbour coords are within the map and that
            % the neighbour in question is not an obstruction 
            if((neighbourRow <= mapSize(1)) && (neighbourCol <= mapSize(2))...
                    && (neighbourRow >= 1) && (neighbourCol >= 1)...
                    && (map(neighbourRow, neighbourCol) ~= Obstruction))
                
                % get tentative G Cost
                tentative_GCost = gCost(currRow, currCol) + neighbourG;
                
                % if statement to update G and F cost-sets if path is
                % shorter than existing
                if(tentative_GCost < gCost(neighbourRow, neighbourCol))
                    
                    % update origin
                    cameFrom(neighbourRow, neighbourCol, 1) = currRow; 
                    cameFrom(neighbourRow, neighbourCol, 2) = currCol;
                    
                    % update G cost for the neighbour
                    gCost(neighbourRow, neighbourCol) = tentative_GCost;
                    
                    hCost = calcH(neighbourCol, neighbourRow, goalCol, goalRow);
                    
                    % update F cost for the neighbour using F = G + H
                    fCost(neighbourRow, neighbourCol) = gCost(neighbourRow, neighbourCol) + hCost;
                end
            end
            
        end
        
    end
    

end

function heuristic = calcH(fromCol, fromRow, toCol, toRow)
    % Pythagoras theorem to find Euclidean distance to goal
    heuristic = sqrt((fromCol - toCol).^2 + (fromRow - toRow).^2);
end

function routeF = backtrackPath(cameFrom, goalCol, goalRow, mapNumEl, ...
    startCol, startRow)
  
    % create matrix to store the route
    routeF = [];
    route = [];
    
    % set first values (this will be the ending coordinates)
    route(1, 1) = goalRow;
    route(1, 2) = goalCol;

    % set the placeholder row and column values to the goal row and column
    prevRow = goalRow;
    prevCol = goalCol;

    % for loop to go through all path elements
    for count = 2:mapNumEl

        % update route with new coord values
        route(count, 1) = cameFrom(prevRow, prevCol, 1);
        route(count, 2) = cameFrom(prevRow, prevCol, 2);

        % update placeholder coords with lates route coords
        prevRow = route(count, 1);
        prevCol = route(count, 2);
        
        % protection from invalid row value
        if((prevRow < 1) || (prevCol < 1))
            routeF = route(1:count, :);
            routeF = flip(routeF);
            return
        end
        
        % code to stop loop once start has been reached
        if(route(count, :) == [startRow, startCol])
            routeF = route(1:count, :);
            routeF = flip(routeF);
            return
        end   
    end 
end
