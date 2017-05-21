defmodule QaPage.Poster.Telegram do
  alias QaPage.Http
  alias QaPage.Poster.Format

  @base_url "https://api.telegram.org/bot#{System.get_env("TELEGRAM_BOT_TOKEN")}"
  @message_url "#{@base_url}/sendMessage"
  @photo_url "#{@base_url}/sendPhoto"
  @chat_id System.get_env("TELEGRAM_CHAT_ID")

  def post(%{text: text, link: link, image_url: image_url}) do
    post(%{text: Format.text_with_url(text, link), image_url: image_url})
  end
  def post(%{text: text, video_url: video_url}), do: post(%{text: text, link: video_url})
  def post(%{text: text, image_url: image_url}) do
    case String.length(text) do
      size when size > 200 ->
        post(%{text: text})
      _ ->
        post_to_telegram(@photo_url, %{caption: text, photo: image_url})
    end
  end
  def post(%{text: text, link: link}), do: post(%{link: Format.text_with_url(text, link)})
  def post(%{text: text}),           do: post_to_telegram(@message_url, %{text: text, disable_web_page_preview: true})
  def post(%{image_url: image_url}), do: post_to_telegram(@photo_url, %{photo: image_url})
  def post(%{link: link}),           do: post_to_telegram(@message_url, %{text: link, disable_web_page_preview: false})
  def post(%{video_url: video_url}), do: post(%{link: video_url})
  def post(_) do
  end

  defp post_to_telegram(url, params) do
    Http.post(url, Map.merge(params, %{chat_id: @chat_id, disable_notification: true}))
  end
end
