defmodule QaPage.Http do
  def post(url, params) do
    Ivar.new(:post, url) |> Ivar.put_body(params, :url_encoded) |> Ivar.send
  end
end
