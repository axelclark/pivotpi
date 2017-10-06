defmodule PivotPi do
  @moduledoc """
  This application lets you interact with the
  [PivotPi](https://www.dexterindustries.com/pivotpi-tutorials-documentation/)
  through the
  [GrovePi+](https://www.dexterindustries.com/grovepi/). It will automatically
  start with your application an initiate a connection to the GrovePi+ board.
  Then you must initialize the PivotPi board using `PivotPi.start()`.

  ```elixir
  iex> PivotPi.start()
  :ok
  iex> PivotPi.angle(0, 180)
  :ok
  iex> PivotPi.angle(0, 90)
  :ok
  iex> PivotPi.angle(0, 0)
  :ok
  iex> PivotPi.led(0, 100)
  :ok
  iex> PivotPi.led(0, 50)
  :ok
  iex> PivotPi.led(0, 0)
  :ok
  ```
  """

  alias PivotPi.PCA9685

  @doc """
  Move the Servo motor to a new position.  Accepts angle from 0-180.
  """
  def angle(channel, angle) do
    pwm_to_send = 4095 - translate(angle)
    PCA9685.set_pwm(channel, 0, pwm_to_send)
  end

  @doc """
  Control the PivotPi LEDs.  Channel # should match Servo #.  Accepts % from 0-100.
  """
  def led(channel, percent) do
    pwm_to_send = round(percent * 40.95)
    PCA9685.set_pwm(channel + 8, 0, pwm_to_send)
  end

  @doc """
  Initialize the PivotPi board.
  """
  def start() do
    PCA9685.start()
  end

  defp translate(angle_value) do
    value_scaled = angle_value / 180
    round(150 + (value_scaled * 450))
  end
end
