defmodule Spew.InstancePlugin.Console do
  @moduledoc """
  Console plugin allowing IO to be used by external clients

  Keeps some history and provides 
  """

  alias Spew.Discovery

  defmodule State do
    alias __MODULE__

    defstruct history: []

    def append(%State{history: history} = state, line) do
      %{state | history: Enum.slice([line | history], 0, 1000)}
    end

    def reset(%State{} = state, line) do
      %{state | history: []}
    end
  end

  alias __MODULE__.State

  def handle(instance, {:init, _ref}) do
    {:update, %State{}}
  end

  def handle(instance, {:output, _ref, buf}) do
    {:update, State.append(instance.plugin[__MODULE__], buf)}
  end

  def handle(instance, {:input, _ref, buf}) do
    {:update, State.append(instance.plugin[__MODULE__], buf)}
  end

  # keep the console so we can scroll back
  def handle(instance, {:exit, ref, _}), do: :ok

  def handle(instance, _), do: :ok
end