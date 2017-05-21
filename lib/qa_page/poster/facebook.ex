defmodule QaPage.Poster.Facebook do
  alias QaPage.Http
  alias QaPage.Poster.Format

  @base_url "https://graph.facebook.com/v2.9/#{System.get_env("FACEBOOK_PAGE_ID")}"
  @feed_url "#{@base_url}/feed"
  @photos_url "#{@base_url}/photos"
  @access_token System.get_env("FACEBOOK_ACCESS_TOKEN")

  def post(%{text: text, link: link, image_url: image_url}) do
    post_to_facebook(@photos_url, %{url: image_url, caption: Format.text_with_url(text, link)})
  end
  def post(%{link: link, image_url: image_url}), do: post(%{text: link, image_url: image_url})
  def post(%{text: text, image_url: image_url}), do: post_to_facebook(@photos_url, %{url: image_url, caption: text})
  def post(%{text: text, link: link}) do
    post_to_facebook(@feed_url, %{message: Format.text_with_url(text, link), link: link})
  end
  def post(%{text: text}),           do: post_to_facebook(@feed_url, %{message: text})
  def post(%{image_url: image_url}), do: post_to_facebook(@photos_url, %{url: image_url})
  def post(%{link: link}),           do: post_to_facebook(@feed_url, %{link: link})
  def post(_) do
  end

  defp post_to_facebook(url, params) do
    Http.post(url, Map.merge(params, %{access_token: @access_token}))
  end
end
