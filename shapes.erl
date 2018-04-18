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

shapesFilter(WantedType) when
((WantedType == rectangle) or (WantedType == triangle) or (WantedType == ellipse)) ->
    fun({shapes, List}) -> {shapes,[Shape || Shape <- List,
      validateShape(Shape), element(1,Shape) =:= WantedType]}
      % validateShape needs to be first or unwanted types wont be validated
    end.

shapesFilter2(WantedType)
when ((WantedType /= square) and (WantedType /= circle)) ->
  shapesFilter(WantedType);

shapesFilter2(WantedType) ->
case WantedType of
    square -> fun({shapes, List}) -> {shapes,[OkayShape || OkayShape <- List,
      validateShape(OkayShape),
      element(2,element(2,OkayShape)) == element(3,element(2,OkayShape)),
      rectangle == element(1,OkayShape)]} end;
    circle -> fun({shapes, List}) -> {shapes,[OkayShape || OkayShape <- List,
      validateShape(OkayShape),
      element(2,element(2,OkayShape)) == element(3,element(2,OkayShape)),
      ellipse == element(1,OkayShape)]} end
  end.

% Helper methods for filtering shapes
validateShape({ellipse,{radius,X,Y}}) when ((X > 0) and (Y > 0)) -> true;
validateShape({rectangle,{dim,X,Y}}) when ((X > 0) and (Y > 0)) -> true;
validateShape({triangle,{dim,X,Y}}) when ((X > 0) and (Y > 0)) -> true.

% Helper methods for calculating the area
area({rectangle,{dim,Width,Height}}) when ((Width > 0) and (Height > 0)) ->
  Width * Height;
area({triangle,{dim,Base, Height}}) when ((Base > 0) and (Height > 0))->
  Base * Height * 0.5;
area({ellipse,{radius, Radius1, Radius2}}) when ((Radius1 > 0) and (Radius2 > 0))->
  Radius1 * Radius2 * math:pi().
