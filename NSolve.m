%  Newton-Raphson root finding function 
function G = NSolve(SysEq,G)
  NormErrTol=1e-5;                 % target norm of error
  StepTol=1e-5;                    % target tolerance in solution
  Prcnt=0.001;                     % change to calculate slopes
  MaxI=200;                        % largest number of iterations
  if iscell(G) % select Err function based on G format
    F=@(V)cell2vec(SysEq(vec2cell(V,G))); % F returns column vector
    V=cell2vec(G);                        % make guess a column vector
  else
    F=@(V)[reshape(SysEq(reshape(V,size(G))),length(V),1)];
    V=G(:);
  end

  Err=F(V);                        % error associated with first guess
  MinE=norm(Err);                  % keep track of lowest error
  iter=0;
  while (norm(Err)>NormErrTol && iter<MaxI)
    for i=1:length(V)              % find error slope for guessed values
      pert=V;                      % copy guesses to pert array
      val=V(i);                    % pick ith variable
      del=Prcnt*val;               % calculate small change
      del(find(del==0))=1e-6;      % no zeros here
      pert(i)=val+del;             % make small change to ith variable
      K(:,i)=(F(pert)-Err)/del;    % calculate error slope for ith variable
    end
    if norm(K)==0
      if Prcnt<2                   % change in variable too small
        Prcnt=Prcnt*10;            % try larger change ...
        continue;
      else break; end              % give up
    end
    Step= -K\Err;                  % proposed change to guesses
    Err=F(real(V+Step));           % error after proposed step
    while norm(Err)>MinE           % while error is larger than last ...
      Step=Step/2;                 % reduce step by half 
      Err=F(real(V+Step));
    end
    V=real(V+Step);                % calculate next set of guesses
    MinE=norm(Err);                % new error
    if (max(abs(Step(:)))/max(abs(V(:))) < StepTol) break; end
    iter=iter+1;
  end
  if iscell(G)                     % restore original guess format
    G=vec2cell(V,G);
  else
    G=reshape(V,size(G));
  end
  if (isnan(norm(Err)) || iter==MaxI)
    fprintf('Did not converge after %d iterations!\n',iter);
  end
end

function V = cell2vec(Cell)
  I=length(Cell);
  V=[];
  for i=1:I
    V=[V; Cell{i}(:)];
  end
end

function C = vec2cell(Vec,Cell)
  I=length(Cell);
  C={};
  j=1;
  for i=1:I
    [M N]=size(Cell{i});
    C=[C; reshape(Vec(j:j-1+M*N),M,N)];
    j=j+M*N;
  end
end
