defmodule QaPage.VkNotificationView do
  use QaPage.Web, :view

  @confirmation System.get_env("VK_PAGE_CONFIRMATION")

  def render("confirmation.text", _) do
    @confirmation
  end

  def render("ok.text", _) do
    "ok"
  end
end
