defmodule F1GameTelemetry do
  def register(pid) do
    F1GameTelemetry.Listener.register(pid)
  end
end
