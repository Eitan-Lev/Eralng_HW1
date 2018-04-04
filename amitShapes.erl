-module (amitShapes).
-export ([shapesArea/1, squaresArea/1, trianglesArea/1, shapesFilter/1, shapesFilter2/1]).

% Wrapper- Starts calculating using the tail recursioive funciton
shapesArea({shapes, List}) ->
  shapesArea({shapes,List},0).
% Tail recursive function, using the helper shapes calculators
shapesArea({shapes, []}, Acc) ->
    Acc;
shapesArea({shapes,[Head | Tail]}, Acc) ->
  shapesArea({shapes,Tail},Acc+area(Head)).

% Creating a list composed of squares and returning its total sum
squaresArea({shapes,List}) ->
  lists:sum([X*X || {rectangle,{dim,X,X}}<- List]).

% Creating a list composed of triangles and returning its total sum
trianglesArea({shapes,List}) ->
  lists:sum([Base * Height * 0.5 || {triangle,{dim,Base,Height}}<- List]).

shapesFilter(WantedType) ->
  fun({shapes, List}) ->
    {shapes,[OkayShape|| OkayShape = {ShapeType,_shapeProperties}<- List, ShapeType =:= WantedType]}
  end.

shapesFilter2(WantedType) ->
case WantedType of
    rectangle -> shapesFilter(WantedType);
    ellipse -> shapesFilter(WantedType);
    triangle  -> shapesFilter(WantedType);
    square -> fun({shapes, List}) ->
                {shapes,[OkayShape|| OkayShape = {rectangle,{dim,X,Y}}<- List, X =:= Y]}
              end;
    circle -> fun({shapes, List}) ->
                {shapes,[OkayShape|| OkayShape = {ellipse,{dim,X,Y}}<- List, X =:= Y]}
              end
  end.

% Helper methods for calculating the area
area({rectangle,{dim,Width,Height}}) when ((Width > 0) and (Height > 0)) ->
  Width * Height;
area({triangle,{dim,Base, Height}}) when ((Base > 0) and (Height > 0))->
  Base * Height * 0.5;
area({ellipse,{dim, Radius1, Radius2}}) when ((Radius1 > 0) and (Radius2 > 0))->
  Radius1 * Radius2 * math:pi().
