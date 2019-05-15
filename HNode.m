classdef HNode < handle
    
    properties
        val
        weight
        order
        left
        right
        parent
    end
    
    methods
        function obj = HNode(valuep,weightp,orderp,leftp,rightp,parentp)
            if nargin == 1 
                obj(1,valuep) = HNode;                
                
            elseif nargin > 0
                obj.val = valuep;
                obj.weight = weightp;
                obj.order = orderp;
                obj.left = leftp;
                obj.right = rightp;
                obj.parent = parentp;
            else                 
                obj.val = 0 ;
                obj.weight = 0;
                obj.order = 0 ;
                obj.left = NaN ;
                obj.right = NaN;
                obj.parent = NaN ;
            end
        end
        
        function output = haveParent(obj)
            output = isobject(obj.parent);
        end
    end 
end