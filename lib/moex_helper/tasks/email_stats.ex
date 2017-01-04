defmodule MoexHelper.Tasks.EmailStats do
  alias MoexHelper.{Repo, User, Email, Mailer}

  def call do
    users = Repo.stream(User)

    Repo.transaction(fn ->
      Enum.each(users, &deliver/1)
    end, timeout: :timer.minutes(30))
  end

  defp deliver(user) do
    user
    |> Email.Stats.build
    |> Mailer.deliver
  end
end
