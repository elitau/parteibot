defmodule Web.Router do
  use Web, :router
  use Plug.ErrorHandler
  require Ueberauth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/auth", Web do
    pipe_through([:browser])

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
    post("/:provider/callback", AuthController, :callback)
    delete("/logout", AuthController, :delete)
  end

  scope "/", Web do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    resources("/twitter_accounts", TwitterAccountController)
    resources("/hashtags", HashtagController)
    resources("/reply_messages", ReplyMessageController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", Parteibot do
  #   pipe_through :api
  # end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stacktrace}) do
    conn =
      conn
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()

    conn_data = %{
      "request" => %{
        "cookies" => conn.req_cookies,
        "url" => "#{conn.scheme}://#{conn.host}:#{conn.port}#{conn.request_path}",
        "user_ip" => conn.remote_ip |> Tuple.to_list() |> Enum.join("."),
        "headers" => Enum.into(conn.req_headers, %{}),
        "params" => conn.params,
        "method" => conn.method
      },
      "server" => %{
        "pid" => System.get_env("MY_SERVER_PID"),
        "host" => "#{System.get_env("MY_HOSTNAME")}:#{System.get_env("MY_PORT")}",
        "root" => System.get_env("MY_APPLICATION_PATH")
      }
    }

    Rollbax.report(kind, reason, stacktrace, %{}, conn_data)
  end
end
