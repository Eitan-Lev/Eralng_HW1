-module(shapes_test).
-include_lib("eunit/include/eunit.hrl").
-export([run_all_tests/0]).


run_all_tests() ->
  test_shapes_area(),
  test_squares_area(),
  test_triangles_area(),
  test_shapes_filter().


test_shapes_area() ->
  % "Global" variables used for testing
  Illegal_name = {shappes,[{rectangle,{dim,1,2}},{ellipse,{radius,3,9}},{triangle,{dim,11,12}}]},
  Illegal_dims = {shapes,[{rectangle,{dim,1,2}},{ellipse,{radius,-3,9}},{triangle,{dim,0,0}}]},
  Illegal_format = {[{rectangle,{dim,1,2}},{ellipse,{radius,3,9}},{triangle,{dim,11,12}}],shapes},
  Empty = {shapes,[]},
  Okay_int = {shapes,[{rectangle,{dim,1,2}},
                      {ellipse,{radius,2,3}},
                      {triangle,{dim,1,2}},
                      {rectangle,{dim,3,3}},
                      {ellipse,{radius,4,4}},
                      {triangle,{dim,4,2}}]},
  Okay_float = {shapes,[{rectangle,{dim,1.5,2.0}},
                      {ellipse,{radius,4.0,4.5}},
                      {triangle,{dim,3.3,2.7}}]},
  Result1 = 2 + 6*math:pi() + 1 + 9 + 16*math:pi() + 4,
  Result2 = 1.5 * 2 + 4*4.5*math:pi() + 3.3*2.7*0.5,

  % Testing illegal cases
  ?assertError(function_clause, shapes:shapesArea(Illegal_name)),
  ?assertError(function_clause, shapes:shapesArea(Illegal_dims)),
  ?assertError(function_clause, shapes:shapesArea(Illegal_format)),

  % Testing valid cases
  ?assertEqual(Result1, shapes:shapesArea(Okay_int)),
  ?assertEqual(Result2, shapes:shapesArea(Okay_float)),
  ?assertEqual(0, shapes:shapesArea(Empty)).


test_squares_area() ->
  % "Global" variables used for testing
  Illegal_name = {shappes,[{rectangle,{dim,1,2}},{ellipse,{radius,3,9}},{triangle,{dim,11,12}}]},
  Illegal_dims = {shapes,[{rectangle,{dim,1,2}},{ellipse,{radius,-3,9}},{triangle,{dim,0,0}}]},
  Illegal_format = {[{rectangle,{dim,1,2}},{ellipse,{radius,3,9}},{triangle,{dim,11,12}}],shapes},
  Empty = {shapes,[]},
  Only_Squares = {shapes,[{rectangle,{dim,1,1}},
                      {rectangle,{dim,2,2}},
                      {rectangle,{dim,3,3}},
                      {rectangle,{dim,4,4}},
                      {rectangle,{dim,5,5}},
                      {rectangle,{dim,6,6}}]},
  No_Squares = {shapes,[{rectangle,{dim,1.5,2.0}},
                      {ellipse,{radius,4.0,4.5}},
                      {triangle,{dim,3.3,3.3}},
                      {rectangle,{dim,3.3,3.31}}]},
  Mixed =  {shapes,[{rectangle,{dim,1,0.5}},
                      {triangle,{dim,2,2}},
                      {ellipse,{radius,3,3}},
                      {rectangle,{dim,4,4}},
                      {triangle,{dim,5,5}},
                      {ellipse,{radius,6,6}},
                      {rectangle,{dim,2.5,2.5}}]},
  Result_Only = 1 + 4 + 9 + 16 + 25 + 36,
  Result_Mixed = 16 + 2.5 * 2.5,

  % Testing illegal cases
  ?assertError(function_clause, shapes:squaresArea(Illegal_name)),
  ?assertError(function_clause, shapes:squaresArea(Illegal_dims)),
  ?assertError(function_clause, shapes:squaresArea(Illegal_format)),

  % Testing valid cases
  ?assertEqual(Result_Only, shapes:squaresArea(Only_Squares)),
  ?assertEqual(0, shapes:squaresArea(No_Squares)),
  ?assertEqual(0, shapes:squaresArea(Empty)),
  ?assertEqual(Result_Mixed, shapes:squaresArea(Mixed)).


