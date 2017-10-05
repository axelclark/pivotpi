defmodule PivotPi do
  @moduledoc """
  Documentation for PivotPi.
  """

  alias PivotPi.PCA9685

  @doc """
  """
  def angle(channel, angle) do
    pwm_to_send = 4095 - translate(angle)
    PCA9685.set_pwm(channel, 0, pwm_to_send)
  end

  def led(channel, percent) do
    pwm_to_send = round(percent * 40.95)
    PCA9685.set_pwm(channel + 8, 0, pwm_to_send)
  end

  def start() do
    PCA9685.start()
  end

  defp translate(angle_value) do
    value_scaled = angle_value / 180
    round(150 + (value_scaled * 450))
  end
end
