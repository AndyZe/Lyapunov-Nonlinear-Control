function proceed = check_for_stop

global t stop_time


if t < stop_time
    proceed = 1;
else
    proceed = 0;
end