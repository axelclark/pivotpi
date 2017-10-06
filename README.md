# PivotPi

This application lets you interact with the
[PivotPi](https://www.dexterindustries.com/pivotpi-tutorials-documentation/)
through the
[GrovePi+](https://www.dexterindustries.com/grovepi/). It will automatically
start with your application an initiate a connection to the GrovePi+ board.
Then you must initialize the PivotPi board using `PivotPi.start()`.

Plug your PivotPi into the GrovePI I2C-1 port.  Plug your servo motor into slot 1.

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

## Installation
Add `pivotpi` to your list of dependencies in mix.exs:

```elixir
def deps do
  [{:pivotpi, github: "axelclark/pivotpi"}]
end
```
