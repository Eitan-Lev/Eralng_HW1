-module(shapes).
-export([shapesArea/1]).
-export([squaresArea/1]).
-export([trianglesArea/1]).
-export([shapesFilter/1]).
-export([shapesFilter2/1]).

shapesArea(Data) -> _=checkValidData(Data),calculateArea(Data).

squaresArea(Data) -> shapesArea((shapesFilter2(square))(Data)).

trianglesArea(Data) -> shapesArea((shapesFilter(triangle))(Data)).

shapesFilter(X) ->
  case X of
    rectangle -> (fun(N) -> (filterList(N, X)) end);
    triangle -> (fun(N) -> (filterList(N, X)) end);
    ellipse -> (fun(N) -> (filterList(N, X)) end)
  end.

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

validateShape({ShapeType,{Atom,X,Y}}) when ((X > 0) and (Y > 0)) ->
  case ShapeType of
    triangle -> Atom =:= dim;
    rectangle -> Atom =:= dim;
    ellipse -> Atom =:= radius
  end.




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
((DesiredShape == rectangle) or (DesiredShape == triangle) or (DesiredShape == ellipse)) ->
    fun({shapes, List}) -> {shapes,[Shape || Shape <- List,
      element(1,Shape) =:= DesiredShape, validateShape(Shape)]}
    end;
      %X > 0, Y > 0]},

% shapesFilter(DesiredShape) when ((DesiredShape == ellipse) ->
%     fun({shapes, List}) -> {shapes,[Shape || Shape={_,{radius,X,Y}} <- List,
%       element(1,Shape) =:= DesiredShape,
%       X > 0, Y > 0]}
%     end.

% shapesFilter(WantedType) ->
%   fun({shapes, List}) ->
%     {shapes,[OkayShape || OkayShape = {ShapeType,{Atom,X,Y}}<- List,
%     ShapeType == WantedType, X > 0, Y > 0,
%     (((ShapeType == ellipse) and (Atom == radius)) or
%     ((ShapeType == rectangle) or (ShapeType == triangle)) and (Atom == dim))]}
%   end.

% shapesFilter(WantedType) when
% ((WantedType == ellipse) or (WantedType == rectangle) or (WantedType == triangle)) ->
%   fun({shapes, List}) ->
%     % {shapes,[OkayShape || OkayShape = {ShapeType,{radius,X,Y}} <- List,
%     {shapes,[OkayShape || OkayShape = {ShapeType,{Atom,X,Y}} <- List,
%     case Atom of
%       radius -> ShapeType == ellipse;
%       dim -> ((ShapeType == rectangle) or (ShapeType == triangle))
%     end,
%     % {shapes,[OkayShape = {ShapeType,{radius,X,Y}} || OkayShape = {WantedType,{radius,X > 0,Y > 0}} <- List,
%     ShapeType == WantedType, X > 0, Y > 0]}
%   end.

% shapesFilter(WantedType) when (WantedType == ellipse) ->
%   fun({shapes, List}) ->
%     % {shapes,[OkayShape || OkayShape = {ShapeType,{radius,X,Y}} <- List,
%     {shapes,[OkayShape || OkayShape = {ShapeType,{Atom,X,Y}} <- List,
%     case WantedType of
%       ellipse -> ((X > 0) and (Y > 0));
%       rectangle -> ((X > 0) and (Y > 0))
%     end,
%     % {shapes,[OkayShape = {ShapeType,{radius,X,Y}} || OkayShape = {WantedType,{radius,X > 0,Y > 0}} <- List,
%     ShapeType == WantedType, X > 0, Y > 0]}
%   end;

% shapesFilter(WantedType)
% when ((WantedType == rectangle) or (WantedType == triangle)) ->
%   fun({shapes, List}) ->
%     {shapes,[OkayShape || OkayShape = {ShapeType,{dim,X,Y}} <- List,
%     ShapeType == WantedType, X > 0, Y > 0]}
%   end.

shapesFilter2(WantedType)
when ((WantedType /= square) and (WantedType /= circle)) ->
  shapesFilter(WantedType);

shapesFilter2(WantedType) ->
case WantedType of
    square -> fun({shapes, List}) -> {shapes,[OkayShape || OkayShape = {rectangle,{dim,X,X}} <- List]} end;
    circle -> fun({shapes, List}) -> {shapes,[OkayShape || OkayShape = {ellipse,{radius,X,X}} <- List]} end
  end.

% shapesFilter2(DesiredShape) ->
% case DesiredShape of
%   square -> fun({shapes,List}) -> {shapes,[Shape ||
%     Shape={rectangle,{dim,X,X}} <- List, validateShape(rectangle)]} end;
%   circle -> fun({shapes,List}) -> {shapes,[Shape ||
%     Shape={ellipse,{radius,X,X}} <- List], validateShape(ellipse)} end;
%   _ -> shapesFilter(DesiredShape)
% end.

% Helper methods for filtering shapes
validateShape({ellipse,{radius,X,Y}})
  when ((X > 0) and (Y > 0)) -> true.
validateShape({ShapeType,{dim,X,Y}})
  when ((X > 0) and (Y > 0) and
  ((ShapeType =:= rectangle) or (ShapeType == triangle)))
  -> validateShape(ShapeType,Atom).
% validateShape(ShapeType,dim)
%   when ((ShapeType =:= rectangle) or (ShapeType =:= triangle)) -> true;
% validateShape(ellipse,radius) -> true.

% Helper methods for calculating the area
area({rectangle,{dim,Width,Height}}) when ((Width > 0) and (Height > 0)) ->
  Width * Height;
area({triangle,{dim,Base, Height}}) when ((Base > 0) and (Height > 0))->
  Base * Height * 0.5;
area({ellipse,{radius, Radius1, Radius2}}) when ((Radius1 > 0) and (Radius2 > 0))->
  Radius1 * Radius2 * math:pi().
