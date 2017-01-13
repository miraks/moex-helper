defmodule MoexHelper.Ownership do
  use MoexHelper.Web, :model

  schema "ownerships" do
    field :amount, :integer
    field :price, :decimal
    field :comment, :string
    field :position, :integer, default: 0
    belongs_to :account, MoexHelper.Account
    belongs_to :security, MoexHelper.Security
    has_many :coupons, MoexHelper.Coupon

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :price, :comment, :position, :account_id, :security_id])
    |> validate_required([:amount, :price, :position, :account_id, :security_id])
    |> foreign_key_constraint(:account_id)
    |> foreign_key_constraint(:security_id)
  end
end
