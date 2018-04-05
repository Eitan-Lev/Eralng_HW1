-module(shapes).
-export([shapesArea/1]).
-export([squaresArea/1]).
-export([trianglesArea/1]).
-export([shapesFilter/1]).
-export([shapesFilter2/1]).

% Wrapper- Starts calculating using the tail recursioive funciton
shapesArea({shapes, List}) -> shapesArea({shapes,List},0).
% Tail recursive function, using the helper shapes calculators
shapesArea({shapes, []}, Sum) -> Sum;
shapesArea({shapes,[H|T]}, Sum) -> shapesArea({shapes,T},Sum+area(H)).

squaresArea(Data) -> shapesArea((shapesFilter2(square))(Data)).

trianglesArea(Data) -> shapesArea((shapesFilter(triangle))(Data)).

shapesFilter(DesiredShape) when
  ((DesiredShape == rectangle) or
  (DesiredShape == triangle) or (DesiredShape == ellipse)) ->
    fun({shapes, List}) -> {shapes,[Shape || Shape <- List,
      element(1,Shape) =:= DesiredShape,
      validateShape(Shape)]}
    end.

shapesFilter2(DesiredShape) ->
case DesiredShape of
  square -> fun({shapes,List}) -> {shapes,[Shape ||
    Shape={rectangle,{dim,X,X}} <- List, validateShape(rectangle)]} end;
  circle -> fun({shapes,List}) -> {shapes,[Shape ||
    Shape={ellipse,{radius,X,X}} <- List], validateShape(ellipse)} end;
  _ -> shapesFilter(DesiredShape)
end.

% Helper methods for filtering shapes
validateShape({ShapeType,{Atom,X,Y}})
  when ((X > 0) and (Y > 0)) -> validateShape(ShapeType,Atom).
validateShape(ShapeType,dim)
  when ((ShapeType =:= rectangle) or (ShapeType == triangle)) -> true;
validateShape(ellipse,radius) -> true.

% Helper methods for calculating the area
area({rectangle,{dim,Width,Height}}) when ((Width > 0) and (Height > 0)) ->
  Width * Height;
area({triangle,{dim,Base, Height}}) when ((Base > 0) and (Height > 0))->
  Base * Height * 0.5;
area({ellipse,{radius, Radius1, Radius2}}) when ((Radius1 > 0) and (Radius2 > 0))->
  Radius1 * Radius2 * math:pi().
