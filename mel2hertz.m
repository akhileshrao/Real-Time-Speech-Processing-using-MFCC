function [hzval] = mel2hertz(melval)
    hzval = 700*(exp(melval/1127.01028)-1);
end

