defmodule MoexHelper.Tasks.EmailStats do
  import Ecto
  import Ecto.Query

  alias Decimal, as: D
  alias MoexHelper.{Repo, User, Coupon, Email, Mailer}

  def call do
    users = Repo.stream(User)

    Repo.transaction(fn ->
      Enum.each(users, fn user ->
        ownerships = user |> load_ownerships |> group_ownerships
        coupons = find_coupons(user)
        user |> Email.Stats.build(ownerships, coupons) |> Mailer.deliver
      end)
    end, timeout: :timer.minutes(30))
  end

  defp load_ownerships(user) do
    user |> assoc(:ownerships) |> preload([:account, :security]) |> order_by(asc: :position) |> Repo.all
  end

  defp group_ownerships(ownerships) do
    ownerships
    |> Enum.chunk_by(fn %{account: account, security: security} -> {account, security} end)
    |> Enum.map(fn ownerships ->
      ownerships
      |> Enum.reduce(fn ownership, result ->
        amount = result.amount + ownership.amount
        price = D.div(
          D.add(
            D.mult(D.new(result.amount), result.price),
            D.mult(D.new(ownership.amount), ownership.price)),
          D.new(amount))
        %{result | amount: amount, price: price}
      end)
      |> Map.update!(:price, &D.round(&1, 2))
    end)
  end

  defp find_coupons(user) do
    query = from c in Coupon,
      inner_join: o in assoc(c, :ownership),
      inner_join: a in assoc(o, :account),
      inner_join: u in assoc(a, :user),
      where: u.id == ^user.id and not c.collected and c.date <= ^Date.utc_today,
      order_by: c.date

    Repo.all(query)
  end
end
