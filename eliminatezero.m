function trainingdata2=eliminatezero(trainingdata1)
var=size(trainingdata1);
i=1;
c=0;
for i2=1:var(1)
    bool=0;
    for j2=1:var(2)
        if trainingdata1(i2,j2)~=0
            bool=1;
            break;
        end
    end
        if bool==0
            c=c+1;
        end        
end

jj=1;
trainingdata2=zeros(var(1)-c,var(2));
for i2=1:var(1)
    bool=0;
    for j2=1:var(2)
        if trainingdata1(i2,j2)~=0
            bool=1;
            break;
        end
    end
        if bool==1
            trainingdata2(jj,:)=trainingdata1(i2,:);
            jj=jj+1;
        end        
end