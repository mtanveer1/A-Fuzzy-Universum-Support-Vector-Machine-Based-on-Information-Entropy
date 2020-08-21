
function [finA]=fuzzyu(A,U)
[mu,nu] = size(U); 
[m,n] = size(A);
distance=zeros(mu,m);
for i=1:mu
    for j=1:m
        diff = U(i,1:n-1) - A(j,1:n-1);
        distance(i,j) = sqrt(diff * diff');
    end
end
nn=5;
[val ind]=sort(distance,2);
knn=ind(:,2:nn+1);
knn=knn';
knnlabel=A(knn,n);
j=1;
for i=1:mu
        indpos=find(knnlabel(j:j+nn-1)==1);
        [npos temp]=size(indpos);
        indneg=find(knnlabel(j:j+nn-1)==-1);
        [nneg temp]=size(indneg);
        ppos(i)=npos/nn;
        pneg(i)=nneg/nn;
        j=j+nn;
end
logpos=zeros(1,mu);
logneg=zeros(1,mu);
for i=1:mu
        if(ppos(i)~=0)
            logpos(i)=log(ppos(i));
        end
        if(pneg(i)~=0)
            logneg(i)=log(pneg(i));
        end
        
end
H=-ppos.*logpos-pneg.*logneg;

 finA=zeros(mu,n);


[Hval ind]=sort(H);

numsubset=10;
ele=ceil(mu/numsubset);

beta=0.05;
Hmin=min(Hval);
Hmax=max(Hval);
[x y]=size(U);

subset=zeros(mu,n,numsubset);
l=1;
for k=numsubset:-1:1
    up=Hmin+(l/numsubset)*(Hmax-Hmin);
    low=Hmin+((l-1)/numsubset)*(Hmax-Hmin);
  
     memval=1-beta*(k-1);
    for i=1:x
        if ((H(i)>=low) && (H(i)<up));
           subset(i,:,l)=[U(i,:) memval];
           
        end
        if(l==numsubset)
            if (H(i)==up)
           subset(i,:,l)=[U(i,:) memval];
            end
        end
    end 
    l=l+1;
end
tt=sum(subset,3);

finA=tt;
end
