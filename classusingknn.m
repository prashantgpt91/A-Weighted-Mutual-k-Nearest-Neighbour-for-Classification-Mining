function [finalclass]=classusingknn(resultofknn1,mindist1,k,noofclass1)
var=size(resultofknn1);
final=zeros(var(1),noofclass1);
for j=1:var(1)
for i=1:k
    if resultofknn1(j,i)~=0
    final(j,resultofknn1(j,i))=final(j,resultofknn1(j,i))+(1/mindist1(j,i));
    end
end
end
max=0;
final;
finalclass=zeros(var(1),1);
for j=1:var(1)
    mc=0;
for i=1:noofclass1
    if final(j,i)>max
        max=final(j,i);
        mc=i;
    end
end
max=0;
finalclass(j,1)=mc;
end
end