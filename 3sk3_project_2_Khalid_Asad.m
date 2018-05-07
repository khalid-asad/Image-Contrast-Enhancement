clc;
clear;

In = imread('input.bmp'); % car image
%In = imread('brain.PNG'); % brain image
In = In(:,:,1);
pixels = length(In(:)); % amount of pixels in the matrix
H = imhist(In); % find histogram values of the image

P = zeros(256,1);
for i = 0:255 % divide each histogram value by the amount of pixels
    P(i+1)= double(H(i+1)/pixels);
end

% linprog(f,A,b,Aeq,beq,lb,ub) - find minimum between a certain range
C = linprog(P.*(-1), ones(1,256), 255,[],[], zeros(256,1), 3.*ones(256,1));

S = zeros(pixels,1);
for i = 0:(pixels-1) % sum min values in each pixel and save into a variable
    S(i+1) = sum(C(1:In(i+1)));
end

Out = reshape(S,size(In)); % returns Out(elements taken column-wise from S)
Out = uint8(Out); % convert to an image matrix

figure();
imhist(In);
title('Input Image Histogram');
figure();
imshow(In);
title('Input Image');
figure();
imhist(Out);
title('Output Image Histogram');
figure();
imshow(Out);
title('Output Image');