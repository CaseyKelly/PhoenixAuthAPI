defmodule MyApp.Router do
  use MyApp.Web, :router
  use Passport

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyApp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/forget-password", PasswordController, :forget_password
    post "/reset-password", PasswordController, :reset_password
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyApp do
  #   pipe_through :api
  # end
end
