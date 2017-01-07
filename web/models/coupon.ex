defmodule MoexHelper.Coupon do
  use MoexHelper.Web, :model

  schema "coupons" do
    field :date, :date
    field :collected, :boolean, default: false
    belongs_to :ownership, MoexHelper.Ownership

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:date, :collected, :ownership_id])
    |> validate_required([:date, :collected, :ownership_id])
    |> foreign_key_constraint(:ownership_id)
    |> unique_constraint(:date, name: :markets_ownership_id_date_index)
  end
end
