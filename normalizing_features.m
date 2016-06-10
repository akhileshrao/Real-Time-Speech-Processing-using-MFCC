function [features_norm, a, b] = normalizing_features(features, a, b)
[m n]=size(features);
 F=zeros(m,n);
 for j=1:n

     for i=1:m
    
        F(i,j)=(features(i,j)-a(i))/b(i);
    end
end
features_norm=F;
% figure,
% imagesc(F);
%   axis tight;axis xy;
