function AdaptiveHuffman(varargin)

if(nargin==0)
    x = 24 ;
else 
    x = varargin{1};
    str = varargin{2};
end

maxorder = 2*x + 1 ;
list = HNode(maxorder);
map = containers.Map();
listTop = maxorder ;

NYT = HNode('NYT',0,maxorder,NaN,NaN,NaN);
root =  NYT ;
list(listTop) = root ;
listTop = listTop - 1 ;


out = '';
for n=1:length(str)
    tempout = '';    
    if isKey(map,str(n))  
        temp = map(str(n));
        while temp.haveParent()
            if temp.parent.left == temp 
                tempout = strcat(tempout,'0');
            else 
                tempout = strcat(tempout,'1');
            end
            temp = temp.parent ;
        end
        tempout = flip(tempout);
        disp(tempout);
    else
        temp = NYT ;
        while temp.haveParent()
            if temp.parent.left == temp
                tempout = strcat(tempout,'0');
            else 
                tempout = strcat(tempout,'1');
            end
            temp = temp.parent ;
        end
        tempout = flip(tempout);
        disp(tempout);
        disp(str(n));
    end
       
    
    t = '' ;
    if ~isKey(map,str(n))
        temp = NYT ;
        retVal = HNode(str(n),1,NYT.order-1,nan,nan,temp);
        list(listTop) = retVal;
        listTop = listTop - 1;
        NYT = HNode('NYT',0,NYT.order-2,nan,nan,temp);
        list(listTop) = NYT;
        listTop = listTop - 1;
        temp.left = NYT ;
        temp.right = retVal ;
        temp.weight = temp.weight +1 ;
        temp.val = nan ;
        map(str(n)) = retVal ;
        if ~(map(str(n)).parent.haveParent()) 
            continue ;
        end
        t = map(str(n)).parent.parent ;
        
    else 
        t = map(str(n));
    end
    
    
    while t.haveParent()   
        temp = t ;
        
        i = t.order + 1 ;
        while (list(i).weight == t.weight) && i<maxorder
            i = i+1 ;
        end
        
        i = i-1 ;
        
        if (list(i).order > temp.order) && (list(i) ~= t.parent)
            temp = list(i); 
            
            temp2 = list(temp.order);
            list(temp.order) = list(t.order);
            list(t.order) = temp2 ;
            
            if t.parent.left == t 
                t.parent.left = temp ;
                if temp.parent.right == temp
                    temp.parent.right = t ;
                else
                    temp.parent.left = t ;
                end
            else 
                t.parent.right = temp ;
                if temp.parent.left == temp
                    temp.parent.left = t ;
                else
                    temp.parent.right = t ;
                end
            end
            

            
            temp2 = temp.parent ;
            temp.parent = t.parent ;
            t.parent = temp2 ;
            order = t.order ;
            t.order = temp.order ;
            temp.order = order ;
        end
        t.weight  = t.weight + 1 ;
        t = t.parent ;
    end
    t.weight = t.weight+ 1 ;

end
end
        
        
            
        
        
    
        



    



