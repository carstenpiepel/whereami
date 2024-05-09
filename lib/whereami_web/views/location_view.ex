defmodule WhereAmIWeb.LocationView do
  use WhereAmIWeb, :view

  def render("show.json", %{state: state}) do
    IO.inspect(state)
    state
  end
end
