defmodule QaPage.VkNotificationController do
  use QaPage.Web, :controller
  alias QaPage.Poster

  @secret System.get_env("VK_PAGE_SECRET")

  def create(conn, %{"type" => "confirmation"}), do: render conn, "confirmation.text"
  def create(conn, %{"object" => post, "secret" => @secret, "type" => "wall_post_new"}) do
    if [latest_post_id: post["id"]] != :ets.lookup(:posts, :latest_post_id) do
      :ets.insert(:posts, {:latest_post_id, post["id"]})
      Task.async(fn -> Poster.post(post) end)
    end
    render conn, "ok.text"
  end
  def create(conn, _), do: render conn, "ok.text"
end
