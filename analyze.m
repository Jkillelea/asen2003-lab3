function [results] = analyze(data)
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
  % @RETURNS => results : [[X row by 1 col], [X row by 1 col]] -> [wheel_position(normalized), slide_speed]
  %             where all values of wheel_position are between 0 and 359.999...

  position = data.wheel_position;
  speed    = data.slide_speed;

  i = 1;
  while true % iterate over the positions and ensure that all are between 0 and 359.999...
    if i > size(position, 1) % if hit end of list
      i = 1;                 % restart
    end
    if position(i) >= 360              % if number found is greater than max
      position(i) = position(i) - 360; % reduce
    end
    if max(position) < 360 % if whole list has no values >= 360
      break;               % we're done
    end
    i = i + 1;             % else, next!
  end

  results = sortrows([position, speed]); % return
end
