function  dfStr = texError(f, fname, symbols, names, flag)
    % Nigel Bess and Michael Aling, May 2018
    %flag:
    %   ''          symbolic expression for error
    %   'p'   dont evaluate partial derivatives
    %   'e'   actual expression
    
    % fname and names should both be strings. "fname" not 'fname'
    % names should contain a name for each of your symbols
    
    % Note: make your symbol names long (the symbols parameter, not the
    % names parameter).
    % That way when your expression gets turned into latex you avoid
    % problems like:
    %\frac{}{} turns into \f_{\lambda}rac{}{}.
    %(symbol "f" got replaced with "f_{\lambda}")
    
    if nargin == 4
        flag = '';
    end
    global n
    n = length(symbols);
    deriv = cell(1, n);
    
    dfStr = "";
    plusSign = "";
    
    switch flag
        case ''
            
            for i = 1:n
                %symbols(i)
                deriv{i} = diff(f,symbols(i));
                thisStr = gLatex(deriv{i});
                c = char(thisStr);
                if i == 2
                     plusSign = "+";
                end
                if c(1) == '-'
                   thisStr = convertCharsToStrings(c(2:end));
                end
                if (thisStr == "1") || (thisStr == "-1")
                    thisStr = "";
                end
                if thisStr ~= "0"
                    dfStr = dfStr + plusSign + "\Big ( " + thisStr + " \Delta " + names(i)+ "\Big ) ^2";
                end
            end
           replace;
             
        case 'p'
            for i = 1:n
                if i == 2
                    plusSign = "+";
                end
                dfStr = dfStr + plusSign + " \Big ( \frac{\partial " + fname + "}{\partial " + names(i) + "} \Delta " + names(i) + " \Big ) ^ 2 ";
            end
        case ''
            dfStr = gLatex(f);
            repalce;
            
    end
dfStr = "\Delta " + fname + "= \sqrt{" +dfStr + "}";  
clipboard('copy',char(dfStr));

function replace()
            for j = 1:n
                dfStr = strrep(dfStr,nameOf(symbols(j)),names(j));
            end
            dfStr = strrep(dfStr,"\mathrm","");
            dfStr = strrep(dfStr,"\,","");
end

end


