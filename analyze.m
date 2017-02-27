function data = analyze(data)
  % Process the data given from the files
  % @PARAMS => data : struct, defined by:
  % data = struct('times',                 [], ...
  %               'wheel_position',        [], ...
  %               'slide_position',        [], ...
  %               'wheel_speed',           [], ...
  %               'slide_speed',           [], ...
  %               'actual_sample_time_ms', [], ...
  %               'filename', filepath         ...
  % );
  % @RETURNS => data : the same struct with the additional fields of:
  %   pos   : angular position of wheel (degrees), starting at zero
  %   speed : speed of the collar in m/s

  position = data.wheel_position;
  speed    = data.slide_speed;

  num_cycles = floor(position(1) / 360); % determine how many cycles of offset we start with
  position   = position - 360 * num_cycles; % subtract that so we start at zero


  results    = sortrows([position, speed]); % return
  data.pos   = results(:, 1);
  data.speed = results(:, 2) / 10; % cm/s from mm/s

  % truncate all the data to between 0 and 6 revolutions
  max_index = find(position > 6*360);
  max_index = max_index(1);
  data.times                 = data.times(1:max_index);
  data.wheel_position        = data.wheel_position(1:max_index);
  data.wheel_speed           = data.wheel_speed(1:max_index);
  data.slide_position        = data.slide_position(1:max_index);
  data.actual_sample_time_ms = data.actual_sample_time_ms(1:max_index);
  data.pos                   = data.pos(1:max_index);
  data.speed                 = data.speed(1:max_index);

end
