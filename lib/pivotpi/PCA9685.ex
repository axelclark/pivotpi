defmodule PivotPi.PCA9685 do
  @moduledoc false

  # registers/etc:
  @pca9685_address     0x40
  @mode1               0x00
  @mode2               0x01
  # @subadr1             0x02 # Unused
  # @subadr2             0x03 # Unused
  # @subadr3             0x04 # Unused
  # @prescale            0xfe # Unused
  @led0_on_l           0x06
  @led0_on_h           0x07
  @led0_off_l          0x08
  @led0_off_h          0x09
  @all_led_on_l        0xfa
  @all_led_on_h        0xfb
  @all_led_off_l       0xfc
  @all_led_off_h       0xfd

  # bits:
  # @restart             0x80 # Unused
  @sleep               0x10
  @allcall             0x01
  @invrt               0x10
  @outdrv              0x04

  alias GrovePi.{Board}
  import Bitwise

  def start() do
    set_all_pwm(0, 0)
    send_cmd(<<@mode2, (@outdrv ||| @invrt)>>) # Totem pole drive, and inverted signal.
    send_cmd(<<@mode1, @allcall>>)
    Process.sleep(50)
    wake = 0xFF &&& ~~~@sleep
    send_cmd(<<@mode1, wake>>)
    Process.sleep(50)
  end

  def set_pwm(channel, on, off) do
    send_cmd(<<@led0_on_l+4*channel, on &&& 0xFF>>)
    send_cmd(<<@led0_on_h+4*channel, on >>> 8>>)
    send_cmd(<<@led0_off_l+4*channel, off &&& 0xFF>>)
    send_cmd(<<@led0_off_h+4*channel, off >>> 8>>)
  end

  def set_all_pwm(on, off) do
    send_cmd(<<@all_led_on_l, on &&& 0xFF>>)
    send_cmd(<<@all_led_on_h, on >>> 8>>)
    send_cmd(<<@all_led_off_l, off &&& 0xFF>>)
    send_cmd(<<@all_led_off_h, off >>> 8>>)
  end

  def send_cmd(command) do
    Board.i2c_write_device(@pca9685_address, command)
  end
end
