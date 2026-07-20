function pro = crossProduct(weight,H)

     pro = 0;

     [~,m] = size(weight);

     for i = 1:H

         cross = sum(weight(i:m).*weight(1:m-i+1));

         pro = pro + abs(cross);

     end

end