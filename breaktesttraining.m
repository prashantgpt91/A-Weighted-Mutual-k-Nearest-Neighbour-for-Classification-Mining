function [test1,training1]=breaktesttraining(i,data1)
  training1=data1;
var=size(data1);
gp =((var(1)-i)/10)+1;

gp =floor(gp);
gp;
jj=1;
  test1=zeros(gp,var(2));
  for j=i:10:var(1)
      test1(jj,:)=data1(j,:);
      training1(j,:)=zeros(1,var(2));
      jj=jj+1;
  end
end
      
      
      
