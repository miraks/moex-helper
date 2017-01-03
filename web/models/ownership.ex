defmodule MoexHelper.Ownership do
  use MoexHelper.Web, :model

  schema "ownerships" do
    field :amount, :integer
    field :price, :decimal
    field :comment, :string
    belongs_to :account, MoexHelper.Account
    belongs_to :security, MoexHelper.Security

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :price, :account_id, :security_id])
    |> validate_required([:amount, :price, :account_id, :security_id])
    |> foreign_key_constraint(:account_id)
    |> foreign_key_constraint(:security_id)
  end
end
