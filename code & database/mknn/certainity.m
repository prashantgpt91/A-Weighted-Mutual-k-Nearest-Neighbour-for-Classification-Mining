function cert=certainity(fresult,resultofknn,mindist1,noofclass,k)
var=size(resultofknn);
cert=0;
c=0;
for j=1:var(1)
    final=zeros(1,noofclass);
    sum=0;
for i=1:k
    if resultofknn(j,i)~=0
        if mindist1(j,i)==0
            mindist1(j,i)=0.1;
        end
    final(1,resultofknn(j,i))=final(1,resultofknn(j,i))+(1/mindist1(j,i));
    end
end
for i=1:noofclass
    sum=sum+final(1,i);
end
if fresult(j,:)~=0
c=c+1;
cert=cert+(final(1,fresult(j,:))/sum)*100;
end
end
c;
cert=cert/c;
end