-module(game).
-export([canWin/1]).
-export([nextMove/1]).
-export([explanation/0]).

canWin(N) when N > 0 ->
  if
    (N == 1) or (N == 2) -> true;
    N > 2 -> not(canWin(N-1) and canWin(N-2))
  end.

nextMove(N) when N > 0 ->
  case canWin(N) of
    false -> false;
    true when (N =< 2) -> {true,N};
    _ ->
      case {canWin(N-1),canWin(N-2)} of       %Player 2 possible actions
        {true,true} -> false;                 %Player 2 wins either way
        {true,false} -> {true,2};             %Player 2 wins only if Player 1 draws 1
        {false,_} -> {true,1}                 %Player 1 can win if he draws 1
      end
  end.

explanation() -> {'We have an opponent in the game, so we must consider every
  option of his moves. We get a tree type of recursion. Tail recursion
  requires saving the memory of recursive calls. It is difficult to make
  the tree recursion behave as a tail recursion'}.
