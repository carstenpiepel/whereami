defmodule WhereAmIWeb.LocationController do
  use WhereAmIWeb, :controller

  alias WhereAmI.States

  def show(conn, point) do
    {:ok, state} = States.get_state_by_location(point)
    render(conn, "show.json", state: state)
  end
end
