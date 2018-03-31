-module(shapes).
-export([shapesArea/1]).
-export([squaresArea/1]).
-export([trianglesArea/1]).
-export([shapesFilter/1]).
-export([shapesFilter2/1]).

filterList({Atom,List}, ShapeType) -> _=checkValidData({Atom,List}),
  case ShapeType of
    square -> ({shapes,[{Y,{_Param1,Param2,Param3}} || {Y,{_Param1,Param2,Param3}} <- List,
      (Y == ShapeType)]});
    circle -> ({shapes,[{Y,{_Param1,Param2,Param3}} || {Y,{_Param1,Param2,Param3}} <- List,
            Y == ShapeType,(Param2 == Param3)]});
    _ -> ({shapes,[{Y,{_Param1,_Param2,_Param3}} ||
    {Y,{_Param1,_Param2,_Param3}} <- List, Y == ShapeType]})
  end.


filterList({Atom,List}, ShapeType) -> _=checkValidData({Atom,List}),
  MatchingList = ({shapes,[{Y,{_Param1,_Param2,_Param3}} ||
  {Y,{_Param1,_Param2,_Param3}} <- List, Y == ShapeType]}),
  case ShapeType of
    square -> Result = filterSquareCircleList(MatchingList);
    circle -> Result = filterSquareCircleList(MatchingList);
    _ -> Result = MatchingList
  end, Result.

filterSquareCircleList({_atom,List}) ->
  ({shapes,eitan(List)}).
  %({shapes,(another(List))}).
  %({shapes,lists:reverse(another(List))}).
  %({shapes,[X || X <- List, equalSizes(X)]}).

shapesArea(_Data) -> io:format("Hello world!~n").
squaresArea(Data) -> _=checkValidData(Data),calculateArea((shapesFilter(rectangle))(Data)).%change to square
checkValidData(Data) ->
  case Data of
    {shapes,[]} -> {shapes,[]};
    {shapes,[{Shape,{Param1,Param2,Param3}H|T]} ->
      case H of
        {Shape,{Param1,Param2,Param3}}
        when (((Shape == triangle) or (Shape == rectangle)) and (Param1 == dim)
          or ((Shape == ellipse) and (Param1 == redius))
          and ((Param2 > 0) and (Param3 > 0))) -> checkValidData({shapes,T})
      end
  end.
checkValidData(Data) ->
  case Data of
    {shapes,[]} -> {shapes,[]};
    {shapes,[H|T]} ->
      case H of
        {Shape,{Param1,Param2,Param3}}
        when (((Shape == triangle) or (Shape == rectangle)) and (Param1 == dim)
          or ((Shape == ellipse) and (Param1 == redius))
          and ((Param2 > 0) and (Param3 > 0))) -> checkValidData({shapes,T})
      end
  end.
calculateArea(Data) -> calculateArea(Data, 0).
calculateArea(Data, Sum) ->
  case Data of
    {_shapes, []} -> Sum;
    {_shapes,[H|T]} ->
      case H of
        {triangle,{_dim,Base,Height}} -> calculateArea({shapes,T},(Sum + ((Base+Height)/2)));
        {rectangle,{_dim,Width,Height}} -> calculateArea({shapes,T},(Sum + (Width*Height)));
        {ellipse,{_redius,Radius1,Radius2}} -> calculateArea({shapes,T},(Sum + (math:pi())*Radius1*Radius2))
      end
  end.

trianglesArea(Data) -> _=checkValidData(Data),calculateArea((shapesFilter(triangle))(Data)).
shapesFilter(X) -> case X of
  rectangle -> ShapeType = rectangle;
  triangle -> ShapeType = triangle;
  ellipse -> ShapeType = ellipse
end, fun(N) -> (filterList(N, ShapeType)) end.

filterList({_shapes,List}, ShapeType) -> {shapes,
  [{Y,{_Dim,_Param1,_Param2}} || {Y,{_Dim,_Param1,_Param2}} <- List,
  Y == ShapeType]}.
shapesFilter2(_Data) -> io:format("Hello world!~n").





-module(shapes).
-export([shapesArea/1]).
-export([squaresArea/1]).
-export([trianglesArea/1]).
-export([shapesFilter/1]).
-export([shapesFilter2/1]).

shapesArea(Data) -> _=checkValidData(Data),calculateArea(Data).

squaresArea(Data) -> _=checkValidData(Data),calculateArea((shapesFilter2(square))(Data)).%change to square

trianglesArea(Data) -> _=checkValidData(Data),calculateArea((shapesFilter(triangle))(Data)).

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
    {_,[{triangle,{_dim,Base,Height}}|T]} -> calcArea({shapes,T},(Sum + ((Base+Height)/2)));
    {_,[{rectangle,{_dim,Width,Height}}|T]} -> calcArea({shapes,T},(Sum + (Width*Height)));
    {_,[{ellipse,{_redius,Radius1,Radius2}}|T]} -> calcArea({shapes,T},(Sum + (math:pi())*Radius1*Radius2))
  end.

shapesFilter(X) -> case X of
  rectangle -> ShapeType = rectangle;
  triangle -> ShapeType = triangle;
  ellipse -> ShapeType = ellipse
end, fun(N) -> (filterList(N, ShapeType)) end.


filterSquareCircleList(List,ShapeType) ->
  [{Y,{_Param1,Param2,Param3}} || {Y,{_Param1,Param2,Param3}} <- List,
  Y == ShapeType, Param2 == Param3].

filterList({Atom,List}, ShapeType) -> _=checkValidData({Atom,List}),
  case ShapeType of
    square -> NewShape = rectangle;
    circle -> NewShape = EllipseGoodList;
    _ -> NewShape = ShapeType
  end,
  newList = [{Y,{_Param1,_Param2,_Param3}} ||
  {Y,{_Param1,_Param2,_Param3}} <- List, Y == ShapeType],
  case NewShape of
    circle -> {Atom,filterSquareCircleList(List,ellipse)};
    _ -> {shapes,[{Y,{_Param1,_Param2,_Param3}} ||
    {Y,{_Param1,_Param2,_Param3}} <- List, Y == ShapeType]}
  end.
  case ShapeType of
    square -> {Atom,filterSquareCircleList(List,rectangle)};
    circle -> {Atom,filterSquareCircleList(List,ellipse)};
    _ -> {shapes,[{Y,{_Param1,_Param2,_Param3}} ||
    {Y,{_Param1,_Param2,_Param3}} <- List, Y == ShapeType]}
  end.

shapesFilter2(X) -> case X of
  square -> fun(N) -> (filterList(N, square)) end;
  circle -> fun(N) -> (filterList(N, circle)) end;
  _ -> shapesFilter(X)
end.
