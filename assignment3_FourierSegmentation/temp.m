function [E1, E2] =  myHarrisCornerDetector(image, sigma)
%Harris corner detection algorithm
%   sigma = gaussian weights used in the averaging of the
%   gradient-outer-product matrices;

% Sobel operator for derivative
Sx = [-1, 0, 1 ; -2, 0, 2; -1, 0, 1]; 
Sy = Sx';

Ix = conv2(image, Sx, 'same'); % X-gradient
Iy = conv2(image, Sy, 'same'); % Y-gradient

% Display the derivative images
figure('Name', 'Derivative along X-axis'), imshow(Ix, [0 1]), colorbar, truesize;
figure('Name', 'Derivative along Y-axis'), imshow(Iy, [0 1]), colorbar, truesize;

Ix2 = Ix.*Ix; % Square of X-gradient
Iy2 = Iy.*Iy; % Square of Y-gradient
IxIy = Ix.*Iy; % X-gradient * Y-gradient

h = 11; % Maximum window size (fixed)
c = (h+1)/2; % Center of the window

W = fspecial('gaussian', h, sigma); % Gaussian weights for averaging
sz = size(image); % Size of original image

% For storing the two eigenvalues of structure tensor
E1 = zeros(sz);
E2 = zeros(sz);

% Harris corner-ness measure
C = zeros(sz);
k = 0.2; % Empirically tuned constant

wb = waitbar(0, 'Harris corner detection');
% Loop exclues pixels near the boundaries of image
for i = 4:sz(1)-3
    waitbar((i-3)/(sz(1)-6));
    for j = 4:sz(2)-3
        ws = min([i-1, sz(1)-i, j-1, sz(2)-j, (h-1)/2]);  % Window size to use
        wts = W(c-ws:c+ws, c-ws:c+ws);  % Extract window for gaussian weights
        ix2 = Ix2(i-ws:i+ws, j-ws:j+ws);  % Extract Ix2 window
        iy2 = Iy2(i-ws:i+ws, j-ws:j+ws);  % Extract Iy2 window
        ixiy = IxIy(i-ws:i+ws, j-ws:j+ws);  % Extract IxIy window
        
        % Multiply by gaussian weights
        ix2 = ix2.*wts;
        iy2 = iy2.*wts;
        ixiy = ixiy.*wts;  
        
        % Compute the structure tensor
        ixiy = sum(ixiy(:));
        A = [sum(ix2(:)) ixiy; ixiy sum(iy2(:))];
        % TODO: Normalize instead of simply summing
        
        % Eigenvalues of the structure tensor
        e = eig(A);
        E1(i, j) = e(1);
        E2(i, j) = e(2);
        
        C(i, j) = det(A) - k * (trace(A)^2); 
    end
end

close(wb);

% Display the eigenvalue images
M1 = max(E1(:));
M2 = max(E2(:));
figure('Name', 'First eigenvalue'), imshow(E1, [0 M1]), colorbar, truesize;
figure('Name', 'Second eigenvalue'), imshow(E2, [0 M2]), colorbar, truesize;

% Display the Harris corner-ness measure
C1 = min(C(:));
C2 = max(C(:));
figure('Name', 'Harris corner-ness measure'), imshow(C, [C1 C2]), colorbar, truesize;

end