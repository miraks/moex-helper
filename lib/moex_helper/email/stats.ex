defmodule MoexHelper.Email.Stats do
  require EEx

  use Timex

  import Swoosh.Email
  import MoexHelper.I18n, only: [t: 1]

  alias Decimal, as: D
  alias MoexHelper.{Ownership, Coupon}

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

  EEx.function_from_file :defp, :body, "lib/moex_helper/templates/email/stats.html.eex",
    [:fields, :ownerships, :coupons]

  def build(user, ownerships, coupons) do
    new \
      from: Application.get_env(:moex_helper, MoexHelper.Mailer)[:from],
      to: user.email,
      subject: subject,
      html_body: body(@fields, ownerships, coupons)
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

  defp format(%Ownership{} = ownership, %{path: [:security, :data, "PREVPRICE"]} = field) do
    diff = (prev_price(ownership) - D.to_float(ownership.price)) |> Float.round(2)
    diff_with_sign = if diff > 0, do: "+#{diff}", else: diff
    "#{get_at(ownership, field.path)} (#{diff_with_sign})"
  end

  defp format(%Ownership{} = ownership, %{path: [:security, :data, "NEXTCOUPON"]} = field) do
    "#{get_at(ownership, field.path)} (#{days_till_coupon(ownership)})"
  end

  defp format(%Ownership{} = ownership, field) do
    get_at(ownership, field.path)
  end

  defp format(%Coupon{} = coupon, :days_past) do
    left = Timex.diff(Timex.today, coupon.date, :days)
    "#{coupon.date} (#{left})"
  end

  defp get_at(ownership, path) do
    Enum.reduce(path, ownership, &Map.get(&2, &1))
  end

  defp days_till_coupon(ownership) do
    ownership.security.data["NEXTCOUPON"] |> Date.from_iso8601! |> Timex.diff(Timex.today, :days)
  end

  defp prev_price(ownership) do
    ownership.security.data["PREVPRICE"]
  end
end
