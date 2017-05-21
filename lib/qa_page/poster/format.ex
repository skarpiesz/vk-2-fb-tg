defmodule QaPage.Poster.Format do
  def text_with_url(text, url) do
    "#{text}\n\n#{url}"
  end
end
