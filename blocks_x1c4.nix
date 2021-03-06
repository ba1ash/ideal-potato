[
  {
    block = "disk_space";
    path = "/";
    alias = "/";
    info_type = "available";
    unit = "GB";
    interval = 60;
    warning = 20.0;
    alert = 10.0;
  }
  {
    block = "net";
    device = "wlp4s0";
    format = "{ssid} {signal_strength} {ip} {speed_up;K*b} {speed_down;K*b}";
    interval = 5;
  }
  {
    block = "memory";
    display_type = "memory";
    format_mem = "{mem_used_percents}";
    format_swap = "{swap_used_percents}";
  }
  {
    block = "cpu";
    interval = 1;
  }
  {
    block = "load";
    interval = 1;
    format = "{1m}";
  }
  { block = "sound"; }
  {
    block = "time";
    interval = 60;
    format = "%a %d/%m %R";
  }
  {
    block = "battery";
    driver = "upower";
    format = "{percentage} {time}";
  }
]
