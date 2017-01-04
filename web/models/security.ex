defmodule MoexHelper.Security do
  use MoexHelper.Web, :model

  schema "securities" do
    field :isin, :string
    field :data, :map, default: %{}
    belongs_to :board, MoexHelper.Board
    has_many :ownerships, MoexHelper.Ownership

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:isin, :data, :board_id])
    |> validate_required([:isin, :data, :board_id])
    |> foreign_key_constraint(:board_id)
    |> unique_constraint(:isin, name: :securities_board_id_isin_index)
  end
end
