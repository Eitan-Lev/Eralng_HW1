-module(shapes).
-export([shapesArea/1]).
-export([squaresArea/1]).
-export([trianglesArea/1]).
-export([shapesFilter/1]).
-export([shapesFilter2/1]).

shapesArea(Data) -> _=checkValidData(Data),calculateArea(Data).

squaresArea(Data) -> _=checkValidData(Data),calculateArea((shapesFilter2(square))(Data)).%change to square

trianglesArea(Data) -> _=checkValidData(Data),calculateArea((shapesFilter(triangle))(Data)).

shapesFilter(X) -> case X of
  rectangle -> ShapeType = rectangle;
  triangle -> ShapeType = triangle;
  ellipse -> ShapeType = ellipse
end, fun(N) -> (filterList(N, ShapeType)) end.

shapesFilter2(X) -> case X of
  square -> fun(N) -> (filterList(N, square)) end;
  circle -> fun(N) -> (filterList(N, circle)) end;
  _ -> shapesFilter(X)
end.

filterSquareCircleList(List,ShapeType) ->
  [{Y,{_Param1,Param2,Param3}} || {Y,{_Param1,Param2,Param3}} <- List,
  Y == ShapeType, Param2 == Param3].

filterList({Atom,List}, ShapeType) -> _=checkValidData({Atom,List}),
  case ShapeType of
    square -> {Atom,filterSquareCircleList(List,rectangle)};
    circle -> {Atom,filterSquareCircleList(List,ellipse)};
    _ -> {shapes,[{Y,{_Param1,_Param2,_Param3}} ||
    {Y,{_Param1,_Param2,_Param3}} <- List, Y == ShapeType]}
  end.

checkValidData(Data) ->
  case Data of
    {shapes,[]} -> {shapes,[]};
    {shapes,[{Shape,{Param1,Param2,Param3}}|T]} when
      ((((Shape == triangle) or (Shape == rectangle)) and (Param1 == dim))
      or ((Shape == ellipse) and (Param1 == radius))
      and ((Param2 > 0) and (Param3 > 0))) -> checkValidData({shapes,T})
  end.

calculateArea(Data) -> calcArea(Data, 0).
calcArea(Data, Sum) ->
  case Data of
    {_, []} -> Sum;
    {_,[{triangle,{_dim,Base,Height}}|T]} -> calcArea({shapes,T},(Sum + ((Base*Height)/2)));
    {_,[{rectangle,{_dim,Width,Height}}|T]} -> calcArea({shapes,T},(Sum + (Width*Height)));
    {_,[{ellipse,{_redius,Radius1,Radius2}}|T]} -> calcArea({shapes,T},(Sum + (math:pi())*Radius1*Radius2))
  end.
