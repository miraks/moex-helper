defmodule MoexHelper.Email.Stats do
  require EEx

  use Timex

  import Swoosh.Email
  import Ecto
  import Ecto.Query
  import MoexHelper.I18n, only: [t: 1]

  alias MoexHelper.Repo

  @fields [
    %{name: "Account", path: [:account, :name]},
    %{name: "Code", path: [:security, :code]},
    %{name: t("en.security.data.secname"), path: [:security, :data, "SECNAME"]},
    %{name: "Amount", path: [:amount]},
    %{name: "Original price", path: [:price]},
    %{name: t("en.security.data.prevprice"), path: [:security, :data, "PREVPRICE"]},
    %{name: t("en.security.data.couponvalue"), path: [:security, :data, "COUPONVALUE"]},
    %{name: t("en.security.data.nextcoupon"), path: [:security, :data, "NEXTCOUPON"]},
    %{name: t("en.security.data.matdate"), path: [:security, :data, "MATDATE"]}
  ]

  EEx.function_from_file :defp, :body, "lib/moex_helper/templates/email/stats.html.eex", [:fields, :ownerships]

  def build(user) do
    ownerships = user |> assoc(:ownerships) |> preload([:account, :security]) |> order_by(asc: :position) |> Repo.all

    new \
      from: Application.get_env(:moex_helper, MoexHelper.Mailer)[:from],
      to: user.email,
      subject: subject,
      html_body: body(@fields, ownerships)
  end

  defp subject do
    "MOEX stats - #{Timex.today}"
  end

  defp row_color(ownership) do
    left = days_till_coupon(ownership)
    cond do
      left in 0..2 -> "red"
      left in 3..5 -> "orange"
      true -> "black"
    end
  end

  defp format(ownership, %{path: [:security, :data, "PREVPRICE"]} = field) do
    diff = (prev_price(ownership) - Decimal.to_float(ownership.price)) |> Float.round(2)
    diff_with_sign = if diff > 0, do: "+#{diff}", else: diff
    "#{get_at(ownership, field.path)} (#{diff_with_sign})"
  end

  defp format(ownership, %{path: [:security, :data, "NEXTCOUPON"]} = field) do
    "#{get_at(ownership, field.path)} (#{days_till_coupon(ownership)})"
  end

  defp format(ownership, field) do
    get_at(ownership, field.path)
  end

  defp get_at(ownership, path) do
    Enum.reduce(path, ownership, &Map.get(&2, &1))
  end

  defp days_till_coupon(ownership) do
    ownership |> next_coupon |> Timex.diff(Timex.today, :days)
  end

  defp prev_price(ownership) do
    ownership.security.data["PREVPRICE"]
  end

  defp next_coupon(ownership) do
    ownership.security.data["NEXTCOUPON"] |> Date.from_iso8601!
  end
end
