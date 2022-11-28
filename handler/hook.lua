local hook = {};
function hook:hookfunction(hookfunc, replacementfunc)
    local hooky
    hooky = hookfunction(hookfunc, function(Self, ...)
        return hooky(replacementfunc(Self, ...))
    end)
end
return hook;
