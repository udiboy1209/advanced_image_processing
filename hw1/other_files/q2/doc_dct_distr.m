function [] = doc_dct_distr()
    tic;
    doc_1 = imread('data/d5.jpg');
    doc_1 = rgb2gray(doc_1);
    doc_1 = double(doc_1)/255;
    
    doc_2 = imread('data/d6.png');
    doc_2 = double(doc_2);
%     dct_doc_1 = dct2(doc_1);
%     dct_doc_2 = dct2(doc_2);
    
    v = all_patch_variance(doc_1);
    I = 0:100:10000;
    a = 100;
    b = 8000;
    N = 10^7;
    
    %dist = dct_distribution_uniform_var(a,b,N,I);
    %figure;plot(I,dist);
%     figure; stem(abs(dct_doc_1(2:100)));
%     figure; stem(abs(dct_doc_2(2:100)));
    toc;
end
