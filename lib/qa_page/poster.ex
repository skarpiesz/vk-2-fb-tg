defmodule QaPage.Poster do
  alias QaPage.Poster.Facebook
  alias QaPage.Poster.Telegram

  @photo_keys ~w[photo_2560 photo_1280 photo_807 photo_604 photo_130 photo_75]

  def post(%{"post_type" => "post", "text" => text, "attachments" => attachments}) do
    if post?(attachments) do
      params = Map.merge(parse_text(text), parse_attachments(attachments))
      Task.async(fn -> Facebook.post(params) end)
      Task.async(fn -> Telegram.post(params) end)
    end
  end
  def post(%{"post_type" => "post", "text" => text}) do
    parse_text(text)
  end
  def post(_) do
  end

  defp parse_text(text) do
    list = String.split(text, "\n", trim: true)
    link = String.trim(List.last(list) || "") 
    link?(link) && %{text: list |> List.delete_at(-1) |> Enum.join("\n"), link: link} || %{text: String.trim(text)}
  end

  defp link?(string), do: String.match?(string, ~r/\Ahttp.+/ui)

  defp parse_attachments(attachments) do
    case Enum.find(attachments, fn(map) -> map["type"] == "photo" end) do
      nil ->
        %{}
      map ->
        map = map["photo"] || %{}
        %{image_url: map[Enum.find(@photo_keys, fn(key) -> map[key] end)]}
    end
  end

  defp post?(attachments), do: !Enum.any?(attachments || [], fn(map) -> map["type"] == "poll" end)
end
