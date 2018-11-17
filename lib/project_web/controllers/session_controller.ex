defmodule ProjectWeb.SessionController do
    use ProjectWeb, :controller

    def create(conn, %{"email" => email}) do
        user = ProjectWeb.Users.get_user_by_email(email)
        if user do
            conn
            |> put_session(:user_id, user.id)
            |> put_flash(:info, "Welcome back #{user.email}")
            |> redirect(to: Routes.page_path(conn, :index))
        else
            conn
            |> put_flash(:error, "Login failes.")
            |> redirect(to: Routes.page_path(conn, :index))
        end
    end
end