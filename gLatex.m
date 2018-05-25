function out = gLatex(symbolic)
    % This line gets all the nice /frac, /sqrt, etc.
    out = latex(symbolic); 
    % But this line makes sure any greek letters show up as greek letters.
    out = regexprep(out, '(alpha|beta|gamma|delta|epsilon|zeta|eta|theta|iota|kappa|lambda|mu|nu|xi|omicron|pi|rho|sigma|tau|upsilon|phi|chi|psi|omega)', '\\$1', 'preservecase');
    out = convertCharsToStrings(out);
end