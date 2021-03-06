defmodule MoexHelper.ModelCase do
  @moduledoc """
  This module defines the test case to be used by
  model tests.

  You may define functions here to be used as helpers in
  your model tests. See `errors_on/2`'s definition as reference.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias MoexHelper.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import MoexHelper.ModelCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MoexHelper.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MoexHelper.Repo, {:shared, self})
    end

    :ok
  end
end
