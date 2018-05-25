function guess = GuessAndCheck(f,answer,accuracy)
%f must be a function
%GuessAndCheck will return the best input for f
format long;
guess = 1;
step = 1;
s = zeros(1,2);
s = Calc();
while ~Between(answer,s(1),s(2))
    step = step*2;
    s = Calc();
end
while abs(answer - f(guess))>accuracy
        step = step/2;
    if (abs(answer-s(1))<abs(answer-s(2))) %s(1) is closer

        guess = guess-step;
    else
        guess = guess+step;
    end
    s = Calc();
end

function s = Calc()
s(1) = f(guess-step);
s(2) = f(guess + step);
end
 
end

function outvar = Between(x,a,b)
    if (a<b)
        if x<a || x>b
            outvar = false;
            return;
        else
            outvar = true;
            return;
        end
    else
        if x<b || x>a
            outvar = false;
            return;
        else
            outvar = true;
            return;
        end
    end
end
