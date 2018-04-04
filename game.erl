-module (game).
-export ([canWin/1, nextMove/1, explanation/0]).

canWin(N) when N > 0 ->
  if
    (N == 1) or (N == 2) -> true;
    N > 2 -> not(canWin(N-1) and canWin(N-2))
  end.

nextMove(N) when N > 0 ->
  case canWin(N) of
    false -> false;
    true ->
      if
        N == 1 -> {true, 1};
        N == 2 -> {true, 2};
        N > 2  ->
          case (canWin(N-2) and canWin(N-3)) of
            true -> {true, 1};
            false-> {true, 2}
          end
      end
  end.

explanation() ->
  {'Because we also have an opponent in the game, we must consider every option of his moves. That way we are getting a "tree" type of recursion.
    It is difficult to make the tree recursion behave as a tail recursion'}.
