defmodule MoexHelper.I18n do
  @translations %{
    en: %{
      security: %{
        columns: %{
          SECNAME: "Name",
          PREVPRICE: "Last deal price",
          MARKETPRICE: "Market price",
          COUPONVALUE: "Coupon value",
          NEXTCOUPON: "Next coupon",
          MATDATE: "Redemption"
        }
      }
    }
  }

  def t(path) do
    get_in(@translations, path)
  end

  def translations do
    @translations
  end
end
