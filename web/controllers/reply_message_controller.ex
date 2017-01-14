defmodule Parteibot.ReplyMessageController do
  use Parteibot.Web, :controller

  alias Parteibot.ReplyMessage

  def index(conn, _params) do
    reply_messages = Repo.all(ReplyMessage)
    render(conn, "index.html", reply_messages: reply_messages)
  end

  def new(conn, _params) do
    changeset = ReplyMessage.changeset(%ReplyMessage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reply_message" => reply_message_params}) do
    changeset = ReplyMessage.changeset(%ReplyMessage{}, reply_message_params)

    case Repo.insert(changeset) do
      {:ok, _reply_message} ->
        conn
        |> put_flash(:info, "Reply message created successfully.")
        |> redirect(to: reply_message_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reply_message = Repo.get!(ReplyMessage, id)
    render(conn, "show.html", reply_message: reply_message)
  end

  def edit(conn, %{"id" => id}) do
    reply_message = Repo.get!(ReplyMessage, id)
    changeset = ReplyMessage.changeset(reply_message)
    render(conn, "edit.html", reply_message: reply_message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reply_message" => reply_message_params}) do
    reply_message = Repo.get!(ReplyMessage, id)
    changeset = ReplyMessage.changeset(reply_message, reply_message_params)

    case Repo.update(changeset) do
      {:ok, reply_message} ->
        conn
        |> put_flash(:info, "Reply message updated successfully.")
        |> redirect(to: reply_message_path(conn, :show, reply_message))
      {:error, changeset} ->
        render(conn, "edit.html", reply_message: reply_message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reply_message = Repo.get!(ReplyMessage, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(reply_message)

    conn
    |> put_flash(:info, "Reply message deleted successfully.")
    |> redirect(to: reply_message_path(conn, :index))
  end
end
