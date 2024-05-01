defmodule PlayWithMe.Library.Game do
  @typedoc """
  Model representing a Game.
  """
  @type t() :: %__MODULE__{id: String.t(), name: String.t()}

  @enforce_keys [:id, :name]
  defstruct [:id, :name]

  use Vex.Struct

  validates(:id, presence: true)
  validates(:name, presence: true)
end
