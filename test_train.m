
function [accuracy,time]=test_train(C,test_data,U,c1,mu,epsilon)

 [no_input,no_col]=size(C); 

 [no_input,no_col]=size(C);
  obs = C(:,no_col);    
  A = [];
 B = [];

for i = 1:no_input
    if(obs(i) == 1)
        A = [A;C(i,1:no_col-1)];
    else
        B = [B;C(i,1:no_col-1)];
    end
end
tic
U=fuzzyu(C,U);
mem=U(:,no_col);
U=U(:,1:no_col-1);
timeu=toc;
c2=c1;
c3=c1;
      
    
    ep = 0.0001;

    [m3,n] = size(U);
     e3 = ones(m3,1);
     
     [m1,n] = size(A);    
    e1 = ones(m1,1); 
    [m2,n] = size(B);
     e2 = ones(m2,1);
     m= m1 + m2;
    C = [A ; B];   
     
     K=zeros(m1,m);
   
    for i=1:m1
        for j=1:m
            nom = norm( A(i,:)  - C(j,:)  );
            K(i,j) = exp( -1/(2*mu*mu) * nom * nom );
        end
    end
       
     H = [K e1];
         
    
     K=zeros(m2,m);
    for i=1:m2
        for j=1:m
            nom = norm( B(i,:)  - C(j,:)  );
            K(i,j) = exp( -1/(2*mu*mu) * nom * nom );
        end
    end

    G = [K e2];
    
    K=zeros(m3,m);
    for i=1:m3
        for j=1:m
            nom = norm( U(i,:)  - C(j,:)  );
            K(i,j) = exp( -1/(2*mu*mu) * nom * nom );
        end
    end

    O = [K e3];
    
    

    em1 = m+1;

    
    lowb1=zeros(m2+m3,1);
    lowb2=zeros(m1+m3,1);
    upb1 = [c1*e2;c3*mem];
    upb2 = [c2*e1;c3*mem];
      tic

    HTH = H' * H;
    invHTH = inv(HTH + ep * speye(em1) );
    GO=[G;-O];
    GOINVGOT = GO * invHTH * GO';
    
    GTG = G' * G;
    invGTG = inv (GTG + ep * speye(em1));
    HO=[H;O];
    HOINVHOT = HO * invGTG * HO';

       f1 = -[e2;(epsilon-1)*e3]';
       f2 = -[e1;(epsilon-1)*e3]';
    
    u1 = quadprog(GOINVGOT,f1,[],[],[],[],lowb1,upb1);
    u2 = quadprog(HOINVHOT,f2,[],[],[],[],lowb2,upb2);
    time= toc+timeu;
    w1 = - invHTH * (G' *u1(1:m2)- O'*u1(m2+1:m2+m3));
    w2 =  invGTG * (H' *u2(1:m1)+ O'*u2(m1+1:m1+m3));
    
    [no_test,no_col] = size(test_data);   
    ktest = zeros( no_test, no_input ); 
     for i=1:no_test
        for j=1:no_input
            nom = norm( test_data(i,1:no_col-1)  - C(j,:)  );
            Ker_row(i,j) = exp( -1/(2*mu*mu) * nom * nom );
            
        end
     end
     K = [Ker_row ones(no_test,1)];
     size(K);
     y1 = K * w1 / norm(w1(1:size(w1,1)-1,:));
     y2 = K * w2 / norm(w2(1:size(w2,1)-1,:));
     
    for i = 1 : no_test
    if abs(y1(i)) < abs(y2(i))
        classifier(i) = 1;
    else
        classifier(i) = -1;
    end;
end;

match = 0.;
classifier = classifier';
obs1 = test_data(:,no_col);


for i = 1:no_test
    if(classifier(i) == obs1(i))
        match = match+1;
    end;
end;  
accuracy=match/size(obs1,1)*100
    