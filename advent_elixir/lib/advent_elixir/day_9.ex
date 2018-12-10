defmodule AdventElixir.Day9 do

  defmodule State do
    defstruct cur_player: 0, num_players: nil, scores: nil, circle: [], circle_len: 0, current_index: nil

    def new(num_players) do
      scores = for player <- 0..(num_players-1), into: %{}, do: {player, 0}

      %__MODULE__{scores: scores, num_players: num_players}
    end

    def update(state, {circle, circle_len, next_index, score}) do
      %{state | scores: Map.update(state.scores, state.cur_player, 0, & &1 + score), current_index: next_index, circle: circle, circle_len: circle_len, cur_player: rem(state.cur_player + 1, state.num_players)}
    end
  end

  @doc """
  iex> marbles(9, 25)
  32
  """
  def marbles(num_players, num_marbles) do
    final_state =
      Enum.reduce(0..num_marbles, State.new(num_players), fn marble, state ->
        next_state = next_circle(state.circle, state.circle_len, state.current_index, marble)

        State.update(state, next_state)
      end)

    final_state.scores
    |> Enum.max_by(fn {_k, value} -> value end)
    |> elem(1)
  end

  @doc """
  Returns the next circle, the current index of the circle,
  and any points earned during

  iex> next_circle([0], 1, 0, 1)
  {[0, 1], 2, 1, 0}

  iex> next_circle([], 0, 0, 0)
  {[0], 1, 0, 0}

  iex> next_circle([0, 1], 2, 1, 2)
  {[0, 2, 1], 3, 1, 0}

  iex> next_circle([0, 2, 1], 3, 1, 3)
  {[0, 2, 1, 3], 4, 3, 0}


  iex> next_circle([0, 1, 2, 3, 4, 5, 6, 7], 8, 7, 23)
  {[1, 2, 3, 4, 5, 6, 7], 7, 0, 23}

  iex> next_circle([0, 1, 2, 3, 4, 5, 6, 7], 8, 6, 23)
  {[0, 1, 2, 3, 4, 5, 6], 7, 6, 30}

  iex> next_circle([0, 1, 2, 3, 4, 5, 6, 7], 8, 5, 46)
  {[0, 1, 2, 3, 4, 5, 7], 7, 6, 52}

  iex> next_circle([0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15], 23, 13, 23)
  {[0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15], 22, 6, 32}
  """
  def next_circle([], current_len, _current_index, 0), do: {[0], 1, 0, 0}
  def next_circle(list, current_len, current_index, next_marble) when rem(next_marble, 23) == 0 do
    next_index = current_index - 7
    {value, next_list} = List.pop_at(list, next_index)

    next_index =
      cond do
        next_index == -1 -> current_len - 2
        next_index >= 0 -> next_index
        true -> next_index + current_len
      end

    {next_list, current_len - 1, next_index, value + next_marble}
  end
  def next_circle(list, current_len, current_index, next_marble) do
    next_index = current_index + 2
    next_index =
      if next_index <= current_len do
        next_index
      else
        next_index - current_len
      end


    {List.insert_at(list, next_index, next_marble), current_len + 1, next_index, 0}
  end
end
