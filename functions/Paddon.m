function [b, nadd] = Paddon( a )

%  padds a matrix with extra data so that endpoint problems with Butterwort filter
%  are circumvented
%  [ b, nadd] = paddon( a)
%
%  John H. Challis, The Penn. State University
%  April 26, 1997
%
%  input
%  -----
%  a    - matrix to have padding added to
%  output
%  ------
%  b    - padded matrix
%  working
%  -------
%  nadd - how many padded values should be added
%

%  find size of input matrix
%
n = size(a, 1);

%  determine size of padding
%
%if n > 20
  nadd = round(n * 0.3);
%else
%  nadd = 3;
%end

%  start of data set
%
b(nadd, :) = a(1, :) - (a(2, :) - a(1, :)); 
for i = 1:(nadd-1)
    adiff = a(i+1, :) - a(i, :);
    b(nadd-i, :) = b(nadd-i+1, :) - adiff;
end

%  middle of data set
%
b(nadd+1:nadd+n, :) = a(1:n, :);

%  end of data set
%
b(n+nadd+1, :) = a(n, :) + (a(n, :) - a(n-1, :)); 
for i = 1:(nadd-1)
    adiff = a(n-i, :) - a(n-i-1, :); 
    b(n+nadd+i+1, :) = b(n+nadd+i, :) + adiff;
end

end
%%% the end %%%
