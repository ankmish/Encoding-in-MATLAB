function [code1, average_length] = ShannonFano(p1)
set(0,'RecursionLimit',1e4);       
% p1 - probability vector 
% code1 - corresponds codewords
%average_length is the expected codeword length 
% check if p1 is row vector or column vector

if ((sum(p1>=0)~=length(p1)))
    error('Enter a probability vector');
end
p1 = p1/sum(p1);

if(length(p1)>2)
    
    [pdes,idx] = sort(p1,'descend'); % sort in descending order and maintain previous index .. to access simply p1(idx);
     qsum = (2*cumsum(pdes))-1; %cumulative sum of A starting at the beginning of the first array dimension in A whose size does not equal 1.
    [~,idx1] = min(abs(qsum)); % find min. value and discard it ... keep its index as we need index only
    if((idx1>1)&&(idx1<length(pdes)-1))
        q1 = pdes(1:idx1);                 %break into left half
        q2 = pdes((idx1+1):length(pdes)); % right half
        
        
        old_code1 = ShannonFano(q1);       % recursive call left
        old_code2 = ShannonFano(q2);       % recursive call right
        new_code = [strcat('0',old_code1) strcat('1',old_code2)];  % assign code 0 to left and 1 to right
       % disp(new_code);
    elseif(idx1==1)
        q1 = pdes(1);
        q2 = pdes(2:length(pdes));
        old_code1 = ShannonFano(q1);
        old_code2 = ShannonFano(q2);
        new_code = [old_code1  strcat('1',old_code2)];
    else
        q1 = pdes(1:((length(pdes)-1)));
        q2 = pdes(length(pdes));
        old_code1 = ShannonFano(q1);
        old_code2 = ShannonFano(q2);
        new_code = [strcat('1',old_code1)  old_code2];
    end
   % disp(idx);
    code1(idx) = new_code;
    
elseif(length(p1)==2)
    code1 = {'0', '1'};
else
    code1 = {'0'};
end
length1 = cellfun(@length, code1);
average_length = sum(length1.*p1);
end

