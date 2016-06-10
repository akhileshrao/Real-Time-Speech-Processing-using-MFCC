function [melval] = hertz2mel(hzval)
    melval = 1127.01028*log(1+hzval/700);
end

