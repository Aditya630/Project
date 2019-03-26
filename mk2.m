clc; close all; clear all;

% size of image
m=112;
n=92;

% no of sample image per person
N=10;

avg=zeros(m*n,1);
X=[];

count=0;
for j=1:N
    figure(1);
    ff= ['faces/',num2str(j,'%01d'),'.BMP'];
    x= imread(ff);
    imshow(x);
    
    M= double(x);
    
    R=reshape(M,m*n,1);
    X=[X,R];
    
    avg=avg+R;
    count=count+1;
end
for j=1:N
    figure(1);
    ff= ['faces3/',num2str(j,'%01d'),'.BMP'];
    x= imread(ff);
    imshow(x);
    
    M= double(x);
    
    R=reshape(M,m*n,1);
    X=[X,R];
    
    avg=avg+R;
    count=count+1;
end

avg=avg/count;

% average faces
figure(2)
avgF= uint8(reshape(avg,m,n));
imshow(avgF)

%Find features
count=1;
figure(3)
for j=1:2*N
    X(:,j)=X(:,j)-avg;
    R=reshape(X(:,j),m,n);
    imshow(R);
end

%SVD computing
[U,S,V]=svd(X,'econ');

for j=1:20
        subplot(5,4,count)
        imshow(uint8(25000*reshape(U(:,count),m,n)));
        count=count+1;
end

for j=1:N
    imvec=X(:,j);
    Fac1(:,j)=imvec'*U(:,1:3);
end

for j=1:N
    imvec=X(:,j+N);
    Fac2(:,j)=imvec'*U(:,1:3);
end


figure(5)

plot3(Fac1(1,:),Fac1(2,:),Fac1(3,:),'r.','MarkerSize',30)
hold on;
plot3(Fac2(1,:),Fac2(2,:),Fac2(3,:),'b.','MarkerSize',30)
xlabel('PCA 1');
ylabel('PCA 2');
zlabel('PCA 3');
hold off;


% Facebook page to which celebrity u look like most