test_triangles_area() ->
  % "Global" variables used for testing
  Illegal_name = {shappes,[{rectangle,{dim,1,2}},{ellipse,{radius,3,9}},{triangle,{dim,11,12}}]},
  Illegal_dims = {shapes,[{rectangle,{dim,1,2}},{ellipse,{radius,-3,9}},{triangle,{dim,0,0}}]},
  Illegal_format = {[{rectangle,{dim,1,2}},{ellipse,{radius,3,9}},{triangle,{dim,11,12}}],shapes},
  Empty = {shapes,[]},
  Only_Triangles = {shapes,[{triangle,{dim,1,2.0}},
                      {triangle,{dim,2,2}},
                      {triangle,{dim,3.2,3.2}},
                      {triangle,{dim,1,4}}]},
  No_Triangles = {shapes,[{rectangle,{dim,1.5,2.0}},
                      {ellipse,{radius,4.0,4.5}},
                      {ellipse,{radius,3.3,3.3}},
                      {rectangle,{dim,3.3,3.31}}]},
  Mixed =  {shapes,[{rectangle,{dim,1,0.5}},
                      {triangle,{dim,2,2}},
                      {ellipse,{radius,3,3}},
                      {rectangle,{dim,4,4}},
                      {triangle,{dim,5,5}},
                      {ellipse,{radius,6,6}},
                      {rectangle,{dim,2.5,2.5}}]},
  Result_Only = 1*2*0.5 + 2*2*0.5 + 3.2*3.2*0.5 + 1*4*0.5,
  Result_Mixed = 2*2*0.5 + 5*5*0.5,

  % Testing illegal cases
  ?assertError(function_clause, shapes:trianglesArea(Illegal_name)),
  ?assertError(function_clause, shapes:trianglesArea(Illegal_dims)),
  ?assertError(function_clause, shapes:trianglesArea(Illegal_format)),

  % Testing valid cases
  ?assertEqual(Result_Only, shapes:trianglesArea(Only_Triangles)),
  ?assertEqual(0, shapes:trianglesArea(No_Triangles)),
  ?assertEqual(0, shapes:trianglesArea(Empty)),
  ?assertEqual(Result_Mixed, shapes:trianglesArea(Mixed)).

test_shapes_filter() ->
  % "Global" variables used for testing
  Illegal_name = {shappes,[{rectangle,{dim,1,2}},{ellipse,{radius,3,9}},{triangle,{dim,11,12}}]},
  Illegal_dims = {shapes,[{rectangle,{dim,1,2}},{ellipse,{radius,-3,9}},{triangle,{dim,0,0}}]},
  Illegal_format = {[{rectangle,{dim,1,2}},{ellipse,{radius,3,9}},{triangle,{dim,11,12}}],shapes},
  Empty = {shapes,[]},
  Mixed_shapes =  {shapes,[{rectangle,{dim,1,0.5}}, {triangle,{dim,2,2}},
                           {ellipse,{radius,3,3}}, {rectangle,{dim,4,4}},
                           {triangle,{dim,5,5}}, {ellipse,{radius,6,6}},
                           {rectangle,{dim,2.5,2.5}}, {ellipse,{radius,1,3}},
                           {triangle,{dim,5.2,0.5}}, {triangle,{dim,3.3,1.1}}
                           ]},
  Only_Triangles =  {shapes,[{triangle,{dim,2,2}},{triangle,{dim,5,5}},
                           {triangle,{dim,5.2,0.5}}, {triangle,{dim,3.3,1.1}}
                           ]},
  Only_Rectangles =  {shapes,[{rectangle,{dim,1,0.5}},{rectangle,{dim,4,4}},
                        {rectangle,{dim,2.5,2.5}}
                        ]},
  Only_Ellipses =  {shapes,[{ellipse,{radius,3,3}},{ellipse,{radius,6,6}},
                            {ellipse,{radius,1,3}}
                           ]},
  Only_Squares =  {shapes,[{rectangle,{dim,4,4}},{rectangle,{dim,2.5,2.5}}
                          ]},
  Only_Circles =  {shapes,[{ellipse,{radius,3,3}},{ellipse,{radius,6,6}}
                          ]},

  % Testing illegal cases
  ?assertError(function_clause, (shapes:shapesFilter(rectangle))(Illegal_name)),
  ?assertError(function_clause, (shapes:shapesFilter2(square))(Illegal_name)),
  ?assertError(function_clause, (shapes:shapesFilter(ellipse))(Illegal_dims)),
  ?assertError(function_clause, (shapes:shapesFilter2(circle))(Illegal_name)),
  ?assertError(function_clause, (shapes:shapesFilter(triangle))(Illegal_format)),
  ?assertError(function_clause, (shapes:shapesFilter2(triangle))(Illegal_name)),

  % Testing valid cases
  ?assertEqual(Empty, (shapes:shapesFilter(triangle))(Empty)),
  ?assertEqual(Empty, (shapes:shapesFilter(ellipse))(Empty)),
  ?assertEqual(Empty, (shapes:shapesFilter(rectangle))(Empty)),

  ?assertEqual(Empty, (shapes:shapesFilter2(triangle))(Empty)),
  ?assertEqual(Empty, (shapes:shapesFilter2(ellipse))(Empty)),
  ?assertEqual(Empty, (shapes:shapesFilter2(rectangle))(Empty)),
  ?assertEqual(Empty, (shapes:shapesFilter2(circle))(Empty)),
  ?assertEqual(Empty, (shapes:shapesFilter2(square))(Empty)),

  ?assertEqual(Only_Triangles, (shapes:shapesFilter(triangle))(Mixed_shapes)),
  ?assertEqual(Only_Rectangles, (shapes:shapesFilter(rectangle))(Mixed_shapes)),
  ?assertEqual(Only_Ellipses, (shapes:shapesFilter(ellipse))(Mixed_shapes)),

  ?assertEqual(Only_Triangles, (shapes:shapesFilter2(triangle))(Mixed_shapes)),
  ?assertEqual(Only_Rectangles, (shapes:shapesFilter2(rectangle))(Mixed_shapes)),
  ?assertEqual(Only_Ellipses, (shapes:shapesFilter2(ellipse))(Mixed_shapes)),
  ?assertEqual(Only_Squares, (shapes:shapesFilter2(square))(Mixed_shapes)),
  ?assertEqual(Only_Circles, (shapes:shapesFilter2(circle))(Mixed_shapes)).
