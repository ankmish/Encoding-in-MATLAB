function [code1, average_length] = binaryHuffman(p)
set(0,'RecursionLimit',1e4);  % set recursion limit .. 
% p - probability vector 
% code1 - corresponding codewords 

if ((sum(p>=0)~=length(p)))
    error('Enter a probability vector');
end

p = p/sum(p);
if(length(p)>2)
    [pdes,idx] = sort(p,'descend');
    q1 = pdes(1:(length(pdes)-1));
    q1(length(pdes)-1) = pdes(length(pdes)-1)+pdes(length(pdes));
    old_code = binaryHuffman(q1);
    new_code = [old_code(1:(length(old_code)-1)) strcat(old_code{length(old_code)},'0') strcat(old_code{length(old_code)},'1')];
    code1(idx) = new_code;
    
elseif(length(p)==2)
    code1 = {'0', '1'};
else
    error('No coding needed');
end
l1 = cellfun(@length, code1);
average_length = sum(l1.*p);
end