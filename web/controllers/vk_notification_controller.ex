defmodule QaPage.VkNotificationController do
  use QaPage.Web, :controller

  # @secret System.get_env("VK_PAGE_SECRET")

  def create(conn, %{"type" => "confirmation"}), do: render conn, "confirmation.text"
  def create(conn, _), do: render conn, "ok.text"
end
