defmodule Blog.RegistrationController do
  use Blog.Web, :controller
  alias Blog.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Blog.Registration.create(changeset, Blog.Repo) do
      {:ok, changeset} ->
      conn
      |> put_flash(:info, "Your account was created")
      |> redirect(to: "/")
      #Sing in the user
      {:error, changeset} ->
      conn
      |> put_flash(:info, "Unable to create account")
      |> render("new.html", changeset: changeset)
      #Show error
    end
  end


end