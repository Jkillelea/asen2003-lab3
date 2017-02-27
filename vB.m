function v = vB(omega, theta)
  % find the model's velocity as a function of omega and theta
  % @PARAMS => omega : angular rotation of wheel, in degress per second
  %            theta : angular position of the wheel, in degrees
  % @RETURNS => v : collar speed, in meters per second

  r = 7.7   ; % cm                                * (10^-2); % m
  d = 15.3  ; % cm                                * (10^-2); % m
  l = 25.4; % cm                                * (10^-2); % m

  beta = acosd(sqrt(l^2 - (d - r.*sind(theta)).^2) ...
                          ./                       ...
                          l                        ...
  );

  % convert omega from degrees per second to radians per second
  omega = omega .* (pi/180);

  v = -1*(omega.*r.*sind(theta) + omega.*r.*cosd(theta).*tand(beta)); % times -1 so it's in phase
end
