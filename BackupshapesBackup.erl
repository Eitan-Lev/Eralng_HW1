-module(shapes).
-export([shapesArea/1]).
-export([squaresArea/1]).
-export([trianglesArea/1]).
-export([shapesFilter/1]).
-export([shapesFilter2/1]).
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
