defmodule QaPage.Poster do
  alias QaPage.Poster.Facebook

  def post(%{"post_type" => "post", "text" => _text}) do
    # Task.async(fn -> Facebook.post(text) end)
  end
end
