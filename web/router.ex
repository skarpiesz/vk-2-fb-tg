defmodule QaPage.Router do
  use QaPage.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QaPage do
    pipe_through :api
  end
end
