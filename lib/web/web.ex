defmodule Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Parteibot.Web, :controller
      use Parteibot.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: Web

      import Plug.Conn
      import Web.Gettext
      import Web.Router.Helpers
      alias Web.Router.Helpers, as: Routes
      alias Parteibot.Repo
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/web/templates",
        namespace: Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Web.Gettext
      import Web.ErrorHelpers
      import Web.Router.Helpers
      alias Web.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      use Plug.ErrorHandler
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
