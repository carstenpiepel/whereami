defmodule WhereAmI.States do
  use Tesla

  adapter(Tesla.Adapter.Finch, name: ArcGISFinch)

  plug Tesla.Middleware.BaseUrl, "https://services.arcgis.com"
  plug Tesla.Middleware.EncodeJson
  plug Tesla.Middleware.DecodeJson
  plug Tesla.Middleware.Logger

  def get_state_by_location(%{"x" => x, "y" => y}) do
    {:ok, env} =
      get("/P3ePLMYs2RVChkJx/ArcGIS/rest/services/USA_Boundaries_2022/FeatureServer/1/query",
        query: %{
          f: "json",
          geometryType: "esriGeometryPoint",
          geometry: %{
            x: elem(Float.parse(x), 0),
            y: elem(Float.parse(y), 0)
          },
          returnGeometry: false,
          outFields: "*"
        }
      )

    features = env.body["features"]
    {:ok, get_message(List.first(features))}
  end

  def get_state_by_location(_) do
    {:ok, %{message: "I don't know where you are."}}
  end

  defp get_message(%{"attributes" => %{"STATE_NAME" => state_name}}) do
    %{message: "You are in #{state_name}."}
  end

  defp get_message(_) do
    %{message: "I don't have data for your location."}
  end

  defimpl String.Chars, for: Map do
    def to_string(%{x: x, y: y}) do
      ~s({"x": #{x}, "y": #{y}, "spatialReference": {"wkid": 4326}})
    end
  end
end
