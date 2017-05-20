defmodule QaPage.Poster.Facebook do
  @base_url "https://graph.facebook.com/v2.9/#{System.get_env("FACEBOOK_PAGE_ID")}"
  @feed_url "#{@base_url}/feed"
  @photos_url "#{@base_url}/photos"
  @access_token System.get_env("FACEBOOK_ACCESS_TOKEN")

  def post(%{text: text, link: link, image_url: image_url}) do
    post_to_facebook(@photos_url, %{url: image_url, caption: text_and_url(text, link)})
  end
  def post(%{text: text, video_url: video_url}) do
    post_to_facebook(@feed_url, %{message: text_and_url(text, video_url), link: video_url})
  end
  def post(%{text: text, image_url: image_url}), do: post_to_facebook(@photos_url, %{url: image_url, caption: text})
  def post(%{text: text, link: link}) do
    post_to_facebook(@feed_url, %{message: text_and_url(text, link), link: link})
  end
  def post(%{text: text}),           do: post_to_facebook(@feed_url, %{message: text})
  def post(%{image_url: image_url}), do: post_to_facebook(@photos_url, %{url: image_url})
  def post(%{link: link}),           do: post_to_facebook(@feed_url, %{link: link})
  def post(%{video_url: video_url}), do: post_to_facebook(@feed_url, %{link: video_url})
  def post(_) do
  end

  defp post_to_facebook(url, params) do
    Ivar.new(:post, url)
    |> Ivar.put_body(Map.merge(params, %{access_token: @access_token}), :url_encoded)
    |> Ivar.send
  end

  defp text_and_url(text, url) do
    "#{text}\n\n#{url}"
  end
end
