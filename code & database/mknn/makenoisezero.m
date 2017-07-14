function [trainingset1,tclass1]=makenoisezero(minind1,trainingset1,tclass1)

var1=size(minind1);
for i=1:var1(1)
    bool=0;
    for j=1:var1(2)
        for kk=1:var1(2)
            if minind1(minind1(i,j),kk)==i
                bool=1;
                break;
            end
        end
        if bool==1
            break;
        end
    end
    if bool==0
       trainingset1(i,:)=0*trainingset1(i,:);
       tclass1(i,:)=0*tclass1(i,:);
    end
end
end