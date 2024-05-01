defmodule PlayWithMeWeb.Router do
  use PlayWithMeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PlayWithMeWeb do
    pipe_through :api

    get "/games", GameController, :index
  end
end
