
%To find 
n=10;%10 reservations
m=10;%10 tables
reservations=poissrnd(5,n,1)%possion random numbers with avarage 5 (simulation number won't have the same number)
tables=poissrnd(4,m,1)%possion random numbers with avarage 5

fit=zeros(n,m);%create a fit matrix with n rows, m columns

for i=1:n %for every reseravation
    for j=1:m%for every table
        if reservations(i,1)<=tables(j,1)
            fit(i,j)=1;
        end
    end
end 
fit %print in command window the value of fit matrix

W=[0,ones(1,m),zeros(1,n+1);
           zeros(m,m+1),fit,zeros(m,1);
           zeros(n,m+n+1),ones(n,1);
           zeros(1,m+n+2)];

%solve the max flow problem
[M,F] = graphmaxflow(sparse(W),1,m+n+2)


%F is a sparse matrix
%lets make F a full matrix
F = full(F);

%matrix F contains a lot of information that we do not need
%lets focus on the useful part of F
%F = F(2:1001,1002:1005)

F = F(2:m+1,m+2:m+n+1);
F=round(F) %remove uncesessary decimals
%now F represents the optimal 
%assignment of maximum flow 
%(i.e., the max number of students
%assigned to preferred dorm

%it is a matrix of zeros and ones
%ones correspond to assignments
%of students to dorms

%lets identify which students are not
%assigned to a preferred dorm
not_seated = find (sum(F,2)~= 1)%number/lable of tables not accomodated
%when you make comparisons (as opposed to assigmments)
%you use == (as opposed to =)
