defmodule MoexHelper.I18n do
  @translations %{
    en: %{
      security: %{
        data: %{
          secname: "Name",
          prevprice: "Last deal price",
          couponvalue: "Coupon value",
          nextcoupon: "Next coupon",
          matdate: "Redemption"
        }
      }
    }
  }

  def t(path) when is_binary(path) do
    path |> String.split(".") |> t
  end

  def t(path) do
    get_in(@translations, path)
  end

  def translations do
    @translations
  end
end
